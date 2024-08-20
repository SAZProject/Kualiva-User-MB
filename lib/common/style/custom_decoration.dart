import 'package:flutter/material.dart';
import 'package:like_it/common/style/theme_helper.dart';

class CustomDecoration {
  // Blue Decoration
  static BoxDecoration get blueColor => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.cyanA200,
            theme.colorScheme.onPrimary,
            appTheme.purpleA700,
          ],
        ),
      );

  // Fill Decorations
  static BoxDecoration get fillBlack900_06 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
      );
  static BoxDecoration get fillBlack900_03 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.3),
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillOnPrimaryContainerOpacity_1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      );

  // Gradient Decorations
  static BoxDecoration get gradientCyanAToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(1, 1),
          colors: [
            appTheme.cyanA400,
            theme.colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );
  static BoxDecoration get gradientLightgreenAToOnPrimaryContainer =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.lightGreenA400,
            theme.colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );
  static BoxDecoration get gradientOnErrorContainerToPink => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            theme.colorScheme.onErrorContainer,
            appTheme.gray80001,
            appTheme.pink900,
          ],
        ),
      );
  static BoxDecoration get gradientPrimaryContainerToRedA => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme.colorScheme.primaryContainer,
            appTheme.redA700,
          ],
        ),
      );
  static BoxDecoration get gradientYellowA700ToPrimary => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700.withOpacity(0.3),
            theme.colorScheme.primary.withOpacity(0.3),
          ],
        ),
      );
  static BoxDecoration get gradientYellowAToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0, 1),
          colors: [
            appTheme.yellowA700,
            theme.colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );
  static BoxDecoration get gradientYellowAToOnPrimary => BoxDecoration(
        border: Border.all(
          color: appTheme.black900.withOpacity(0.6),
          width: 1.0,
        ),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700.withOpacity(0.3),
            theme.colorScheme.primary.withOpacity(0.3),
          ],
        ),
      );

  // Green Decorations
  static BoxDecoration get greenColor => BoxDecoration(
        color: appTheme.black900.withOpacity(0.3),
      );

  // Orange Decorations
  static BoxDecoration get orange60Color => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.orange300.withOpacity(0.3),
            theme.colorScheme.primary.withOpacity(0.3),
          ],
        ),
      );
  static BoxDecoration get orangeColor => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700,
            theme.colorScheme.primary,
          ],
        ),
      );

  // Outline Decorations
  static BoxDecoration get outline => BoxDecoration(
        color: appTheme.black900.withOpacity(0.3),
      );
  static BoxDecoration get outlineBlack => const BoxDecoration();
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.0,
            blurRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.6),
          width: 1.0,
        ),
      );
  static BoxDecoration get outlineBlack9002 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.3),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.6),
          width: 1.0,
        ),
      );
  static BoxDecoration get outlineBlack9003 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.0,
        ),
      );
}

class BorderRadiusStyle {
  // Custom Borders
  static BorderRadius get customBorderBL5 =>
      const BorderRadius.vertical(bottom: Radius.circular(5.0));
  static BorderRadius get customBorderTR6 =>
      const BorderRadius.only(topRight: Radius.circular(6.0));
  static BorderRadius get customBorderTL6 =>
      const BorderRadius.only(topLeft: Radius.circular(5.0));
  // Rounded Borders
  static BorderRadius get roundedBorder1 => BorderRadius.circular(1.0);
  static BorderRadius get roundedBorder5 => BorderRadius.circular(5.0);
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.0);
  static BorderRadius get roundedBorder14 => BorderRadius.circular(14.0);
  static BorderRadius get roundedBorder20 => BorderRadius.circular(20.0);
  static BorderRadius get roundedBorder44 => BorderRadius.circular(44.0);
}
