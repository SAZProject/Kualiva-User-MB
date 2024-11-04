import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:like_it/auth/bloc/auth_bloc.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_phone_number.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userNameCtl = TextEditingController();
  final _phoneNumberCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final _confirmPassCtl = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode("62");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passObscure = true;
  bool confirmPassObscure = true;

  @override
  void dispose() {
    _userNameCtl.dispose();
    _phoneNumberCtl.dispose();
    _passwordCtl.dispose();
    _confirmPassCtl.dispose();
    super.dispose();
  }

  void _onPressedSignUp(BuildContext context) {
    if (_passwordCtl.text.trim() != _confirmPassCtl.text.trim()) {
      // TODO Winky, mau diapain kalo password dan confirm password tidak sama ?
    }

    // context.read<AuthBloc>().add(
    //       AuthRegistered(
    //         username: "lerrr",
    //         phoneNumber: "321111",
    //         password: "321321",
    //       ),
    //     );

    context.read<AuthBloc>().add(
          AuthRegistered(
            username: _userNameCtl.text.trim(),
            phoneNumber: _phoneNumberCtl.text.trim(),
            password: _passwordCtl.text.trim(),
          ),
        );
  }

  void _alreadyhaveAccount(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        debugPrint(state.runtimeType.toString());
        if (state is AuthRegisterSuccess) {
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  SizedBox(height: 26.h),
                  CustomImageView(
                    imagePath: ImageConstant.appLogo,
                    height: 100.h,
                    width: 100.h,
                  ),
                  SizedBox(height: 34.h),
                  _signUpMenu(context),
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

  Widget _signUpMenu(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          _textFieldUserName(context),
          SizedBox(height: 2.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 4.h),
            child: _fieldInputRequirement(
              context,
              totalChar: context.tr("sign_up.username_hint_1"),
              lettersNumbers: context.tr("sign_up.username_hint_2"),
              canBeEdited: context.tr("sign_up.username_hint_3"),
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
              width: double.maxFinite, child: _textFieldPhoneNumber(context)),
          SizedBox(height: 10.h),
          _textFieldPassword(context),
          SizedBox(height: 2.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 4.h),
            child: _fieldInputRequirement(
              context,
              totalChar: context.tr("sign_up.password_hint_1"),
              lettersNumbers: context.tr("sign_up.password_hint_2"),
              canBeEdited: context.tr("sign_up.password_hint_3"),
            ),
          ),
          SizedBox(height: 6.h),
          _textFieldConfirmPassword(context),
          SizedBox(height: 10.h),
          _signUpButton(context),
          SizedBox(height: 8.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: context.tr("sign_up.already_had_acc"),
                  style: CustomTextStyles(context).bodySmallOnPrimaryContainer,
                ),
                TextSpan(
                  text: context.tr("sign_up.sign_in_link"),
                  style: theme(context).textTheme.labelMedium!.copyWith(
                        color: appTheme.yellowA700,
                        decorationColor: appTheme.yellowA700,
                        decoration: TextDecoration.underline,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _alreadyhaveAccount(context),
                ),
                TextSpan(
                  text: context.tr("sign_up.here"),
                  style: CustomTextStyles(context).bodySmallOnPrimaryContainer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldUserName(BuildContext context) {
    return CustomTextFormField(
      controller: _userNameCtl,
      hintText: context.tr("sign_up.username"),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 16.h,
      ),
    );
  }

  Widget _textFieldPhoneNumber(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomPhoneNumber(
        country: selectedCountry,
        controller: _phoneNumberCtl,
        onPressed: (Country country) {
          selectedCountry = country;
        },
      ),
    );
  }

  Widget _textFieldPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomTextFormField(
        controller: _passwordCtl,
        hintText: context.tr("sign_up.password"),
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

  Widget _textFieldConfirmPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomTextFormField(
        controller: _confirmPassCtl,
        hintText: context.tr("sign_up.re_enter_password"),
        textInputType: TextInputType.text,
        obscureText: confirmPassObscure,
        suffix: IconButton(
          onPressed: () {
            setState(() {
              confirmPassObscure = !confirmPassObscure;
            });
          },
          icon: Icon(
            confirmPassObscure ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("sign_up.sign_up_btn"),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () => _onPressedSignUp(context),
    );
  }

  Widget _fieldInputRequirement(
    BuildContext context, {
    required String totalChar,
    required String lettersNumbers,
    required String canBeEdited,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\u2022 $totalChar",
          style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                color: theme(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(0.6),
              ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: 256.h,
          child: Text(
            "\u2022 $lettersNumbers",
            style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                  color: theme(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.6),
                ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          "\u2022 $canBeEdited",
          style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                color: theme(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}
