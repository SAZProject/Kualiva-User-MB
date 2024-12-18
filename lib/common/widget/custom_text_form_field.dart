import 'package:flutter/material.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineBlackTL24 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.h),
        borderSide: BorderSide(
          color: appTheme.black900.withOpacity(0.6),
          width: 1,
        ),
      );

  static OutlineInputBorder get fillOnSecondaryContainer => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );

  static OutlineInputBorder get underlineBlack => OutlineInputBorder(
        borderSide: BorderSide(
          color: appTheme.black900,
        ),
      );
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.boxDecoration,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autoFocus = false,
    this.textStyle,
    this.obscureText = false,
    this.readOnly = false,
    this.onPressed,
    this.onChange,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
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
    this.filled = true,
    this.validator,
  });

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
  final void Function(String value)? onChange;
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

  Widget textFormFieldWidget(BuildContext context) {
    return Container(
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
        style: textStyle ??
            CustomTextStyles(context).bodyMediumOnPrimaryContainer_06.copyWith(
                  color: theme(context).colorScheme.onPrimaryContainer,
                ),
        obscureText: obscureText!,
        readOnly: readOnly!,
        onTap: onPressed,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: decoration(context),
        validator: validator,
        onChanged: onChange,
      ),
    );
  }

  InputDecoration decoration(BuildContext context) {
    // return InputDecoration(
    //   labelText: 'Enter Text',
    //   labelStyle: TextStyle(color: Colors.blue),
    //   hintText: 'e.g., Hello123',
    //   hintStyle: TextStyle(color: Colors.grey),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.blue),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.green, width: 2),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.red, width: 2),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.red, width: 2),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // );
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle:
          hintStyle ?? CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      isDense: true,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 16.h,
          ),
      fillColor: fillColor ?? theme(context).colorScheme.onSecondaryContainer,
      filled: filled,
      border: inputBorder ?? _defaultOutlinedInputBorder(context),
      enabledBorder: inputBorder ?? _defaultOutlinedInputBorder(context),
      focusedBorder: inputBorder ?? _defaultOutlinedInputBorder(context),
    );
  }

  OutlineInputBorder _defaultOutlinedInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.h),
      borderSide: BorderSide(
        color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
        width: 1,
      ),
    );
  }
}
