import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class CustomCheckboxButton extends StatelessWidget {
  const CustomCheckboxButton({
    super.key,
    this.boxDecoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value = false,
    this.onPressed,
    required this.onChange,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  });

  final BoxDecoration? boxDecoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final bool? value;
  final Function()? onPressed;
  final Function(bool) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final bool isExpandedText;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildCheckboxWidget(context),
          )
        : buildCheckboxWidget(context);
  }

  Widget buildCheckboxWidget(BuildContext context) => InkWell(
        onTap: () => onPressed,
        child: Container(
          decoration: boxDecoration,
          width: width,
          padding: padding,
          child: (isRightCheck ?? false)
              ? rightSideCheckbox(context)
              : leftSideCheckbox(context),
        ),
      );
  Widget leftSideCheckbox(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: checkboxWidget(context),
          ),
          isExpandedText
              ? Expanded(child: textWidget(context))
              : textWidget(context),
        ],
      );
  Widget rightSideCheckbox(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isExpandedText
              ? Expanded(child: textWidget(context))
              : textWidget(context),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: checkboxWidget(context),
          ),
        ],
      );
  Widget textWidget(BuildContext context) => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.start,
        style: textStyle ?? theme(context).textTheme.titleMedium,
      );
  Widget checkboxWidget(BuildContext context) => SizedBox(
        height: iconSize ?? 14.h,
        width: iconSize ?? 14.h,
        child: Checkbox(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? false,
          checkColor: theme(context).colorScheme.primary,
          onChanged: (value) => onChange(value!),
        ),
      );
}
