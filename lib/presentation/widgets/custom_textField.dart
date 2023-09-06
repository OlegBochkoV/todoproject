import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoproject/constants/styles/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final Function? onTap;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final String? hintText;
  final Icon? icon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController textEditingController;
  final TextCapitalization? textCapitalization;
  final Color? mainColor;
  final Color? bgColor;
  final int? maxLines;
  final List<TextInputFormatter>? formatters;
  final TextInputType? textInputType;
  final bool? obscureText;
  final FormFieldValidator<String>? validateFunction;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? prefixIcon;
  final String? prefixText;
  final bool? enabled;
  final Color? fillColor;
  final bool? autocorrect;
  final double height;
  double? width;
  TextStyle? hintStyle;
  TextStyle? style;
  String? labelText;
  TextStyle? labelStyle;
  EdgeInsets? contentPadding;
  bool dismissTap;
  bool actionButton;
  TextDirection? textDirection;
  bool? validate;
  CustomTextField({
    super.key,
    this.validate,
    this.dismissTap = false,
    this.actionButton = true,
    this.onTap,
    this.readOnly,
    this.inputAction,
    this.focusNode,
    this.hintText,
    this.icon,
    this.onChanged,
    this.onFieldSubmitted,
    required this.textEditingController,
    this.mainColor,
    this.bgColor,
    this.maxLines,
    this.formatters,
    this.textInputType,
    this.obscureText,
    this.validateFunction,
    this.suffix,
    this.suffixIcon,
    this.suffixText,
    this.prefixIcon,
    this.prefixText,
    this.enabled,
    required this.fillColor,
    this.hintStyle,
    this.style,
    this.labelText,
    this.labelStyle,
    required this.height,
    this.width,
    this.contentPadding = EdgeInsets.zero,
    this.textCapitalization,
    this.autocorrect,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        height: height + 20.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height + 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: validate == null || (validate != null && !validate!)
                    ? null
                    : Border.all(
                        width: 1,
                        color: const Color(0xFFEB5757).withOpacity(0.85),
                      ),
                color: fillColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SizedBox(
                height: height,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  textDirection: textDirection,
                  autocorrect: true,
                  onFieldSubmitted: onFieldSubmitted,
                  enabled: enabled,
                  focusNode: focusNode,
                  onTap: onTap as void Function()?,
                  validator: validateFunction,
                  readOnly: readOnly ?? false,
                  textInputAction: inputAction,
                  controller: textEditingController,
                  onChanged: onChanged,
                  obscureText: obscureText ?? false,
                  maxLines: maxLines ?? 1,
                  minLines: 1,
                  inputFormatters: formatters,
                  keyboardType: textInputType,
                  style: style ?? TextStyles.black14142B16_400,
                  decoration: InputDecoration(
                    fillColor: fillColor,
                    icon: icon,
                    prefixIcon: prefixIcon,
                    suffixText: suffixText,
                    suffix: suffix,
                    prefixText: prefixText,
                    suffixIcon: suffixIcon,
                    contentPadding: contentPadding,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color(0xFFEB5757),
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    hintText: hintText,
                    labelText: labelText,
                    labelStyle: labelStyle ?? TextStyles.grey17_400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
