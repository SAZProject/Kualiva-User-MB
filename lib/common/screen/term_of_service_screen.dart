import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/t_o_s_dataset.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';

class TermOfServiceScreen extends StatelessWidget {
  TermOfServiceScreen({super.key});

  final tos = TOSDataset().tos;

  void _confirmBtnFunc(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _tosAppBar(context),
        body: _body(context),
      ),
    );
  }

  PreferredSizeWidget _tosAppBar(BuildContext context) {
    return CustomAppBar(title: context.tr("tos.title"));
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Sizeutils.width,
              child: Text(
                tos,
                style: CustomTextStyles(context).bodyMedium_13,
              ),
            ),
            _buildAgree(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAgree(BuildContext context) {
    return CustomGradientOutlinedButton(
      text: context.tr("common.agree"),
      outerPadding: EdgeInsets.all(10.h),
      innerPadding: EdgeInsets.all(5.h),
      strokeWidth: 2.h,
      colors: [
        appTheme.yellowA700,
        theme(context).colorScheme.primary,
      ],
      textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () => _confirmBtnFunc(context),
    );
  }
}
