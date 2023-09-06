import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';
import 'package:todoproject/data/selection_model.dart';

class SelectionOptions extends StatefulWidget {
  final List<SelectionModel> selections;
  const SelectionOptions({super.key, required this.selections});

  @override
  State<SelectionOptions> createState() => _SelectionOptionsState();
}

class _SelectionOptionsState extends State<SelectionOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: ColorStyles.greyFBFBFC,
      ),
      padding: EdgeInsets.all(5.w),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.selections.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Row(
                  children: [
                    SvgPicture.asset(widget.selections[index].icon),
                    SizedBox(width: 14.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selections[index].title,
                          style: TextStyles.black16_500,
                        ),
                        Text(
                          widget.selections[index].subTitle,
                          style: TextStyles.grey14_500,
                        ),
                      ],
                    ),
                    const Spacer(),
                    SvgPicture.asset('assets/icons/right_arrow.svg'),
                  ],
                ),
              ),
              if (index != widget.selections.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: Container(
                    height: 1.h,
                    color: ColorStyles.grey828796.withOpacity(0.15),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
