import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';

class StarContainer extends StatelessWidget {
  final String title;
  const StarContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.yellowFFC700.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: SvgPicture.asset('assets/icons/star.svg'),
              ),
              WidgetSpan(child: SizedBox(width: 2.w)),
              TextSpan(
                text: title,
                style: TextStyles.yellowFFA80016_500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
