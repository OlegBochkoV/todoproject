import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';
import 'package:todoproject/data/tourist_model.dart';
import 'package:todoproject/domain/state/hotel_bloc.dart';
import 'package:todoproject/domain/state/hotel_state.dart';
import 'package:todoproject/presentation/widgets/container_borderradius.dart';
import 'package:todoproject/presentation/widgets/custom_textField.dart';

class ItemTourist extends StatefulWidget {
  TouristModel tourist;
  ItemTourist({
    super.key,
    required this.tourist,
  });

  @override
  State<ItemTourist> createState() => _ItemTouristState();
}

class _ItemTouristState extends State<ItemTourist> {
  @override
  void initState() {
    super.initState();
    open = widget.tourist.index != 0;
    firstnameController.text = widget.tourist.firstName ?? '';
    secondnameController.text = widget.tourist.lastName ?? '';
    dateController.text = widget.tourist.datebirthday ?? '';
    citizenController.text = widget.tourist.citizen ?? '';
    numberZagPasController.text = widget.tourist.numberPassport ?? '';
    dateZagPasController.text = widget.tourist.dateEndPassport ?? '';
  }

  late bool open;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController secondnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController citizenController = TextEditingController();
  TextEditingController numberZagPasController = TextEditingController();
  TextEditingController dateZagPasController = TextEditingController();

  bool? validFirstname;
  bool? validSecondname;
  bool? validDate;
  bool? validCitizen;
  bool? validNumberPassport;
  bool? validDateEndPassport;

  void checkFields() {
    validFirstname = widget.tourist.firstName?.isEmpty ?? true;
    validSecondname = widget.tourist.lastName?.isEmpty ?? true;
    validDate = widget.tourist.datebirthday?.isEmpty ?? true;
    validCitizen = widget.tourist.citizen?.isEmpty ?? true;
    validNumberPassport = widget.tourist.numberPassport?.isEmpty ?? true;
    validDateEndPassport = widget.tourist.dateEndPassport?.isEmpty ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelScreenBloc, HotelState>(
      buildWhen: (previous, current) {
        if (current is CheckFieldsState) {
          checkFields();
          return true;
        }
        return false;
      },
      builder: (context, snapshot) {
        return ContainerBorderRadius(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(bottom: 12.h),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: open ? 32.h : 410.h,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  children: [
                    Text(
                      '${getName(widget.tourist.index)} турист',
                      style: TextStyles.black22_500,
                    ),
                    const Spacer(),
                    Bounce(
                      duration: const Duration(milliseconds: 100),
                      onPressed: () {
                        open = !open;
                        setState(() {});
                      },
                      child: Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: ColorStyles.blue0D72FF.withOpacity(0.1),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.rotate(
                              angle: open ? pi / 2 : -pi / 2,
                              child: SvgPicture.asset(
                                'assets/icons/right_arrow.svg',
                                color: ColorStyles.blue0D72FF,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelText: 'Имя',
                  height: 32.h,
                  fillColor: ColorStyles.greyF6F6F9,
                  validate: validFirstname,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  textEditingController: firstnameController,
                  onChanged: (value) => widget.tourist.firstName = value,
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  labelText: 'Фамилия',
                  height: 32.h,
                  fillColor: ColorStyles.greyF6F6F9,
                  validate: validSecondname,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  textEditingController: secondnameController,
                  onChanged: (value) => widget.tourist.lastName = value,
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  labelText: 'Дата рождения',
                  height: 32.h,
                  fillColor: ColorStyles.greyF6F6F9,
                  validate: validDate,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  textEditingController: dateController,
                  onChanged: (value) => widget.tourist.datebirthday = value,
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  labelText: 'Гражданство',
                  height: 32.h,
                  fillColor: ColorStyles.greyF6F6F9,
                  validate: validCitizen,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  textEditingController: citizenController,
                  onChanged: (value) => widget.tourist.citizen = value,
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  labelText: 'Номер загранпаспорта',
                  height: 32.h,
                  fillColor: ColorStyles.greyF6F6F9,
                  validate: validNumberPassport,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  textEditingController: numberZagPasController,
                  onChanged: (value) => widget.tourist.numberPassport = value,
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  labelText: 'Срок действия загранпаспорта',
                  height: 32.h,
                  fillColor: ColorStyles.greyF6F6F9,
                  validate: validDateEndPassport,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  textEditingController: dateZagPasController,
                  onChanged: (value) => widget.tourist.dateEndPassport = value,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String getName(int index) {
  if (index == 0) return 'Первый';
  if (index == 1) return 'Второй';
  if (index == 2) return 'Третий';
  if (index == 3) return 'Четвертый';
  if (index == 4) return 'Пятый';
  if (index == 5) return 'Шестой';
  if (index == 6) return 'Седьмой';
  if (index == 7) return 'Восьмой';
  if (index == 8) return 'Девятый';
  if (index == 9) return 'Десятый';
  return '$index';
}
