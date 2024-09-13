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
    this.boxDecoration,
    this.alignment,
    this.isRightCheck = false,
    this.iconSize,
    this.value,
    this.groupValue,
    required this.onChange,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
  });

  final BoxDecoration? boxDecoration;
  final Alignment? alignment;
  final bool isRightCheck;
  final double? iconSize;
  final String? value;
  final String? groupValue;
  final Function(String) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildRadioButtonWidget(context),
          )
        : buildRadioButtonWidget(context);
  }

  Widget buildRadioButtonWidget(BuildContext context) => InkWell(
        onTap: () => onChange(value!),
        child: Container(
          decoration: boxDecoration,
          width: width,
          padding: padding,
          child: isRightCheck
              ? rightSideRadioButton(context)
              : leftSideRadioButton(context),
        ),
      );
  Widget leftSideRadioButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: radioButtonWidget(context),
          ),
          textWidget(context),
        ],
      );
  Widget rightSideRadioButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textWidget(context),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: radioButtonWidget(context),
          ),
        ],
      );
  Widget textWidget(BuildContext context) => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.start,
        style: textStyle ?? theme(context).textTheme.bodyMedium,
      );
  Widget radioButtonWidget(BuildContext context) => SizedBox(
        height: iconSize,
        width: iconSize,
        child: Radio<String>(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
            return (states.contains(WidgetState.selected))
                ? theme(context).colorScheme.primary
                : theme(context).colorScheme.onPrimaryContainer;
          }),
          // activeColor: theme(context).colorScheme.primary,
          value: value ?? "",
          groupValue: groupValue,
          onChanged: (value) => onChange(value!),
        ),
      );
}
