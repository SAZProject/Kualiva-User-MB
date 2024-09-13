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
    required this.onChange,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
    this.isRichtext = false,
    this.richTextWidget = const SizedBox(),
  });

  final BoxDecoration? boxDecoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final bool? value;
  final Function(bool) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final bool isExpandedText;
  final bool isRichtext;
  final Widget richTextWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildCheckboxWidget(context),
          )
        : buildCheckboxWidget(context);
  }

  Widget buildCheckboxWidget(BuildContext context) => Container(
        decoration: boxDecoration,
        width: width,
        padding: padding,
        child: (isRightCheck ?? false)
            ? rightSideCheckbox(context)
            : leftSideCheckbox(context),
      );
  Widget leftSideCheckbox(BuildContext context) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: checkboxWidget(context),
          ),
          isExpandedText
              ? Expanded(
                  child: isRichtext ? richTextWidget : textWidget(context))
              : isRichtext
                  ? richTextWidget
                  : textWidget(context),
        ],
      );
  Widget rightSideCheckbox(BuildContext context) => Row(
        children: [
          isExpandedText
              ? Expanded(
                  child: isRichtext ? richTextWidget : textWidget(context))
              : isRichtext
                  ? richTextWidget
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
