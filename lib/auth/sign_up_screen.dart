import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/form_validation_util.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/save_pref.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_phone_number.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/common/widget/custom_snack_bar.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userNameCtl = TextEditingController();
  final _phoneNumberCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final _confirmPassCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode("62");

  final _passwordObscure = ValueNotifier<bool>(true);
  final _confirmPasswordObscure = ValueNotifier<bool>(true);
  final _password = ValueNotifier<String>("");

  bool tosAgreement = false;

  @override
  void initState() {
    super.initState();
    tosAgreement = SavePref().readTosData();
  }

  @override
  void dispose() {
    _userNameCtl.dispose();
    _phoneNumberCtl.dispose();
    _emailCtl.dispose();
    _passwordCtl.dispose();
    _confirmPassCtl.dispose();
    _passwordObscure.dispose();
    super.dispose();
  }

  void _onPressedSignUp(BuildContext context) {
    if (_formKey.currentState!.validate() == false) return;

    if (!tosAgreement) {
      Navigator.pushNamed(context, AppRoutes.tosScreen).then(
        (value) {
          if (value == null) return;
          setState(() {
            tosAgreement = value as bool;
          });
          SavePref().saveTosData();
          if (!context.mounted) return;

          context.read<AuthBloc>().add(
                AuthRegistered(
                  username: _userNameCtl.text.trim(),
                  phoneNumber:
                      '${selectedCountry.phoneCode}${_phoneNumberCtl.text.trim()}',
                  email: _emailCtl.text.trim(),
                  password: _passwordCtl.text.trim(),
                  confirmPassword: _confirmPassCtl.text.trim(),
                ),
              );
        },
      );
    } else {
      context.read<AuthBloc>().add(
            AuthRegistered(
              username: _userNameCtl.text.trim(),
              phoneNumber:
                  '${selectedCountry.phoneCode}${_phoneNumberCtl.text.trim()}',
              email: _emailCtl.text.trim(),
              password: _passwordCtl.text.trim(),
              confirmPassword: _confirmPassCtl.text.trim(),
            ),
          );
    }
  }

  void _alreadyHaveAccount(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          Navigator.pushNamed(context, AppRoutes.otpScreen);
        }
        if (state is AuthRegisterFailure) {
          if (state.failure.source == DataSourceEnum.unprocessableEntity) {
            Map<String, String> errors = state.failure.error ?? {};
            LeLog.sd(this, build, errors.toString());
            final msg = errors.values.fold(
                '', (previousValue, element) => '$previousValue$element\n');
            LeLog.sd(this, build, msg.toString());
            showSnackBar(context, Icons.error_outline, Colors.red, msg.trim(),
                Colors.red);
            return;
          }
          showSnackBar(
            context,
            Icons.error_outline,
            Colors.red,
            "${state.failure.source.code} ${state.failure.source.message}",
            Colors.red,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _signUpAppBar(context),
          body: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _signUpAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("sign_up.title"),
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
        child: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: _formKey,
            child: _signUpMenu(context),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: SizedBox(
              width: double.maxFinite,
              child: _fieldInputRequirement(
                context,
                canBeEdited: context.tr("sign_up.username_hint_1"),
                totalChar: context.tr("sign_up.username_hint_2"),
                lettersNumbers: context.tr("sign_up.username_hint_3"),
                specialChar: context.tr("sign_up.username_hint_4"),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          _textFieldPhoneNumber(context),
          SizedBox(height: 10.h),
          _textFieldEmail(context),
          SizedBox(height: 10.h),
          _textFieldPassword(context),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: SizedBox(
              width: double.maxFinite,
              child: _fieldInputRequirement(
                context,
                canBeEdited: context.tr("sign_up.password_hint_1"),
                totalChar: context.tr("sign_up.password_hint_2"),
                lettersNumbers: context.tr("sign_up.password_hint_3"),
                specialChar: context.tr("sign_up.username_hint_4"),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          _textFieldConfirmPassword(context),
          SizedBox(height: 5.h),
          _buildTos(context),
          SizedBox(height: 20.h),
          _signUpButton(context),
          SizedBox(height: 5.h),
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
                        color: theme(context).colorScheme.primary,
                        decorationColor: theme(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _alreadyHaveAccount(context),
                ),
                TextSpan(
                  text: context.tr("sign_up.here"),
                  style: CustomTextStyles(context).bodySmallOnPrimaryContainer,
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }

  Widget _textFieldUserName(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            label: context.tr("sign_up.username"),
            useIcon: false,
            textStyle: theme(context)
                .textTheme
                .bodySmall!
                .copyWith(color: theme(context).colorScheme.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: CustomTextFormField(
              controller: _userNameCtl,
              hintText: context.tr("sign_up.username"),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 15.h,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }

                if (!FormValidationUtil.username(value)) {
                  return "Tidak sesuai ketentuan";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldEmail(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            label: context.tr("sign_up.email"),
            useIcon: false,
            textStyle: theme(context)
                .textTheme
                .bodySmall!
                .copyWith(color: theme(context).colorScheme.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: CustomTextFormField(
              controller: _emailCtl,
              hintText: context.tr("sign_up.email"),
              textInputType: TextInputType.emailAddress,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 16.h,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }

                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldPhoneNumber(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            label: context.tr("sign_up.phone_number"),
            useIcon: false,
            textStyle: theme(context)
                .textTheme
                .bodySmall!
                .copyWith(color: theme(context).colorScheme.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: CustomPhoneNumber(
              country: selectedCountry,
              onPressed: (Country country) {
                selectedCountry = country;
              },
              textFormField: CustomTextFormField(
                controller: _phoneNumberCtl,
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  if (value[0] == '0') return 'Cannot input 0 at the start';

                  if (!FormValidationUtil.phoneNumber(value)) {
                    return "Tidak sesuai ketentuan";
                  }

                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            label: context.tr("sign_up.password"),
            useIcon: false,
            textStyle: theme(context)
                .textTheme
                .bodySmall!
                .copyWith(color: theme(context).colorScheme.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: ValueListenableBuilder(
              valueListenable: _passwordObscure,
              builder: (context, value, child) {
                return CustomTextFormField(
                  controller: _passwordCtl,
                  hintText: context.tr("sign_up.password"),
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
                  onChange: (value) {
                    _password.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }

                    if (!FormValidationUtil.password(value)) {
                      return "Tidak sesuai ketentuan";
                    }
                    return null;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldConfirmPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            label: context.tr("sign_up.re_enter_password"),
            useIcon: false,
            textStyle: theme(context)
                .textTheme
                .bodySmall!
                .copyWith(color: theme(context).colorScheme.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: ValueListenableBuilder(
              valueListenable: _confirmPasswordObscure,
              builder: (context, value, child) {
                return CustomTextFormField(
                  controller: _confirmPassCtl,
                  hintText: context.tr("sign_up.re_enter_password"),
                  textInputType: TextInputType.text,
                  obscureText: value,
                  suffix: IconButton(
                    onPressed: () {
                      _confirmPasswordObscure.value =
                          !_confirmPasswordObscure.value;
                    },
                    icon: Icon(
                      value ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }

                    if (value != _password.value) {
                      return "Confirm Password do not match";
                    }

                    return null;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoading,
          initialText: context.tr("sign_up.sign_up_btn"),
          buttonStyle: CustomButtonStyles.fillprimary(context),
          decoration: null,
          buttonTextStyle:
              CustomTextStyles(context).titleMediumOnSecondaryContainer,
          onPressed: () => _onPressedSignUp(context),
        );
      },
    );
  }

  Widget _fieldInputRequirement(
    BuildContext context, {
    required String canBeEdited,
    required String totalChar,
    required String lettersNumbers,
    required String specialChar,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          canBeEdited,
          style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                color: theme(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withValues(alpha: 0.6),
              ),
        ),
        SizedBox(height: 2.h),
        Text(
          "\u2022 $totalChar",
          style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                color: theme(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withValues(alpha: 0.6),
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
                      .withValues(alpha: 0.6),
                ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          "\u2022 $specialChar",
          style: CustomTextStyles(context).bodySmallBlack900.copyWith(
                color: theme(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildTos(BuildContext context) {
    return SizedBox(
      width: Sizeutils.width,
      child: Row(
        children: [
          Checkbox(
            value: tosAgreement,
            onChanged: (value) {
              Navigator.pushNamed(context, AppRoutes.tosScreen).then(
                (value) {
                  if (value == null) return;
                  setState(() {
                    tosAgreement = value as bool;
                  });
                  SavePref().saveTosData();
                },
              );
            },
          ),
          Flexible(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.tr("tos.tos_statement"),
                    style:
                        CustomTextStyles(context).bodySmallOnPrimaryContainer,
                  ),
                  TextSpan(
                    text: context.tr("tos.tos"),
                    style: theme(context).textTheme.labelMedium!.copyWith(
                          color: theme(context).colorScheme.primary,
                          decorationColor: theme(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, AppRoutes.tosScreen).then(
                          (value) {
                            if (value == null) return;
                            setState(() {
                              tosAgreement = value as bool;
                            });
                            SavePref().saveTosData();
                          },
                        );
                      },
                  ),
                  TextSpan(
                      text: " ", style: theme(context).textTheme.labelMedium),
                  TextSpan(
                    text: context.tr("tos.and"),
                    style:
                        CustomTextStyles(context).bodySmallOnPrimaryContainer,
                  ),
                  TextSpan(
                    text: context.tr("tos.policy"),
                    style: theme(context).textTheme.labelMedium!.copyWith(
                          color: theme(context).colorScheme.primary,
                          decorationColor: theme(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, AppRoutes.tosScreen).then(
                          (value) {
                            if (value == null) return;
                            setState(() {
                              tosAgreement = value as bool;
                            });
                            SavePref().saveTosData();
                          },
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
