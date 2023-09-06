import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';

class TagsWidget extends StatelessWidget {
  List<String> tags = [];
  TagsWidget(this.tags, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.h,
      spacing: 8.h,
      children: tags
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: ColorStyles.greyFBFBFC,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                e,
                style: TextStyles.grey16_500,
              ),
            ),
          )
          .toList(),
    );
  }
}
