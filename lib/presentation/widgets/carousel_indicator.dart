import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoproject/constants/colors/color_styles.dart';

class CarouselIndicator extends StatelessWidget {
  final int carouselIndex;
  final int? length;
  final MainAxisAlignment? mainAxisAlignment;
  final Color? colorSelect;
  const CarouselIndicator({
    Key? key,
    required this.carouselIndex,
    this.length = 4,
    this.mainAxisAlignment,
    this.colorSelect = ColorStyles.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: ColorStyles.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<int>.generate(length!, (i) => i)
            .map(
              (e) => AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                duration: const Duration(milliseconds: 300),
                width: 7.w,
                height: 7.w,
                decoration: BoxDecoration(
                  color: carouselIndex == e
                      ? colorSelect
                      : colorSelect?.withOpacity(0.17),
                  borderRadius: BorderRadius.circular(30.w),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
