import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_text_style.dart';
import 'package:like_it/common/utility/sized_utils.dart';
import 'package:like_it/common/widget/base_button.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton(
      {super.key,
      required super.text,
      super.onPressed,
      super.buttonStyle,
      super.buttonTextStyle,
      super.isDisabled,
      super.height,
      super.width,
      super.margin,
      super.alignment,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label});

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButton(context),
          )
        : buildOutlinedButton(context);
  }

  Widget buildOutlinedButton(BuildContext context) => Container(
        height: height ?? 50.h,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style:
                    buttonTextStyle ?? CustomTextStyles(context).titlesmall_15,
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
