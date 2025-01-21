import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';

class CustomErrorState extends StatelessWidget {
  final String errorMessage;
  final void Function()? onRetry;

  const CustomErrorState(
      {super.key, required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: CustomTextStyles(context).bodyMediumRedA70001,
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              initialText: context.tr("common.retry"),
              onPressed: onRetry,
              height: 30.h,
              margin: EdgeInsets.symmetric(horizontal: 50.h, vertical: 10.h),
              buttonStyle: CustomButtonStyles.none,
              decoration:
                  CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(
                      context),
              buttonTextStyle:
                  CustomTextStyles(context).titleMediumOnPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
