import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';

void customErrorDialog({
  required BuildContext context,
  AlignmentGeometry? dialogGeometry,
  MainAxisAlignment? actionsAlignment,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        elevation: 5.0,
        backgroundColor: theme(context).colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder10,
          side: BorderSide(
            color: theme(context).colorScheme.primary,
            width: 1.h,
          ),
        ),
        title: Text(context.tr("common.error_try_again")),
        titleTextStyle: CustomTextStyles(context).titleLarge_22,
        icon: Center(
          child: Icon(
            Icons.cancel_outlined,
            size: 50.h,
            color: appTheme.redA70001,
          ),
        ),
        actions: [
          CustomElevatedButton(
            initialText: context.tr("common.ok"),
            height: 30.0,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            buttonStyle: CustomButtonStyles.none,
            decoration:
                CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(
                    context),
            buttonTextStyle:
                CustomTextStyles(context).titleMediumOnPrimaryContainer,
            onPressed: () => Navigator.pop(context),
          )
        ],
        alignment: dialogGeometry,
        actionsAlignment: actionsAlignment,
      );
    },
  );
}
