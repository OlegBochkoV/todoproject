import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoproject/data/api/service/hotel_service.dart';
import 'package:todoproject/domain/state/hotel_event.dart';
import 'package:todoproject/domain/state/hotel_state.dart';

class HotelScreenBloc extends Bloc<HotelEvent, HotelState> {
  HotelScreenBloc() : super(InitState()) {
    on<GetHotelInfoEvent>(_getHotelApi);
    on<GetRoomsInfoEvent>(_getRoomsApi);
    on<GetReservedInfoEvent>(_getReservedApi);
    on<CheckFieldsEvent>(_checkFields);
  }

  final hotelService = HotelService();

  void _getHotelApi(GetHotelInfoEvent event, Emitter<HotelState> emit) async {
    emit(LoadingState());
    final data = await hotelService.getHotel();
    emit(LoadHotel(hotel: data));
  }

  void _getRoomsApi(GetRoomsInfoEvent event, Emitter<HotelState> emit) async {
    emit(LoadingState());
    final data = await hotelService.getRooms();
    emit(LoadRooms(rooms: data));
  }

  void _getReservedApi(
      GetReservedInfoEvent event, Emitter<HotelState> emit) async {
    emit(LoadingState());
    final data = await hotelService.getReserved();
    emit(LoadReserved(reserved: data));
  }

  void _checkFields(CheckFieldsEvent event, Emitter<HotelState> emit) =>
      emit(CheckFieldsState());
}
