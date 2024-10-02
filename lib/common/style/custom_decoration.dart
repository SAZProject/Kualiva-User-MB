import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class CustomDecoration {
  final BuildContext context;

  CustomDecoration(this.context);
  // background Decoration
  BoxDecoration get backgroundBlur {
    return BoxDecoration(
      color: theme(context).colorScheme.onSecondaryContainer,
      border: Border.all(
        color: appTheme.black900.withOpacity(0.6),
        width: 1.h,
      ),
    );
  }

  BoxDecoration get inputFormBg {
    return BoxDecoration(
      color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
      border: Border.all(
        color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
        width: 1.h,
      ),
      borderRadius: BorderRadiusStyle.roundedBorder10,
    );
  }

  BoxDecoration get foregroundBlur {
    return BoxDecoration(
      color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
      borderRadius: BorderRadiusStyle.roundedBorder10,
    );
  }

  // Blue Decoration
  BoxDecoration get blueColor => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.cyanA200,
            theme(context).colorScheme.onPrimary,
            appTheme.purpleA700,
          ],
        ),
      );
  // Fill Decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray800,
      );
  static BoxDecoration get fillBlack900_06 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
      );
  static BoxDecoration get fillBlack900_03 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.3),
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  BoxDecoration get fillPrimary => BoxDecoration(
        color: theme(context).colorScheme.primary,
      );
  BoxDecoration get fillPrimary_03 => BoxDecoration(
        color: theme(context).colorScheme.primary.withOpacity(0.3),
      );
  BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme(context).colorScheme.onPrimaryContainer,
      );
  BoxDecoration get fillOnPrimaryContainerOpacity_03 => BoxDecoration(
        color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      );
  BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer,
      );
  BoxDecoration get fillOnSecondaryContainer_03 => BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.3),
      );
  BoxDecoration get fillOnSecondaryContainer_06 => BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
      );
  // Gradient Decorations
  BoxDecoration get gradientCyanAToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(1, 1),
          colors: [
            appTheme.cyanA400,
            theme(context).colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );
  BoxDecoration get gradientLightgreenAToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.lightGreenA400,
            theme(context).colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );
  BoxDecoration get gradientOnErrorContainerToPink => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            theme(context).colorScheme.onErrorContainer,
            appTheme.gray80001,
            appTheme.pink900,
          ],
        ),
      );
  BoxDecoration get gradientPrimaryContainerToRedA => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            appTheme.yellowA700,
            appTheme.redA700,
          ],
        ),
      );
  BoxDecoration get gradientYellowAContainerToRedA => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme(context).colorScheme.primaryContainer,
            appTheme.redA700,
          ],
        ),
      );
  BoxDecoration get gradientYellowA700ToPrimary => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700.withOpacity(0.3),
            theme(context).colorScheme.primary.withOpacity(0.3),
          ],
        ),
      );
  BoxDecoration get gradientYellowAToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0, 1),
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.onPrimaryContainer.withOpacity(1),
          ],
        ),
      );
  BoxDecoration get gradientYellowAToOnPrimary => BoxDecoration(
        border: Border.all(
          color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
          width: 1.h,
        ),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700.withOpacity(0.7),
            theme(context).colorScheme.primary.withOpacity(0.7),
          ],
        ),
      );
  // Green Decorations
  static BoxDecoration get greenColor => BoxDecoration(
        color: appTheme.greenA700.withOpacity(0.3),
      );
  // Orange Decorations
  BoxDecoration get orange60Color => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.orange300.withOpacity(1),
            theme(context).colorScheme.primary,
          ],
        ),
      );
  BoxDecoration get orangeColorBackgroundBlur => BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.3),
      );
  // Outline Decorations
  BoxDecoration get outline => BoxDecoration(
        color: theme(context).colorScheme.primary.withOpacity(0.3),
      );

  static BoxDecoration get outlineBlack => const BoxDecoration();

  BoxDecoration get outlineOnSecondaryContainer => BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
        border: Border.all(
          color: theme(context).colorScheme.onSecondaryContainer,
          width: 1.h,
        ),
      );

  BoxDecoration get outlineBlack900 => BoxDecoration(
      color: theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      border: Border.all(
        color: appTheme.black900.withOpacity(0.6),
        width: 1.h,
      ));
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.6),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlack9002 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.3),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.6),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlack9003 => BoxDecoration(
        color: appTheme.black900.withOpacity(0.6),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Custom Borders
  static BorderRadius get customBorderBL5 =>
      BorderRadius.vertical(bottom: Radius.circular(5.h));
  static BorderRadius get customBorderTR6 =>
      BorderRadius.only(topRight: Radius.circular(6.h));
  static BorderRadius get customBorderTL6 =>
      BorderRadius.only(topLeft: Radius.circular(5.h));
  // Rounded Borders
  static BorderRadius get roundedBorder1 => BorderRadius.circular(1.h);
  static BorderRadius get roundedBorder5 => BorderRadius.circular(5.h);
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.h);
  static BorderRadius get roundedBorder14 => BorderRadius.circular(14.h);
  static BorderRadius get roundedBorder20 => BorderRadius.circular(20.h);
  static BorderRadius get roundedBorder44 => BorderRadius.circular(44.h);
}
