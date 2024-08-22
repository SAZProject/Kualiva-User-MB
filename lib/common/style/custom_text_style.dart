import 'package:flutter/material.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class CustomTextStyles {
  final BuildContext context;

  CustomTextStyles(this.context);
  get onPrimaryContainer => TextStyle(
        color: theme(context).colorScheme.onPrimaryContainer.withOpacity(1.0),
      );
  get onSecondaryContainer => TextStyle(
        color: theme(context).colorScheme.onSecondaryContainer,
      );
  // Body Large
  get bodyLargeBlueGray100 => theme(context).textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray100,
      );
  get bodyLargeOnPrimaryContainer_06 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color:
                theme(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
          );
  get bodyLargeOnPrimaryContainer_03 =>
      theme(context).textTheme.bodyLarge!.copyWith(
            color:
                theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
          );
  get bodyLargeBlack900 => theme(context).textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  // Body Medium
  get bodyMedium_15 => theme(context).textTheme.bodyMedium!.copyWith(
        fontSize: 15.fontSize,
      );
  get bodyMedium_13 => theme(context).textTheme.bodyMedium!.copyWith(
        fontSize: 13.fontSize,
      );
  get bodyMediumBlack900 => theme(context).textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  get bodyMediumBlack900_13 => theme(context).textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  get bodyMediumOnPrimaryContainer_03 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color:
                theme(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
            fontSize: 13.fontSize,
          );
  get bodyMediumOnPrimaryContainer_06 =>
      theme(context).textTheme.bodyMedium!.copyWith(
            color:
                theme(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
            fontSize: 13.fontSize,
          );
  get bodyMediumGray200 => theme(context).textTheme.bodyMedium!.copyWith(
        color: appTheme.gray200,
      );
  get bodyMediumRedA70001 => theme(context).textTheme.bodyMedium!.copyWith(
        color: appTheme.redA70001,
      );
  // Body Small
  get bodySmall10 => theme(context).textTheme.bodySmall!.copyWith(
        fontSize: 10.fontSize,
      );
  get bodySmall9 => theme(context).textTheme.bodySmall!.copyWith(
        fontSize: 9.fontSize,
      );
  get bodySmall12 => theme(context).textTheme.bodySmall!.copyWith(
        fontSize: 12.fontSize,
      );
  get bodySmallBlack900 => theme(context).textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  get bodySmallBlack900_10 => theme(context).textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 10.fontSize,
      );
  get bodySmallBlueGray100_10 => theme(context).textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray100,
        fontSize: 10.fontSize,
      );
  get bodySmallGray200_10 => theme(context).textTheme.bodySmall!.copyWith(
        color: appTheme.gray200,
        fontSize: 10.fontSize,
      );
  get bodySmallOnPrimaryContainer =>
      theme(context).textTheme.bodySmall!.copyWith(
            color: theme(context).colorScheme.onPrimaryContainer,
          );
  get bodySmallOnPrimaryContainer06 =>
      theme(context).textTheme.bodySmall!.copyWith(
            color:
                theme(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
            fontSize: 10.fontSize,
          );
  // Display Small
  get displaySmallBlack900 => theme(context).textTheme.displaySmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  // Headline Medium
  get headlineMediumOnPrimaryContainer =>
      theme(context).textTheme.headlineMedium!.copyWith(
            color: theme(context).colorScheme.onPrimaryContainer.withOpacity(1),
            fontWeight: FontWeight.w700,
          );
  // Headline Small
  get headlineSmallBlack900w400 =>
      theme(context).textTheme.headlineSmall!.copyWith(
            color: appTheme.black900,
            fontWeight: FontWeight.w400,
          );
  get headlineSmallBlack900 => theme(context).textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
  // Label large
  get labelLarge_12 => theme(context).textTheme.labelLarge!.copyWith(
        fontSize: 12.fontSize,
      );
  get labelLargeBlack900 => theme(context).textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  get labelLargeOnPrimaryContainer_06 =>
      theme(context).textTheme.labelLarge!.copyWith(
            color:
                theme(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
          );
  get labelLargeYellowA700 => theme(context).textTheme.labelLarge!.copyWith(
        color: appTheme.yellowA700,
        fontSize: 12.fontSize,
      );
  // Label Medium
  get labelMedium_10 => theme(context).textTheme.labelMedium!.copyWith(
        fontSize: 10.fontSize,
      );
  // Title Large
  get titleLarge_22 => theme(context).textTheme.titleLarge!.copyWith(
        fontSize: 22.fontSize,
      );
  get titleLargeBlack900W400 => theme(context).textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  get titleLargeBlack900W400_22 =>
      theme(context).textTheme.titleLarge!.copyWith(
            color: appTheme.black900,
            fontSize: 22.fontSize,
            fontWeight: FontWeight.w400,
          );
  get titleLargeW400 => theme(context).textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  get titleLargeOnSecondaryContainer =>
      theme(context).textTheme.titleLarge!.copyWith(
            color: theme(context).colorScheme.onSecondaryContainer,
          );
  // Title Medium
  get titleMedium_17 => theme(context).textTheme.titleMedium!.copyWith(
        fontSize: 17.fontSize,
      );
  get titleMedium_18 => theme(context).textTheme.titleMedium!.copyWith(
        fontSize: 18.fontSize,
      );
  get titleMediumBlack900 => theme(context).textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  get titleMediumCyanA200 => theme(context).textTheme.titleMedium!.copyWith(
        color: appTheme.cyanA200,
      );
  get titleMediumYellowA700 => theme(context).textTheme.titleMedium!.copyWith(
        color: appTheme.yellowA700,
      );
  get titleMediumOnSecondaryContainer =>
      theme(context).textTheme.titleMedium!.copyWith(
            color: theme(context).colorScheme.onSecondaryContainer,
          );
  // Title Small
  get titlesmall_15 => theme(context).textTheme.titleSmall!.copyWith(
        fontSize: 15.fontSize,
      );
  get titlesmallBlack900 => theme(context).textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  get titlesmallGray200 => theme(context).textTheme.titleSmall!.copyWith(
        color: appTheme.gray200,
      );
}
