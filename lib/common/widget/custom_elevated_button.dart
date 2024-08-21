import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.initialText,
    this.secondText,
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
  });

  final String initialText;
  final String? secondText;
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

  @override
  Widget build(Object context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildBtnWidget,
          )
        : buildBtnWidget;
  }

  Widget get buildBtnWidget => Container(
        height: height ?? 50.h,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration:
            decoration ?? CustomButtonStyles.gradientYellowAToPrimaryDecoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              secondText != null
                  ? AnimatedCrossFade(
                      firstChild: Text(
                        initialText,
                        style: buttonTextStyle,
                      ),
                      secondChild: Text(
                        secondText ?? "-",
                        style: buttonTextStyle,
                      ),
                      crossFadeState: secondText == null
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(seconds: 2))
                  : Text(
                      initialText,
                      style: buttonTextStyle,
                    ),
              rightIcon ?? const SizedBox.shrink()
            ],
          ),
        ),
      );
}
