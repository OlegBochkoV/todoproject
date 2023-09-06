import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:todoproject/constants/colors/color_styles.dart';
import 'package:todoproject/constants/styles/text_styles.dart';
import 'package:todoproject/data/reserved_model.dart';
import 'package:todoproject/data/tourist_model.dart';
import 'package:todoproject/domain/state/hotel_bloc.dart';
import 'package:todoproject/domain/state/hotel_event.dart';
import 'package:todoproject/domain/state/hotel_state.dart';
import 'package:todoproject/helpers/divide_price.dart';
import 'package:todoproject/helpers/validators.dart';
import 'package:todoproject/presentation/congratulation/congratulation.dart';
import 'package:todoproject/presentation/widgets/container_borderradius.dart';
import 'package:todoproject/presentation/widgets/custom_button.dart';
import 'package:todoproject/presentation/widgets/custom_textField.dart';
import 'package:todoproject/presentation/widgets/item_tourist.dart';
import 'package:todoproject/presentation/widgets/star_container.dart';

class ReservedPage extends StatefulWidget {
  const ReservedPage({
    super.key,
  });

  @override
  State<ReservedPage> createState() => _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {
  Reserved? reserved;
  final List<TouristModel> _listTourists = [
    TouristModel(index: 0),
  ];

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HotelScreenBloc>(context)
        .add(GetReservedInfoEvent()); // get reserved data
  }

  bool? validPhone;
  bool? validEmail;

  void checkFields() {
    validPhone = phoneController.text.isEmpty;
    if (emailController.text.isEmpty) {
      validEmail = true;
    } else {
      validEmail = validateEmail(emailController.text);
    }

    bool checkAllTouristsFields = false;
    for (var element in _listTourists) {
      if (element.firstName == null ||
          (element.firstName != null && element.firstName!.isEmpty)) {
        checkAllTouristsFields = true;
        break;
      } else if (element.lastName == null ||
          (element.lastName != null && element.lastName!.isEmpty)) {
        checkAllTouristsFields = true;
        break;
      } else if (element.datebirthday == null ||
          (element.datebirthday != null && element.datebirthday!.isEmpty)) {
        checkAllTouristsFields = true;
        break;
      } else if (element.citizen == null ||
          (element.citizen != null && element.citizen!.isEmpty)) {
        checkAllTouristsFields = true;
        break;
      } else if (element.numberPassport == null ||
          (element.numberPassport != null && element.numberPassport!.isEmpty)) {
        checkAllTouristsFields = true;
        break;
      } else if (element.dateEndPassport == null ||
          (element.dateEndPassport != null &&
              element.dateEndPassport!.isEmpty)) {
        checkAllTouristsFields = true;
        break;
      }
    }

    if (!checkAllTouristsFields) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CongratulationPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.white,
        elevation: 0,
        title: Text(
          'booking'.tr(),
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
          if (current is LoadReserved) {
            reserved = current.reserved;
          }
          if (current is CheckFieldsState) {
            checkFields();
          }
          return true;
        },
        builder: (context, snapshot) {
          if (snapshot is LoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 8.h),
                    infoHotel(),
                    SizedBox(height: 8.h),
                    additionalInfo(),
                    SizedBox(height: 12.h),
                    infoClient(),
                    SizedBox(height: 12.h),
                    Column(
                      children: _listTourists
                          .map(
                            (e) => ItemTourist(
                              tourist: e,
                            ),
                          )
                          .toList(),
                    ),
                    addTourist(),
                    SizedBox(height: 12.h),
                    infoPrice(),
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
                  title:
                      '${'paid'.tr()} ${dividePrice((reserved?.tourPrice ?? 0) + (reserved?.fuelCharge ?? 0) + (reserved?.serviceCharge ?? 0))} ₽',
                  onTap: () {
                    BlocProvider.of<HotelScreenBloc>(context)
                        .add(CheckFieldsEvent());
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget infoHotel() {
    return ContainerBorderRadius(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StarContainer(title: '${reserved?.horating} ${reserved?.ratingName}'),
          SizedBox(height: 8.h),
          Text(
            reserved?.hotelName ?? '-',
            style: TextStyles.black22_500,
          ),
          SizedBox(height: 8.h),
          Text(
            reserved?.hotelAdress ?? '-',
            style: TextStyles.blue14_500,
          ),
        ],
      ),
    );
  }

  Widget additionalInfo() {
    return ContainerBorderRadius(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.from'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  reserved?.departure ?? '-',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.country_city'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  reserved?.arrivalCountry ?? '-',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.dates'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  '${reserved?.tourDateStart} - ${reserved?.tourDateStop}',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.count_night'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  reserved?.numberOfNights.toString() ?? '-',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.hotel'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  reserved?.hotelName ?? '-',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.room'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  reserved?.room ?? '-',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.dinner'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Expanded(
                child: Text(
                  reserved?.nutrition ?? '-',
                  style: TextStyles.black16_400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget infoClient() {
    return ContainerBorderRadius(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Информация о покупателе',
            style: TextStyles.black22_500,
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            labelText: 'Номер телефона',
            height: 32.h,
            textInputType: TextInputType.phone,
            inputAction: TextInputAction.done,
            fillColor: ColorStyles.greyF6F6F9,
            validate: validPhone,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            textEditingController: phoneController,
            hintText: '+7 (***) ***-**-**',
            formatters: [
              MaskTextInputFormatter(
                mask: '+7 (###) ###-##-##',
                filter: {"#": RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.eager,
              ),
              LengthLimitingTextInputFormatter(18),
            ],
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            labelText: 'Почта',
            height: 32.h,
            fillColor: ColorStyles.greyF6F6F9,
            validate: validEmail,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            textEditingController: emailController,
            onFieldSubmitted: (value) {
              checkFields();
              setState(() {});
            },
          ),
          SizedBox(height: 8.h),
          Text(
            'Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
            style: TextStyles.grey14_400,
          ),
        ],
      ),
    );
  }

  Widget addTourist() {
    return ContainerBorderRadius(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Text(
            'Добавить туриста',
            style: TextStyles.black22_500,
          ),
          const Spacer(),
          Bounce(
            duration: const Duration(milliseconds: 100),
            onPressed: () {
              _listTourists.add(TouristModel(index: _listTourists.length));
              setState(() {});
            },
            child: Container(
              height: 32.h,
              width: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: ColorStyles.blue0D72FF,
              ),
              child: SvgPicture.asset('assets/icons/add.svg'),
            ),
          )
        ],
      ),
    );
  }

  Widget infoPrice() {
    return ContainerBorderRadius(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.tour'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Text(
                '${dividePrice(reserved?.tourPrice ?? 0)} ₽',
                style: TextStyles.black16_400,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.fuel_tax'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Text(
                '${dividePrice(reserved?.fuelCharge ?? 0)} ₽',
                style: TextStyles.black16_400,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.service_tax'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Text(
                '${dividePrice(reserved?.serviceCharge ?? 0)} ₽',
                style: TextStyles.black16_400,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'reserved.result_paid'.tr(),
                  style: TextStyles.grey16_400,
                ),
              ),
              Text(
                '${dividePrice((reserved?.tourPrice ?? 0) + (reserved?.fuelCharge ?? 0) + (reserved?.serviceCharge ?? 0))} ₽',
                style: TextStyles.blue16_600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
