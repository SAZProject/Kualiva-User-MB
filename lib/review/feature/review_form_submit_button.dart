import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_alert_dialog.dart';
import 'package:like_it/common/widget/custom_gradient_outlined_button.dart';

class ReportReviewSubmitButton extends StatelessWidget {
  const ReportReviewSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: SizedBox(
        height: 60.h,
        width: double.maxFinite,
        child: CustomGradientOutlinedButton(
          text: context.tr("review.submit_btn"),
          outerPadding: EdgeInsets.symmetric(horizontal: 30.h),
          innerPadding: EdgeInsets.all(2.h),
          strokeWidth: 2.h,
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.primary,
          ],
          textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
          onPressed: () {
            customAlertDialog(
              context: context,
              dismissable: true,
              title: Text(
                "Conratulation!",
              ),
              content: Text(
                "You get 10 points",
              ),
              icon: Icon(
                Icons.generating_tokens_outlined,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
