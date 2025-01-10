import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/style/custom_decoration.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/form_validation_util.dart';
import 'package:kualiva/common/utility/image_constant.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_image_view.dart';
import 'package:kualiva/common/widget/custom_outlined_button.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';
import 'package:kualiva/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _phoneNumberOrUserNameCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _passwordObscure = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _phoneNumberOrUserNameCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  void _onPressedSignIn(BuildContext context) {
    if (_formKey.currentState!.validate() == false) return;

    String phoneOrUsername = _phoneNumberOrUserNameCtl.text.trim();
    final String password = _passwordCtl.text.trim();

    late AuthLoggedIn authEvent;

    if (phoneOrUsername[0] == '+') {
      phoneOrUsername = phoneOrUsername.substring(1);
    }
    if (phoneOrUsername[0] == '0') {
      phoneOrUsername = "62${phoneOrUsername.substring(1)}";
    }

    if (FormValidationUtil.isNumeric(phoneOrUsername)) {
      authEvent =
          AuthLoggedIn(phoneNumber: phoneOrUsername, password: password);
    } else {
      authEvent = AuthLoggedIn(username: phoneOrUsername, password: password);
    }

    context.read<AuthBloc>().add(authEvent);
  }

  void _onPressedSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.signUpScreen);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          Navigator.of(context).pushNamed(AppRoutes.mainNavigationLayout);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: _body(context),
        ),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 6.h),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  CustomImageView(
                    imagePath: ImageConstant.appLogo,
                    height: 100.h,
                    width: 100.h,
                  ),
                  SizedBox(height: 25.h),
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
                                color: appTheme.yellowA700,
                                decorationColor: appTheme.yellowA700,
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
                                color: appTheme.yellowA700,
                                decorationColor: appTheme.yellowA700,
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
      ),
    );
  }

  Widget _signInMenu(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Text(
            context.tr("sign_in.welcome"),
            style: theme(context).textTheme.titleLarge,
          ),
          // TODO di non aktifkan untuk V1
          // SizedBox(height: 20.h),
          // Text(
          //   context.tr("sign_in.sign_in_with"),
          //   style: CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
          // ),
          // SizedBox(height: 10.h),
          // _signInWithSAZ(context),
          // SizedBox(height: 10.h),
          _signInWithGoogle(context),
          SizedBox(height: 10.h),
          Text(
            context.tr("sign_in.kualiva_acc"),
            style: CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
          ),
          SizedBox(height: 10.h),
          _textFieldPhoneNumberOrUserName(context),
          SizedBox(height: 10.h),
          _textFieldPassword(context),
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

  // Widget _signInWithSAZ(BuildContext context) {
  //   return CustomOutlinedButton(
  //     text: context.tr("sign_in.sign_in_with_saz"),
  //     buttonTextStyle: CustomTextStyles(context).titleMediumCyanA200,
  //     buttonStyle: CustomButtonStyles.outlineTranparent,
  //     decoration: CustomDecoration(context).backgroundBlur.copyWith(
  //           borderRadius: BorderRadiusStyle.roundedBorder10,
  //         ),
  //     leftIcon: CustomImageView(
  //       imagePath: ImageConstant.sazIcon,
  //       height: 40.h,
  //       width: 40.h,
  //     ),
  //   );
  // }

  Widget _signInWithGoogle(BuildContext context) {
    return CustomOutlinedButton(
      text: context.tr("sign_in.sign_in_with_google"),
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      buttonStyle: CustomButtonStyles.outlineTranparent,
      decoration: CustomDecoration(context).backgroundBlur.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      leftIcon: CustomImageView(
        imagePath: ImageConstant.googleIcon,
        height: 40.h,
        width: 40.h,
      ),
    );
  }

  Widget _textFieldPhoneNumberOrUserName(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomTextFormField(
        controller: _phoneNumberOrUserNameCtl,
        hintText: context.tr("sign_in.phone_number_or_user_name"),
        textInputType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter some text";
          }

          return null;
        },
      ),
    );
  }

  Widget _textFieldPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ValueListenableBuilder(
        valueListenable: _passwordObscure,
        builder: (context, value, child) {
          return CustomTextFormField(
            controller: _passwordCtl,
            hintText: context.tr("sign_in.password"),
            textInputType: TextInputType.text,
            obscureText: value,
            suffix: IconButton(
              onPressed: () {
                _passwordObscure.value = !_passwordObscure.value;
              },
              icon: Icon(
                value ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter some text";
              }

              // if (!FormValidationUtil.password(value)) {
              //   return "Baca lagi ketentuan nya yyaakkk wahai customer";
              // }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoading,
          initialText: context.tr("sign_in.sign_in_btn"),
          buttonStyle: CustomButtonStyles.none,
          decoration:
              CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
          buttonTextStyle:
              CustomTextStyles(context).titleMediumOnPrimaryContainer,
          onPressed: () => _onPressedSignIn(context),
        );
      },
    );
  }

  Widget _signUpButton(BuildContext context) {
    return CustomGradientOutlinedButton(
      text: context.tr("sign_up.sign_up_btn"),
      outerPadding: EdgeInsets.zero,
      innerPadding: EdgeInsets.all(2.h),
      strokeWidth: 2.h,
      colors: [
        appTheme.yellowA700,
        theme(context).colorScheme.primary,
      ],
      textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () => _onPressedSignUp(context),
    );
  }
}
