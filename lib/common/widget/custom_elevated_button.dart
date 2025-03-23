import 'package:flutter/material.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

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
    this.width = double.maxFinite,
    this.margin,
    this.alignment,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.isLoading = false,
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
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildBtnWidget(context),
          )
        : buildBtnWidget(context);
  }

  Widget buildBtnWidget(BuildContext context) => Container(
        height: height ?? 50.h,
        width: width,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: isLoading
              ? CircularProgressIndicator(
                  color: theme(context).colorScheme.onSecondaryContainer)
              : Row(
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
