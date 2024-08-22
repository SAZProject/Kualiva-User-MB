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
import 'package:like_it/common/widget/custom_text_form_field.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passObscure = true;

  TextEditingController phoneNumberOrUserNameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneNumberOrUserNameCtl.dispose();
    passwordCtl.dispose();
    super.dispose();
  }

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
                SizedBox(height: 26.h),
                CustomImageView(
                  imagePath: ImageConstant.appLogo,
                  height: 100.h,
                  width: 100.h,
                ),
                SizedBox(height: 80.h),
                _signInMenu(context),
                const Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context.tr("sign_in.tos_statement"),
                        style: CustomTextStyles(context)
                            .bodySmallOnPrimaryContainer,
                      ),
                      TextSpan(
                        text: context.tr("sign_in.tos"),
                        style: theme(context).textTheme.labelMedium!.copyWith(
                              color: theme(context).primaryColor,
                              decorationColor: theme(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                          text: " ",
                          style: theme(context).textTheme.labelMedium),
                      TextSpan(
                        text: context.tr("sign_in.policy_statement"),
                        style: CustomTextStyles(context)
                            .bodySmallOnPrimaryContainer,
                      ),
                      TextSpan(
                        text: context.tr("sign_in.policy"),
                        style: theme(context).textTheme.labelMedium!.copyWith(
                              color: theme(context).primaryColor,
                              decorationColor: theme(context).primaryColor,
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
            style: CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
          ),
          SizedBox(height: 10.h),
          _signInWithSAZ(context),
          SizedBox(height: 10.h),
          Text(
            context.tr("sign_in.like_it_acc"),
            style: CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
          ),
          SizedBox(height: 10.h),
          SizedBox(
              width: double.maxFinite,
              child: _textFieldPhoneNumberOrUserName(context)),
          SizedBox(height: 10.h),
          SizedBox(width: double.maxFinite, child: _textFieldPassword(context)),
          SizedBox(height: 10.h),
          _signInButton(context),
          SizedBox(height: 10.h),
          Text(
            context.tr("sign_in.or"),
            style: CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
          ),
          SizedBox(height: 10.h),
          _signUpButton(context),
        ],
      ),
    );
  }

  Widget _signInWithSAZ(BuildContext context) {
    return CustomOutlinedButton(
      text: context.tr("sign_in.sign_in_with_saz"),
      buttonTextStyle: CustomTextStyles(context).titleMediumCyanA200,
      buttonStyle: CustomButtonStyles.outlineTranparent,
      decoration: CustomDecoration(context).backgroundBlur.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      leftIcon: CustomImageView(
        imagePath: ImageConstant.sazIcon,
        height: 40.h,
        width: 40.h,
      ),
    );
  }

  Widget _textFieldPhoneNumberOrUserName(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomTextFormField(
        controller: phoneNumberOrUserNameCtl,
        hintText: context.tr("sign_in.phone_number_or_user_name"),
        textInputType: TextInputType.text,
      ),
    );
  }

  Widget _textFieldPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomTextFormField(
        controller: passwordCtl,
        hintText: context.tr("sign_in.password"),
        textInputType: TextInputType.text,
        obscureText: passObscure,
        suffix: IconButton(
          onPressed: () {
            setState(() {
              passObscure = !passObscure;
            });
          },
          icon: Icon(
            passObscure ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("sign_in.sign_in_btn"),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles(context).gradientYellowAToPrimaryL10Decoration,
      buttonTextStyle:
          CustomTextStyles(context).titleMediumOnSecondaryContainer,
      onPressed: () {},
    );
  }

  Widget _signUpButton(BuildContext context) {
    return OutlineGradientButton(
      padding: EdgeInsets.zero,
      strokeWidth: 1.h,
      gradient: LinearGradient(
        begin: const Alignment(0.5, 0),
        end: const Alignment(0.5, 1),
        colors: [
          appTheme.yellowA700,
          theme(context).colorScheme.primary,
        ],
      ),
      corners: const Corners(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
      child: CustomOutlinedButton(
        text: context.tr("sign_up.sign_up_btn"),
        buttonStyle: CustomButtonStyles.outlineTranparent,
        buttonTextStyle: CustomTextStyles(context).titleMediumYellowA700,
        onPressed: () {},
      ),
    );
  }
}
