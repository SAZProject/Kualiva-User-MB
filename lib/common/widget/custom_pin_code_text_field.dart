import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField(
      {super.key,
      required this.context,
      required this.onChange,
      required this.onCompleted,
      this.alignment,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.validator});

  final BuildContext context;
  final Alignment? alignment;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Function(String) onChange;
  final Function(String) onCompleted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextField,
          )
        : pinCodeTextField;
  }

  Widget get pinCodeTextField => PinCodeTextField(
        appContext: context,
        focusNode: FocusNode(),
        autoFocus: true,
        length: 6,
        controller: controller,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? CustomTextStyles(context).onSecondaryContainer,
        hintStyle: textStyle ?? CustomTextStyles(context).onSecondaryContainer,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 60.h,
          fieldWidth: 40.h,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.h),
          inactiveFillColor: appTheme.white,
        ),
        onChanged: (value) => onChange(value),
        onCompleted: (value) => onCompleted(value),
        validator: validator,
      );
}
