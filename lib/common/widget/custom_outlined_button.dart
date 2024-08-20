import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_text_style.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
      required this.initialText,
      this.onPressed,
      this.buttonStyle,
      this.buttonTextStyle,
      this.isDisabled,
      this.height,
      this.width,
      this.margin,
      this.alignment,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label});

  final String initialText;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;
  final bool? isDisabled;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget get buildOutlinedButton => Container(
        height: height ?? 50,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                initialText,
                style: buttonTextStyle ?? CustomTextStyles.titlesmall_15,
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
