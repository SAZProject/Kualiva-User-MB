import 'package:flutter/material.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class CustomButtonStyles {
  // final BuildContext context;

  // CustomButtonStyles(this.context);

  //filled button style
  static ButtonStyle fillOnPrimaryContainer(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: theme(context).colorScheme.onPrimaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
      ),
      elevation: 0.0,
    );
  }

  static ButtonStyle fillOnSecondaryContainer(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: theme(context).colorScheme.onSecondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
      ),
      elevation: 0.0,
    );
  }

  static ButtonStyle fillprimary(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: theme(context).colorScheme.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
      ),
      elevation: 0.0,
    );
  }

  static ButtonStyle get fillGray {
    return ElevatedButton.styleFrom(
      backgroundColor: appTheme.gray200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
      ),
    );
  }

  //gradient button style
  static BoxDecoration gradientYellowAToPrimaryDecoration(
    BuildContext context,
  ) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24.h),
      gradient: LinearGradient(
        begin: const Alignment(0.5, 0),
        end: const Alignment(0.5, 1),
        colors: [appTheme.yellowA700, theme(context).colorScheme.primary],
      ),
    );
  }

  static BoxDecoration gradientYellowAToPrimaryL10Decoration(
    BuildContext context,
  ) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.h),
      gradient: LinearGradient(
        begin: const Alignment(0.5, 0),
        end: const Alignment(0.5, 1),
        colors: [appTheme.yellowA700, theme(context).colorScheme.primary],
      ),
    );
  }

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

  static ButtonStyle outlineTL10(BuildContext context) {
    return OutlinedButton.styleFrom(
      backgroundColor:
          theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
      ),
      shadowColor: appTheme.black900.withOpacity(0.25),
      elevation: 4,
    );
  }

  static ButtonStyle outlineTL25(BuildContext context) {
    return OutlinedButton.styleFrom(
      backgroundColor:
          theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.h),
      ),
    );
  }

  static ButtonStyle outlineOnPrimaryContainer(BuildContext context) {
    return OutlinedButton.styleFrom(
      backgroundColor: theme(context).colorScheme.primary,
      side: BorderSide(
        color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
        width: 1.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
      ),
    );
  }

  static ButtonStyle outlinePrimaryContainer(BuildContext context) {
    return OutlinedButton.styleFrom(
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
  }

  //text button style
  static ButtonStyle get none => const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      elevation: WidgetStatePropertyAll(0),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.transparent)));
}
