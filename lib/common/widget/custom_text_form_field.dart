import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_text_style.dart';
import 'package:like_it/common/style/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.alignment,
      this.width,
      this.boxDecoration,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autoFocus,
      this.textStyle,
      this.obscureText,
      this.readOnly,
      this.onPressed,
      this.textInputAction,
      this.textInputType,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.inputBorder,
      this.fillColor,
      this.filled,
      this.validator});

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? inputBorder;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => Container(
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (event) {
            if (focusNode != null) {
              focusNode?.unfocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          autofocus: autoFocus!,
          style: textStyle ?? CustomTextStyles.bodyMediumOnPrimaryContainer_06,
          obscureText: obscureText!,
          readOnly: readOnly!,
          onTap: onPressed,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "-",
        hintStyle: hintStyle ?? CustomTextStyles.bodyLargeOnPrimaryContainer_06,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 16.0,
            ),
        fillColor: fillColor ?? theme.colorScheme.onPrimaryContainer,
        filled: filled,
        border: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
                width: 1,
              ),
            ),
        enabledBorder: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
                width: 1,
              ),
            ),
        focusedBorder: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
                width: 1,
              ),
            ),
      );
}
