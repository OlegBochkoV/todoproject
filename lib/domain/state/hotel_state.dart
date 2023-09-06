import 'package:todoproject/data/hotel_model.dart';
import 'package:todoproject/data/reserved_model.dart';
import 'package:todoproject/data/room_model.dart';

class HotelState {}

class InitState extends HotelState {}

class LoadingState extends HotelState {}

class LoadHotel extends HotelState {
  Hotel hotel;
  LoadHotel({required this.hotel});
}

class LoadRooms extends HotelState {
  List<Room> rooms;
  LoadRooms({required this.rooms});
}

class LoadReserved extends HotelState {
  Reserved reserved;
  LoadReserved({required this.reserved});
}

class CheckFieldsState extends HotelState {}
