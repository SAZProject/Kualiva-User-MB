import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/style/custom_decoration.dart';
import 'package:like_it/common/style/custom_text_style.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/image_constant.dart';
import 'package:like_it/common/utility/sized_utils.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_image_view.dart';
import 'package:like_it/common/widget/custom_outlined_button.dart';
import 'package:like_it/common/widget/custom_phone_number.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode("62");
  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: Sizeutils.height,
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 6.h),
            child: Column(
              children: [
                SizedBox(height: 25.h),
                CustomImageView(
                  imagePath: ImageConstant.appLogo,
                  height: 100.h,
                  width: 100.h,
                ),
                SizedBox(height: 85.h),
                _signInMenu(context),
                const Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context.tr("sign_in.tos_statement"),
                        style: CustomTextStyles.bodySmallOnPrimaryContainer,
                      ),
                      TextSpan(
                        text: context.tr("sign_in.tos"),
                        style: theme.textTheme.labelMedium!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(text: "\n", style: theme.textTheme.labelMedium),
                      TextSpan(
                        text: context.tr("sign_in.policy_statement"),
                        style: CustomTextStyles.bodySmallOnPrimaryContainer,
                      ),
                      TextSpan(
                        text: context.tr("sign_in.tos"),
                        style: theme.textTheme.labelMedium!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInMenu(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Text(
            context.tr("sign_in.sign_in_with"),
            style: CustomTextStyles.bodyLargeOnPrimaryContainer_06,
          ),
          SizedBox(height: 10.h),
          _signInWithSAZ(context),
          SizedBox(height: 10.h),
          SizedBox(
              width: double.maxFinite, child: _textFieldPhoneNumber(context)),
          SizedBox(height: 10.h),
          _signInButton(context),
          SizedBox(height: 10.h),
          Text(
            context.tr("sign_in.or"),
            style: CustomTextStyles.bodyLargeOnPrimaryContainer_06,
          ),
          SizedBox(height: 10.h),
          _signUpButton(context),
        ],
      ),
    );
  }

  Widget _signInWithSAZ(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 4.h,
      ),
      decoration: CustomDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      width: double.maxFinite,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.sazIcon,
              height: 40.h,
              width: 40.h,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 10.h, bottom: 6.h),
                child: Text(
                  context.tr("sign_in.sign_in_with_saz"),
                  style: CustomTextStyles.titleMediumCyanA200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldPhoneNumber(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomPhoneNumber(
        country: selectedCountry,
        controller: phoneNumberController,
        onPressed: (country) {
          selectedCountry = country;
        },
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("sign_in.sign_in_btn"),
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientYellowAToPrimaryL10Decoration,
      buttonTextStyle: CustomTextStyles.titleMediumOnSecondaryContainer,
      onPressed: () {},
    );
  }

  Widget _signUpButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 34.h),
      child: OutlineGradientButton(
        strokeWidth: 1.h,
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700,
            theme.colorScheme.primary,
          ],
        ),
        corners: const Corners(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        child: CustomOutlinedButton(
          initialText: context.tr("sign_up.sign_up_btn"),
          buttonStyle: CustomButtonStyles.outline,
          buttonTextStyle: CustomTextStyles.titleMediumYellowA700,
          onPressed: () {},
        ),
      ),
    );
  }
}
