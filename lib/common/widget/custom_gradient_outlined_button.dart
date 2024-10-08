import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/base_button.dart';
import 'package:like_it/common/widget/custom_outlined_button.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class CustomGradientOutlinedButton extends BaseButton {
  const CustomGradientOutlinedButton({
    super.key,
    required super.text,
    super.onPressed,
    super.buttonStyle,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.margin,
    super.alignment,
    required this.outerPadding,
    this.innerPadding = EdgeInsets.zero,
    required this.strokeWidth,
    required this.colors,
    required this.textStyle,
  });

  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final double strokeWidth;
  final List<Color> colors;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildGradientOulinedBtn(context),
          )
        : _buildGradientOulinedBtn(context);
  }

  Widget _buildGradientOulinedBtn(BuildContext context) => Padding(
        padding: outerPadding,
        child: OutlineGradientButton(
          padding: innerPadding,
          strokeWidth: strokeWidth,
          gradient: LinearGradient(
            begin: const Alignment(0.5, 0),
            end: const Alignment(0.5, 1),
            colors: colors,
          ),
          corners: const Corners(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          child: CustomOutlinedButton(
            text: text,
            buttonStyle: buttonStyle ?? CustomButtonStyles.outlineTranparent,
            buttonTextStyle: textStyle,
            onPressed: onPressed,
          ),
        ),
      );
}
