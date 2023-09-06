import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';
import 'package:todoproject/data/hotel_model.dart';
import 'package:todoproject/data/selection_model.dart';
import 'package:todoproject/helpers/divide_price.dart';
import 'package:todoproject/presentation/room/room_page.dart';
import 'package:todoproject/presentation/widgets/carousel_photo.dart';
import 'package:todoproject/presentation/widgets/container_borderradius.dart';
import 'package:todoproject/presentation/widgets/custom_button.dart';
import 'package:todoproject/presentation/widgets/grid_tags.dart';
import 'package:todoproject/presentation/widgets/selection_options.dart';
import 'package:todoproject/presentation/widgets/star_container.dart';

class HotelPage extends StatelessWidget {
  final Hotel hotel;
  HotelPage({super.key, required this.hotel});

  final List<SelectionModel> selections = [
    SelectionModel(
      title: 'selections.title_1'.tr(),
      subTitle: 'selections.description'.tr(),
      icon: 'assets/icons/happy.svg',
    ),
    SelectionModel(
      title: 'selections.title_2'.tr(),
      subTitle: 'selections.description'.tr(),
      icon: 'assets/icons/tick.svg',
    ),
    SelectionModel(
      title: 'selections.title_3'.tr(),
      subTitle: 'selections.description'.tr(),
      icon: 'assets/icons/close.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        elevation: 0,
        title: Text(
          'hotel'.tr(),
          style: TextStyles.black18_500,
        ),
      ),
      backgroundColor: ColorStyles.greyF6F6F9,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorStyles.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      CarouselPhoto(images: hotel.imageUrls),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: StarContainer(
                          title: '${hotel.rating} ${hotel.ratingName}',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Text(
                          hotel.name ?? '-',
                          style: TextStyles.black22_500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Text(
                          hotel.adress ?? '-',
                          style: TextStyles.blue14_500,
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
                                    '${'from'.tr()} ${dividePrice(hotel.minimalPrice ?? 0)} ₽',
                                style: TextStyles.black30_600,
                              ),
                              TextSpan(
                                text: ' ${hotel.priceForIt?.toLowerCase()}',
                                style: TextStyles.grey16_400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                ContainerBorderRadius(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          'about_hotel'.tr(),
                          style: TextStyles.black22_500,
                        ),
                        SizedBox(height: 16.h),
                        TagsWidget(hotel.aboutTheHotel?.peculiarities ?? []),
                        SizedBox(height: 12.h),
                        Text(
                          hotel.aboutTheHotel?.description ?? '-',
                          style: TextStyles.black16_400,
                        ),
                        SizedBox(height: 16.h),
                        SelectionOptions(selections: selections),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
          Container(
            height: 88.h,
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
              color: ColorStyles.white,
              border: Border.all(
                width: 1.h,
                color: const Color(0xFFE8E9EC),
              ),
            ),
            child: CstmButton(
              title: 'select_room'.tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoomPage(
                      title: hotel.name ?? '-',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
