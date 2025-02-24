import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.alignment,
    this.width,
    this.boxDecoration,
    this.focusNode,
    this.icon,
    this.iconSize,
    this.autoFocus = false,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    this.value = "",
    this.items,
    this.prefix,
    this.prefixConstraint,
    this.contentPadding,
    this.inputBorder,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChange,
  });

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final FocusNode? focusNode;
  final Widget? icon;
  final double? iconSize;
  final bool? autoFocus;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final String value;
  final List<String>? items;
  final Widget? prefix;
  final BoxConstraints? prefixConstraint;
  final EdgeInsets? contentPadding;
  final InputBorder? inputBorder;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: dropDownWidget(context),
          )
        : dropDownWidget(context);
  }

  Widget dropDownWidget(BuildContext context) => Container(
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: DropdownButtonFormField(
          focusNode: focusNode,
          icon: icon,
          iconSize: iconSize ?? 24.h,
          autofocus: autoFocus!,
          style: textStyle ?? theme(context).textTheme.bodyMedium,
          hint: Text(
            hintText ?? "",
            style: hintStyle ?? theme(context).textTheme.bodyMedium,
          ),
          value: value,
          items: items?.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ?? theme(context).textTheme.bodyMedium,
                ),
              );
            },
          ).toList(),
          decoration: decoration(context),
          validator: validator,
          onChanged: (value) {
            onChange!(value.toString());
          },
        ),
      );

  InputDecoration decoration(BuildContext context) => InputDecoration(
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraint,
        isDense: true,
        contentPadding:
            contentPadding ?? EdgeInsets.fromLTRB(10.h, 10.h, 8.h, 10.h),
        fillColor: fillColor ??
            theme(context)
                .colorScheme
                .onSecondaryContainer
                .withValues(alpha: 0.3),
        filled: filled,
        border: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadiusStyle.roundedBorder10,
              borderSide: BorderSide(
                color: theme(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withValues(alpha: 0.6),
                width: 1.0,
              ),
            ),
        focusedBorder: (inputBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadiusStyle.roundedBorder10))
            .copyWith(
          borderSide: BorderSide(
            color: theme(context).colorScheme.onPrimaryContainer,
            width: 1.0,
          ),
        ),
      );
}
