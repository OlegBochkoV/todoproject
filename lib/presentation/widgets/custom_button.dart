import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';

class CstmButton extends StatelessWidget {
  final String title;
  double? height;
  double? width;
  final Function() onTap;
  CstmButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Bounce(
        duration: const Duration(milliseconds: 100),
        onPressed: onTap,
        child: Container(
          height: height ?? 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: ColorStyles.blue0D72FF,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyles.white16_500,
            ),
          ),
        ),
      ),
    );
  }
}
