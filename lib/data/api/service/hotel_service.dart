import 'package:dio/dio.dart';
import 'package:todoproject/constants/server.dart';
import 'package:todoproject/data/hotel_model.dart';
import 'package:todoproject/data/reserved_model.dart';
import 'package:todoproject/data/room_model.dart';

class HotelService {
  final Dio _dio = Dio(BaseOptions(baseUrl: BASE_URL));

  Future<Hotel> getHotel() async {
    final response = await _dio.get('/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3');
    return Hotel.fromJson(response.data);
  }

  Future<List<Room>> getRooms() async {
    final response = await _dio.get('/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd');
    List<Room> rooms = [];
    for (var element in response.data['rooms']) {
      rooms.add(Room.fromJson(element));
    }
    return rooms;
  }

  Future<Reserved> getReserved() async {
    final response = await _dio.get('/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8');
    return Reserved.fromJson(response.data);
  }
}
