import 'package:flutter/material.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

class CustomTextStyles {
  final BuildContext context;

  CustomTextStyles(this.context);

  TextStyle get onPrimaryContainer => TextStyle(
        color: theme(context)
            .colorScheme
            .onPrimaryContainer
            .withValues(alpha: 1.0),
      );
  TextStyle get onSecondaryContainer => TextStyle(
        color: theme(context).colorScheme.onSecondaryContainer,
      );
  // Body Large
  TextStyle get bodyLargeBlueGray100 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color: appTheme.blueGray100,
          );
  TextStyle get bodyLargeGray800 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color: appTheme.gray800,
          );
  TextStyle get bodyLargeOnPrimaryContainer_06 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.6),
          );
  TextStyle get bodyLargeOnPrimaryContainer_03 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.3),
          );
  TextStyle get bodyLargeBlack900 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color: appTheme.black900,
          );
  // Body Medium
  TextStyle get bodyMedium_15 => theme(context).textTheme.bodyMedium!.copyWith(
        fontSize: 15.fontSize,
      );
  TextStyle get bodyMedium_13 => theme(context).textTheme.bodyMedium!.copyWith(
        fontSize: 13.fontSize,
      );
  TextStyle get bodyMediumBlack900 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color: appTheme.black900,
          );
  TextStyle get bodyMediumBlack900_13 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color: appTheme.black900,
          );
  TextStyle get bodyMediumOnPrimaryContainer_03 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.3),
            fontSize: 13.fontSize,
          );
  TextStyle get bodyMediumOnPrimaryContainer_06 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.6),
            fontSize: 13.fontSize,
          );
  TextStyle get bodyMediumGray200 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color: appTheme.gray200,
          );
  TextStyle get bodyMediumRedA70001 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color: appTheme.redA70001,
          );
  // Body Small
  TextStyle get bodySmall10 => theme(context).textTheme.bodySmall!.copyWith(
        fontSize: 10.fontSize,
      );
  TextStyle get bodySmall9 => theme(context).textTheme.bodySmall!.copyWith(
        fontSize: 9.fontSize,
      );
  TextStyle get bodySmall12 => theme(context).textTheme.bodySmall!.copyWith(
        fontSize: 12.fontSize,
      );
  TextStyle get bodySmallBlack900 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: appTheme.black900,
          );
  TextStyle get bodySmallBlack900_10 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: appTheme.black900,
            fontSize: 10.fontSize,
          );
  TextStyle get bodySmallBlueGray100_10 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: appTheme.blueGray100,
            fontSize: 10.fontSize,
          );
  TextStyle get bodySmallGray200_10 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: appTheme.gray200,
            fontSize: 10.fontSize,
          );
  TextStyle get bodySmallGray800 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: appTheme.gray800,
            fontSize: 10.fontSize,
          );
  TextStyle get bodySmallOnPrimaryContainer =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: theme(context).colorScheme.onPrimaryContainer,
          );
  TextStyle get bodySmallOnPrimaryContainer06 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.6),
            fontSize: 10.fontSize,
          );
  TextStyle get bodySmallPrimary12 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: theme(context).colorScheme.primary,
            fontSize: 12.fontSize,
          );
  // Display Small
  TextStyle get displaySmallBlack900 =>
      theme(context).textTheme.displaySmall!.copyWith(
            color: appTheme.black900,
            fontWeight: FontWeight.w400,
          );
  // Headline Medium
  TextStyle get headlineMediumOnPrimaryContainer =>
      theme(context).textTheme.headlineMedium!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 1),
            fontWeight: FontWeight.w700,
          );
  // Headline Small
  TextStyle get headlineSmallBlack900w400 =>
      theme(context).textTheme.headlineSmall!.copyWith(
            color: appTheme.black900,
            fontWeight: FontWeight.w400,
          );
  TextStyle get headlineSmallBlack900 =>
      theme(context).textTheme.headlineSmall!.copyWith(
            color: appTheme.black900,
          );
  // Label large
  TextStyle get labelLarge_12 => theme(context).textTheme.labelLarge!.copyWith(
        fontSize: 12.fontSize,
      );
  TextStyle get labelLargeBlack900 =>
      theme(context).textTheme.labelLarge!.copyWith(
            color: appTheme.black900,
          );
  TextStyle get labelLargeOnPrimaryContainer_06 =>
      theme(context).textTheme.labelLarge!.copyWith(
            color: theme(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.6),
          );
  TextStyle get labelLargeYellowA700 =>
      theme(context).textTheme.labelLarge!.copyWith(
            color: appTheme.yellowA700,
            fontSize: 12.fontSize,
          );
  // Label Medium
  TextStyle get labelMedium_10 =>
      theme(context).textTheme.labelMedium!.copyWith(
            fontSize: 10.fontSize,
          );
  // Title Large
  TextStyle get titleLarge_22 => theme(context).textTheme.titleLarge!.copyWith(
        fontSize: 22.fontSize,
      );
  TextStyle get titleLargeBlack900W400 =>
      theme(context).textTheme.titleLarge!.copyWith(
            color: appTheme.black900,
            fontWeight: FontWeight.w400,
          );
  TextStyle get titleLargeBlack900W400_22 =>
      theme(context).textTheme.titleLarge!.copyWith(
            color: appTheme.black900,
            fontSize: 22.fontSize,
            fontWeight: FontWeight.w400,
          );
  TextStyle get titleLargeW400 => theme(context).textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  TextStyle get titleLargeOnSecondaryContainer =>
      theme(context).textTheme.titleLarge!.copyWith(
            color: theme(context).colorScheme.onSecondaryContainer,
          );
  TextStyle get titleLargeOnPrimaryContainer =>
      theme(context).textTheme.titleLarge!.copyWith(
            color: theme(context).colorScheme.onPrimaryContainer,
            fontSize: 22.fontSize,
            fontWeight: FontWeight.w400,
          );
  // Title Medium
  TextStyle get titleMedium_17 =>
      theme(context).textTheme.titleMedium!.copyWith(
            fontSize: 17.fontSize,
          );
  TextStyle get titleMedium_18 =>
      theme(context).textTheme.titleMedium!.copyWith(
            fontSize: 18.fontSize,
          );
  TextStyle get titleMediumBlack900 =>
      theme(context).textTheme.titleMedium!.copyWith(
            color: appTheme.black900,
          );
  TextStyle get titleMediumYellowA700 =>
      theme(context).textTheme.titleMedium!.copyWith(
            color: appTheme.yellowA700,
          );
  TextStyle get titleMediumPrimary =>
      theme(context).textTheme.titleMedium!.copyWith(
            color: theme(context).colorScheme.primary,
          );
  TextStyle get titleMediumOnSecondaryContainer =>
      theme(context).textTheme.titleMedium!.copyWith(
            color: theme(context).colorScheme.onSecondaryContainer,
          );
  TextStyle get titleMediumOnPrimaryContainer =>
      theme(context).textTheme.titleMedium!.copyWith(
            color: theme(context).colorScheme.onPrimaryContainer,
          );
  // Title Small
  TextStyle get titlesmall_15 => theme(context).textTheme.titleSmall!.copyWith(
        fontSize: 15.fontSize,
      );
  TextStyle get titlesmallBlack900 =>
      theme(context).textTheme.titleSmall!.copyWith(
            color: appTheme.black900,
          );
  TextStyle get titlesmallGray200 =>
      theme(context).textTheme.titleSmall!.copyWith(
            color: appTheme.gray200,
          );
}
