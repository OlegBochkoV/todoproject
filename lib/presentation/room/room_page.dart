import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';
import 'package:todoproject/data/room_model.dart';
import 'package:todoproject/domain/state/hotel_bloc.dart';
import 'package:todoproject/domain/state/hotel_event.dart';
import 'package:todoproject/domain/state/hotel_state.dart';
import 'package:todoproject/helpers/divide_price.dart';
import 'package:todoproject/presentation/reserved/reserved_page.dart';
import 'package:todoproject/presentation/widgets/blue_container.dart';
import 'package:todoproject/presentation/widgets/carousel_photo.dart';
import 'package:todoproject/presentation/widgets/container_borderradius.dart';
import 'package:todoproject/presentation/widgets/custom_button.dart';
import 'package:todoproject/presentation/widgets/grid_tags.dart';

class RoomPage extends StatefulWidget {
  final String title;
  const RoomPage({
    super.key,
    required this.title,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<Room> rooms = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HotelScreenBloc>(context)
        .add(GetRoomsInfoEvent()); // get list roms data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyles.black18_500,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Transform.rotate(
            angle: pi,
            child: SvgPicture.asset('assets/icons/right_arrow.svg'),
          ),
        ),
      ),
      backgroundColor: ColorStyles.greyF6F6F9,
      body: BlocBuilder<HotelScreenBloc, HotelState>(
        buildWhen: (previous, current) {
          if (current is LoadRooms) {
            rooms = current.rooms;
          }
          return true;
        },
        builder: (context, snapshot) {
          if (snapshot is LoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 8.h),
              Column(
                children: rooms
                    .map(
                      (e) => ContainerBorderRadius(
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            CarouselPhoto(images: e.imageUrls),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                e.name ?? '-',
                                style: TextStyles.black22_500,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: TagsWidget(
                                e.peculiarities ?? [],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: BlueContainer(
                                title: 'more_info_room'.tr(),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${'from'.tr()} ${dividePrice(e.price ?? 0)} ₽',
                                      style: TextStyles.black30_600,
                                    ),
                                    TextSpan(
                                      text: ' ${e.pricePer}',
                                      style: TextStyles.grey16_400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: CstmButton(
                                title: 'select_room_v2'.tr(),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ReservedPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 12.h),
            ],
          );
        },
      ),
    );
  }
}
