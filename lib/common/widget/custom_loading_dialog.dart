import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

void customLoadingDialog({
  required BuildContext context,
  AlignmentGeometry? dialogGeometry,
  MainAxisAlignment? actionsAlignment,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
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
        title: Text(context.tr("common.loading")),
        titleTextStyle: CustomTextStyles(context).titleLarge_22,
        icon: Center(child: CircularProgressIndicator()),
        alignment: dialogGeometry,
        actionsAlignment: actionsAlignment,
      );
    },
  );
}
