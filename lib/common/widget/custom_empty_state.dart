import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

class CustomEmptyState extends StatelessWidget {
  const CustomEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.h,
      child: SizedBox(
        height: 75.h,
        child: Center(
          child: Text(
            context.tr("common.data_not_found"),
            style: CustomTextStyles(context).bodyMediumOnPrimaryContainer_06,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
