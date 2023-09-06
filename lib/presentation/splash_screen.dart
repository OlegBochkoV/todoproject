import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoproject/domain/state/hotel_bloc.dart';
import 'package:todoproject/domain/state/hotel_event.dart';
import 'package:todoproject/domain/state/hotel_state.dart';
import 'package:todoproject/presentation/hotel/hotel_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HotelScreenBloc>(context)
        .add(GetHotelInfoEvent()); // get hotel data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HotelScreenBloc, HotelState>(
        buildWhen: (previous, current) {
          if (current is LoadHotel) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HotelPage(hotel: current.hotel),
              ),
              (route) => false,
            );
          }
          return true;
        },
        builder: (context, snapshot) {
          if (snapshot is LoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}
