import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

void customAlertDialog({
  required BuildContext context,
  required bool dismissable,
  AlignmentGeometry? dialogGeometry,
  Widget? title,
  Widget? content,
  Widget? icon,
  List<Widget>? actionBtn,
  MainAxisAlignment? actionsAlignment,
}) {
  showDialog(
    context: context,
    barrierDismissible: dismissable,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        elevation: 5.0,
        backgroundColor: theme(context).colorScheme.onSecondaryContainer,
        title: title,
        titleTextStyle: CustomTextStyles(context).titleLarge_22,
        content: content,
        icon: icon,
        actions: actionBtn,
        alignment: dialogGeometry,
        actionsAlignment: actionsAlignment,
      );
    },
  );
}
