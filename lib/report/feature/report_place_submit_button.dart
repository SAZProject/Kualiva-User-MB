import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';

class ReportPlaceSubmitButton extends StatelessWidget {
  const ReportPlaceSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.maxFinite,
      child: CustomGradientOutlinedButton(
        text: context.tr("report.submit_btn"),
        outerPadding: EdgeInsets.symmetric(horizontal: 30.h),
        innerPadding: EdgeInsets.all(2.h),
        strokeWidth: 2.h,
        colors: [
          appTheme.yellowA700,
          theme(context).colorScheme.primary,
        ],
        textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
        onPressed: () {},
      ),
    );
  }
}
