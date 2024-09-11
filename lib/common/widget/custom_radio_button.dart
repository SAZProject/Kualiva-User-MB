import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

extension RadioStyleHelper on CustomRadioButton {
  static BoxDecoration fillOnPrimaryContainer(BuildContext context) =>
      BoxDecoration(
        color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.h),
      );

  static BoxDecoration fillOnSecondaryContainer(BuildContext context) =>
      BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.h),
      );
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.groupValue,
    required this.onChange,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.gradient,
    this.backgroundColor,
  });

  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final String? value;
  final String? groupValue;
  final Function(String) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final Gradient? gradient;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildRadioButtonWidget(context),
          )
        : buildRadioButtonWidget(context);
  }

  bool get isGradient => gradient != null;
  BoxDecoration get gradientDecoration => BoxDecoration(gradient: gradient);
  Widget buildRadioButtonWidget(BuildContext context) => InkWell(
        onTap: () => onChange(value!),
        child: Container(
          decoration: decoration,
          width: width,
          padding: padding,
          child: (isRightCheck ?? false)
              ? rightSideRadioButton(context)
              : leftSideRadioButton(context),
        ),
      );
  Widget leftSideRadioButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: radioButtonWidget,
          ),
          textWidget(context),
        ],
      );
  Widget rightSideRadioButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(context),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: radioButtonWidget,
          ),
        ],
      );
  Widget textWidget(BuildContext context) => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.start,
        style: textStyle ?? theme(context).textTheme.bodyMedium,
      );
  Widget get radioButtonWidget => SizedBox(
        height: iconSize,
        width: iconSize,
        child: Radio<String>(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? "",
          groupValue: groupValue,
          onChanged: (value) => onChange(value!),
        ),
      );
  BoxDecoration get radioButtonDecoration =>
      BoxDecoration(color: backgroundColor);
}
