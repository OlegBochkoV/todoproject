import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';

class BlueContainer extends StatelessWidget {
  final String title;
  const BlueContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.blue0D72FF.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyles.blue16_500,
              ),
              WidgetSpan(child: SizedBox(width: 10.w)),
              WidgetSpan(
                child: SvgPicture.asset(
                  'assets/icons/right_arrow.svg',
                  color: ColorStyles.blue0D72FF,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
