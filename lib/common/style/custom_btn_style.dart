import 'package:flutter/material.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class CustomButtonStyles {
  final BuildContext context;

  CustomButtonStyles(this.context);
  //filled button style
  ButtonStyle get fillOnPrimaryContainer => ElevatedButton.styleFrom(
        backgroundColor: theme(context).colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        elevation: 0.0,
      );
  ButtonStyle get fillOnSecondaryContainer => ElevatedButton.styleFrom(
        backgroundColor: theme(context).colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        elevation: 0.0,
      );
  ButtonStyle get fillprimary => ElevatedButton.styleFrom(
        backgroundColor: theme(context).colorScheme.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        elevation: 0.0,
      );
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );

  //gradient button style
  BoxDecoration get gradientYellowAToPrimaryDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(24.h),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [appTheme.yellowA700, theme(context).colorScheme.primary],
        ),
      );

  BoxDecoration get gradientYellowAToPrimaryL10Decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [appTheme.yellowA700, theme(context).colorScheme.primary],
        ),
      );

  // Outline Button Style
  static ButtonStyle get outline => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );

  static ButtonStyle get outlineTranparent => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.transparent, width: 0.0),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );

  ButtonStyle get outlineTL10 => OutlinedButton.styleFrom(
        backgroundColor:
            theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        shadowColor: appTheme.black900.withOpacity(0.25),
        elevation: 4,
      );

  ButtonStyle get outlineTL25 => OutlinedButton.styleFrom(
        backgroundColor:
            theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.h),
        ),
      );

  ButtonStyle get outlineOnPrimaryContainer => OutlinedButton.styleFrom(
        backgroundColor: theme(context).colorScheme.primary.withOpacity(0.3),
        side: BorderSide(
          color: theme(context).colorScheme.onPrimaryContainer,
          width: 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );

  ButtonStyle get outlinePrimaryContainer => OutlinedButton.styleFrom(
        backgroundColor:
            theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
        side: BorderSide(
          color: theme(context).colorScheme.primaryContainer,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );

  //text button style
  static ButtonStyle get none => const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      elevation: WidgetStatePropertyAll(0),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.transparent)));
}
