import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/t_o_s_dataset.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/save_pref.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_outlined_button.dart';

class TermOfServiceScreen extends StatelessWidget {
  TermOfServiceScreen({super.key});

  final tos = TOSDataset().tos;

  void _confirmBtnFunc(BuildContext context) {
    SavePref().saveTosData();
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
              child: SizedBox(
                width: Sizeutils.width,
                child: Text(
                  tos,
                  style: CustomTextStyles(context).bodyMedium_13,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            _buildAgree(context),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAgree(BuildContext context) {
    return CustomOutlinedButton(
      text: context.tr("common.agree"),
      margin: EdgeInsets.all(5.h),
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomDecoration(context).outlinePrimary,
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () => _confirmBtnFunc(context),
    );
  }
}
