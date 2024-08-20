import 'package:flutter/material.dart';
import 'package:like_it/common/style/theme_helper.dart';

class CustomTextStyles {
  static get onSecondaryContainer => TextStyle(
        color: theme.colorScheme.onSecondaryContainer,
      );
  // Body Large
  static get bodyLargeBlueGray100 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray100,
      );
  static get bodyLargeOnPrimaryContainer_06 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
      );
  static get bodyLargeOnPrimaryContainer_03 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.3),
      );
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  // Body Medium
  static get bodyMedium_15 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 15,
      );
  static get bodyMedium_13 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 13,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBlack900_13 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumOnPrimaryContainer_03 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.3),
        fontSize: 13,
      );
  static get bodyMediumOnPrimaryContainer_06 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
        fontSize: 13,
      );
  static get bodyMediumGray200 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray200,
      );
  static get bodyMediumRedA70001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.redA70001,
      );
  // Body Small
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10,
      );
  static get bodySmall9 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 9,
      );
  static get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallBlack900_10 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 10,
      );
  static get bodySmallBlueGray100_10 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray100,
        fontSize: 10,
      );
  static get bodySmallGray200_10 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray200,
        fontSize: 10,
      );
  static get bodySmallOnPrimaryContainer06 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
        fontSize: 10,
      );
  // Display Small
  static get displaySmallBlack900 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  // Headline Medium
  static get headlineMediumOnPrimaryContainer =>
      theme.textTheme.headlineMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  // Headline Small
  static get headlineSmallBlack900w400 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallBlack900 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
  // Label large
  static get labelLarge_12 => theme.textTheme.labelLarge!.copyWith(
        fontSize: 12,
      );
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  static get labelLargeOnPrimaryContainer_06 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
      );
  static get labelLargeYellowA700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.yellowA700,
        fontSize: 12,
      );
  // Label Medium
  static get labelMedium_10 => theme.textTheme.labelMedium!.copyWith(
        fontSize: 10,
      );
  // Title Large
  static get titleLarge_22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22,
      );
  static get titleLargeBlack900W400 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeBlack900W400_22 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      );
  static get titleLargeW400 => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargeOnSecondaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
      );
  // Title Medium
  static get titleMedium_17 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 17,
      );
  static get titleMedium_18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumCyanA200 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.cyanA200,
      );
  static get titleMediumYellowA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.yellowA700,
      );
  static get titleMediumOnSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
      );
  // Title Small
  static get titlesmall_15 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 15,
      );
  static get titlesmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titlesmallGray200 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray200,
      );
}
