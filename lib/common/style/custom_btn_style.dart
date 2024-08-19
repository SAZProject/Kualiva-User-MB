import 'package:flutter/material.dart';
import 'package:like_it/common/style/theme_helper.dart';

class CustomButtonStyles {
  //filled button style
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  //gradient button style
  static BoxDecoration get gradientYellowAToPrimaryDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [appTheme.yellowA700, theme.colorScheme.primary],
        ),
      );

  static BoxDecoration get gradientYellowAToPrimaryL10Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [appTheme.yellowA700, theme.colorScheme.primary],
        ),
      );

  //text button style
  static ButtonStyle get none => const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      elevation: WidgetStatePropertyAll(0),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.transparent)));
}
