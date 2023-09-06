import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';
import 'package:todoproject/main.dart';
import 'package:todoproject/presentation/widgets/custom_button.dart';

class CongratulationPage extends StatelessWidget {
  const CongratulationPage({super.key});

  int getNumberTicket() {
    var random = Random();
    return random.nextInt(999999);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        elevation: 0,
        title: Text(
          'paid_success'.tr(),
          style: TextStyles.black18_500,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Transform.rotate(
            angle: pi,
            child: SvgPicture.asset('assets/icons/right_arrow.svg'),
          ),
        ),
      ),
      backgroundColor: ColorStyles.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 94.h,
                  width: 94.h,
                  decoration: BoxDecoration(
                    color: ColorStyles.greyF6F6F9,
                    borderRadius: BorderRadius.circular(1000.r),
                  ),
                  child: Center(
                    child: Text(
                      '🎉',
                      style: TextStyle(fontSize: 44.sp),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  'order_get_to_work'.tr(),
                  style: TextStyles.black22_500,
                ),
                SizedBox(height: 20.h),
                Text(
                  'paid_success_description'.tr(
                    args: [getNumberTicket().toString()],
                  ),
                  style: TextStyles.grey16_400,
                  textAlign: TextAlign.center,
                ),
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
              title: 'super'.tr(),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
