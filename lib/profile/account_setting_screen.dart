import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/auth/repository/token_manager.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_gradient_outlined_button.dart';
import 'package:like_it/common/widget/custom_phone_number.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accCreationCtl = TextEditingController();
  final TextEditingController _phoneNumberCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  final TextEditingController _pinCtl = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode("62");
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _pinFocus = FocusNode();
  bool _phoneReadOnly = true;
  bool _passReadOnly = true;
  bool _pinReadOnly = true;
  bool _passObscure = true;
  bool _pinObscure = true;

  bool logoutLoading = false;

  @override
  void dispose() {
    _accCreationCtl.dispose();
    _phoneNumberCtl.dispose();
    _passwordCtl.dispose();
    _pinCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _accSettingAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      height: Sizeutils.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 5.h),
                _buildUserImage(context),
                SizedBox(height: 5.h),
                _buildAccCreationDate(
                  context,
                  headerLabel:
                      context.tr("account_setting.account_creation_date"),
                ),
                SizedBox(height: 5.h),
                _textFieldPhoneNumber(
                  context,
                  headerLabel: context.tr("account_setting.phone_number"),
                  controller: _phoneNumberCtl,
                  focusNode: _phoneFocus,
                  isReadOnly: _phoneReadOnly,
                  onEditPressed: () {
                    setState(() {
                      _phoneReadOnly = !_phoneReadOnly;
                      if (_phoneReadOnly == false) {
                        _phoneFocus.requestFocus();
                      }
                    });
                  },
                ),
                SizedBox(height: 5.h),
                _textFieldPinPass(
                  context,
                  headerLabel: context.tr("account_setting.password"),
                  controller: _passwordCtl,
                  hintText: context.tr("account_setting.password"),
                  isObscure: _passObscure,
                  onPressed: () {
                    setState(() {
                      _passObscure = !_passObscure;
                    });
                  },
                  isReadOnly: _passReadOnly,
                  focusNode: _passFocus,
                  onEditPressed: () {
                    setState(() {
                      _passReadOnly = !_passReadOnly;
                      if (_passReadOnly == false) {
                        _passFocus.requestFocus();
                      }
                    });
                  },
                ),
                SizedBox(height: 5.h),
                _textFieldPinPass(
                  context,
                  headerLabel: context.tr("account_setting.pin"),
                  controller: _pinCtl,
                  hintText: context.tr("account_setting.pin"),
                  isObscure: _pinObscure,
                  onPressed: () {
                    setState(() {
                      _pinObscure = !_pinObscure;
                    });
                  },
                  isReadOnly: _pinReadOnly,
                  focusNode: _pinFocus,
                  onEditPressed: () {
                    setState(() {
                      _pinReadOnly = !_pinReadOnly;
                      if (_pinReadOnly == false) {
                        _pinFocus.requestFocus();
                      }
                    });
                  },
                ),
                SizedBox(height: 100.h),
                _logOutBtn(context),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _accSettingAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("account_setting.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _buildUserImage(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomImageView(
        imagePath: ImageConstant.arasaka,
        height: 100.0,
        width: 100.0,
        boxFit: BoxFit.contain,
        radius: BorderRadius.circular(25.0),
      ),
    );
  }

  Widget _buildAccCreationDate(
    BuildContext context, {
    required String headerLabel,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerLabel,
              textAlign: TextAlign.center,
              style: theme(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            CustomTextFormField(
              controller: _accCreationCtl,
              hintText: context.tr("account_setting.account_creation_date"),
              readOnly: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 16.h,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldPhoneNumber(
    BuildContext context, {
    required String headerLabel,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isReadOnly,
    required Function()? onEditPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerLabel,
              textAlign: TextAlign.center,
              style: theme(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            CustomPhoneNumber(
              country: selectedCountry,
              // controller: controller,
              // textInputType: TextInputType.phone,
              onPressed: (Country country) {
                selectedCountry = country;
              },
              textFormField: CustomTextFormField(
                controller: controller,
                focusNode: focusNode,
                readOnly: isReadOnly,
                textInputType: TextInputType.phone,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.h),
                        child: InkWell(
                          onTap: onEditPressed,
                          child: Text(
                            context.tr(
                              isReadOnly
                                  ? "account_setting.edit"
                                  : "common.cancel",
                            ),
                            style:
                                CustomTextStyles(context).bodySmall12.copyWith(
                                      color: isReadOnly
                                          ? theme(context).colorScheme.primary
                                          : theme(context)
                                              .colorScheme
                                              .primaryContainer,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldPinPass(
    BuildContext context, {
    required String headerLabel,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required bool isObscure,
    required Function()? onPressed,
    required bool isReadOnly,
    required Function()? onEditPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerLabel,
              textAlign: TextAlign.center,
              style: theme(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            CustomTextFormField(
              focusNode: focusNode,
              controller: controller,
              hintText: hintText,
              textInputType: TextInputType.text,
              obscureText: isObscure,
              readOnly: isReadOnly,
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.h),
                    child: InkWell(
                      onTap: onEditPressed,
                      child: Text(
                        context.tr(isReadOnly
                            ? "account_setting.edit"
                            : "common.cancel"),
                        style: CustomTextStyles(context).bodySmall12.copyWith(
                              color: isReadOnly
                                  ? theme(context).colorScheme.primary
                                  : theme(context).colorScheme.primaryContainer,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logOutBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: CustomGradientOutlinedButton(
        text: context.tr("account_setting.log_out_btn"),
        outerPadding: EdgeInsets.symmetric(horizontal: 20.h),
        strokeWidth: 1.h,
        colors: [
          appTheme.redA700,
          theme(context).colorScheme.primaryContainer,
        ],
        textStyle:
            CustomTextStyles(context).titleMediumOnPrimaryContainer.copyWith(
                  color: theme(context).colorScheme.primaryContainer,
                ),
        onPressed: _logoutDialog,
      ),
    );
  }

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          contentPadding: EdgeInsets.all(10.h),
          elevation: 0.0,
          title: Center(
            child: Text(
              context.tr("account_setting.logout_confirmation"),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: <Widget>[
            Column(
              children: [
                CustomElevatedButton(
                  onPressed: () => Navigator.pop(context), // pop logout dialog
                  initialText: context.tr("common.cancel"),
                  buttonStyle: CustomButtonStyles.none,
                  decoration:
                      CustomDecoration(context).outlineOnPrimaryContainer,
                  buttonTextStyle:
                      CustomTextStyles(context).titlesmall_15.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                ),
                SizedBox(height: 10.h),
                CustomElevatedButton(
                  isLoading: logoutLoading,
                  onPressed: () async {
                    final tokenManager = context.read<TokenManager>();
                    tokenManager.deleteToken().then(
                      (value) {
                        setState(() {
                          logoutLoading = true;
                        });
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.signInScreen, (route) => false);
                      },
                    );
                    //TODO loading masih perlu dibenerin mungkin pas pake BLoc
                  },
                  initialText: context.tr("common.yes"),
                  buttonStyle: CustomButtonStyles.none,
                  decoration: CustomDecoration(context).outlinePrimaryContainer,
                  buttonTextStyle:
                      CustomTextStyles(context).titlesmall_15.copyWith(
                            color: theme(context).colorScheme.primaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
