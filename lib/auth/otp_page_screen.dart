import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_alert_dialog.dart';
import 'package:like_it/common/widget/custom_pin_code_text_field.dart';

class OtpPageScreen extends StatefulWidget {
  const OtpPageScreen({super.key});

  @override
  State<OtpPageScreen> createState() => _OtpPageScreenState();
}

class _OtpPageScreenState extends State<OtpPageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 34.h, left: 30.h, right: 30.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.appLogo,
            height: 100.h,
            width: 100.h,
          ),
          SizedBox(height: 20.h),
          Text(
            context.tr("otp.otp_verif"),
            style: CustomTextStyles(context).titleLarge_22,
          ),
          Text(
            context.tr("otp.otp_check_sms"),
            style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                  color: theme(context).colorScheme.onPrimaryContainer,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: CustomPinCodeTextField(
              context: context,
              onChange: (value) {},
              onCompleted: (value) {
                customAlertDialog(
                  context: context,
                  dismissable: false,
                  icon: Center(
                    child:
                        Icon(Icons.done, color: Colors.greenAccent, size: 50.h),
                  ),
                  title: Text(context.tr("otp.otp_verified"),
                      overflow: TextOverflow.ellipsis, maxLines: 2),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  if (!context.mounted) return;
                  Navigator.pushNamed(
                      context, AppRoutes.devicePermissionScreen);
                });
              },
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr("otp.no_code_recieve"),
                style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                      color: theme(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              SizedBox(height: 16.h),
              Text(
                context.tr("otp.resend"),
                style: CustomTextStyles(context).labelMedium_10.copyWith(
                      color: appTheme.yellowA700,
                      decorationColor: appTheme.yellowA700,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
