import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _comingSoonAppBar(context),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 200.h,
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConstant.appLogo2),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: CustomDecoration(context).foregroundBlur,
              ),
            ),
            SizedBox(
              child: Center(
                child: Text(
                  context.tr("common.coming_soon"),
                  style: CustomTextStyles(context).titleLarge_22,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _comingSoonAppBar(BuildContext context) {
    return CustomAppBar(title: pageTitle);
  }
}
