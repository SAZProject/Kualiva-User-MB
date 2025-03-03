import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/enum/loading_enum.dart';
import 'package:kualiva/_repository/token_manager.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_drop_down.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_loading_dialog.dart';
import 'package:kualiva/common/widget/custom_phone_number.dart';
import 'package:kualiva/common/widget/custom_snack_bar.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/profile/bloc/user_profile_bloc.dart';
import 'package:kualiva/profile/feature/my_profile_user_image.dart';
import 'package:kualiva/profile/widget/my_profile_textfield.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameCtl = TextEditingController();
  final _fullNameCtl = TextEditingController();
  final _phoneNumberCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _dateOfBirthCtl = TextEditingController();
  // final _passwordCtl = TextEditingController();
  // final _pinCtl = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode("62");
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _birthDateFocus = FocusNode();
  // final FocusNode _phoneFocus = FocusNode();
  // final FocusNode _passFocus = FocusNode();
  // final FocusNode _pinFocus = FocusNode();

  final _userProfileImg = ValueNotifier<List<String>>([""]);

  DateTime? _pickedBirthDate;

  List<String> _listGender = [
    "my_profile.unspecified",
    "my_profile.male",
    "my_profile.female",
  ];

  String? _genderValue;

  bool userNameReadOnly = true;
  bool fullNameReadOnly = true;
  bool emailReadOnly = true;
  bool birthDateReadOnly = true;
  // bool _phoneReadOnly = true;
  // bool _passReadOnly = true;
  // bool _pinReadOnly = true;
  // bool _passObscure = true;

  // bool _pinObscure = true;
  bool logoutLoading = false;

  // bool firstOpen = false;
  bool initLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(UserProfileFetched());
  }

  @override
  void dispose() {
    _phoneNumberCtl.dispose();
    // _passwordCtl.dispose();
    // _pinCtl.dispose();
    _usernameCtl.dispose();
    _fullNameCtl.dispose();
    _emailCtl.dispose();
    _dateOfBirthCtl.dispose();
    super.dispose();
  }

  void _updateProfileFunc() {
    context.read<UserProfileBloc>().add(
          UserProfileUpdated(
            fullName: _fullNameCtl.text.trim(),
            birthDate: _pickedBirthDate!,
            gender: _genderValue!,
            photoFile: _userProfileImg.value[0],
          ),
        );
  }

  void _logoutProfileFunc() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          contentPadding: EdgeInsets.all(10.h),
          elevation: 0.0,
          title: Center(
            child: Text(
              context.tr("my_profile.logout_confirmation"),
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
                  onPressed: () => Navigator.pop(context),
                  // pop logout dialog
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
                        if (!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.signInScreen, (route) => false);
                      },
                    );
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pickedBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _pickedBirthDate) {
      _dateOfBirthCtl.text = DatetimeUtils.dmy(picked);
      setState(() {
        _pickedBirthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoading) {
          if (state.loadingState == LoadingEnum.update) {
            customLoadingDialog(context: context);
          }
        }
        if (state is UserProfileUpdateSuccess) {
          Navigator.pop(context);
        }
        if (state is UserProfileUpdateFailure) {
          showSnackBar(context, Icons.error_outline, Colors.red,
              context.tr("common.error_try_again"), Colors.red);
        }
        if (state is UserProfileFetchFailure) {
          Navigator.pop(context);
          showSnackBar(context, Icons.error_outline, Colors.red,
              context.tr("common.error_try_again"), Colors.red);
        }
        if (state is UserProfileFetchSuccess) {
          // firstOpen = true;
          final user = state.user;

          _userProfileImg.value = [user.profile?.photoFile ?? ""];
          _usernameCtl.text = user.username;
          _fullNameCtl.text =
              user.profile == null ? "" : user.profile!.fullName ?? "";
          _phoneNumberCtl.text = user.phone;
          _emailCtl.text = user.email;
          if (user.profile != null && user.profile!.gender != null) {
            if (user.profile!.gender == "MALE") {
              _genderValue = context.tr("my_profile.male");
            } else {
              _genderValue = context.tr("my_profile.female");
            }
          } else {
            _genderValue = context.tr("my_profile.unspecified");
          }
          if (user.profile != null && user.profile!.birthDate != null) {
            _dateOfBirthCtl.text = DatetimeUtils.dmy(user.profile!.birthDate!);
            _pickedBirthDate = user.profile!.birthDate;
          } else {
            _dateOfBirthCtl.text = "";
          }

          setState(() {
            initLoading = false;
            _listGender = List.generate(
              _listGender.length,
              (index) => context.tr(_listGender[index]),
              growable: false,
            );
          });
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _myProfileAppBar(context),
          body: SizedBox(
            width: double.maxFinite,
            height: Sizeutils.height,
            child: _body(context),
          ),
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
                MyProfileUserImage(userProfileImg: _userProfileImg),
                SizedBox(height: 5.h),
                MyProfileTextfield(
                  focusNode: _userNameFocus,
                  isReadOnly: userNameReadOnly,
                  headerLabel: context.tr("my_profile.username"),
                  controller: _usernameCtl,
                ),
                SizedBox(height: 5.h),
                MyProfileTextfield(
                  focusNode: _fullNameFocus,
                  isReadOnly: fullNameReadOnly,
                  headerLabel: context.tr("my_profile.fullname"),
                  controller: _fullNameCtl,
                  useSuffix: true,
                  suffix: fullNameReadOnly
                      ? context.tr("my_profile.edit")
                      : context.tr("common.cancel"),
                  suffixOnTap: () {
                    setState(() {
                      fullNameReadOnly = !fullNameReadOnly;
                      if (fullNameReadOnly == false) {
                        _fullNameFocus.requestFocus();
                      }
                    });
                  },
                ),
                SizedBox(height: 5.h),
                MyProfileTextfield(
                  focusNode: _emailFocus,
                  isReadOnly: emailReadOnly,
                  headerLabel: context.tr("my_profile.email"),
                  controller: _emailCtl,
                  useSuffix: true,
                  suffix: emailReadOnly
                      ? context.tr("my_profile.edit")
                      : context.tr("common.cancel"),
                  useVerifyWidget: true,
                  suffixOnTap: () {
                    setState(() {
                      emailReadOnly = !emailReadOnly;
                      if (emailReadOnly == false) {
                        _emailFocus.requestFocus();
                      }
                    });
                  },
                ),
                SizedBox(height: 5.h),
                _buildTextFieldPhoneNumber(
                  context,
                  headerLabel: context.tr("my_profile.phone_number"),
                  controller: _phoneNumberCtl,
                  // focusNode: _phoneFocus,
                  // isReadOnly: _phoneReadOnly,
                  // onEditPressed: () {
                  //   setState(() {
                  //     _phoneReadOnly = !_phoneReadOnly;
                  //     if (_phoneReadOnly == false) {
                  //       _phoneFocus.requestFocus();
                  //     }
                  //   });
                  // },
                ),
                SizedBox(height: 5.h),
                BlocBuilder<UserProfileBloc, UserProfileState>(
                    builder: (context, state) {
                  if ((state is UserProfileFetchSuccess ||
                          state is UserProfileUpdateSuccess ||
                          state is UserProfileUpdateFailure) &&
                      !initLoading) {
                    return _buildGenderTextField(
                      context,
                      headerLabel: context.tr("my_profile.gender"),
                      selectedGender:
                          _genderValue ?? context.tr("my_profile.unspecified"),
                      items: _listGender,
                      hintText: context.tr("my_profile.gender_hint"),
                      onChange: (genderVal) {
                        setState(() {
                          _genderValue = genderVal;
                        });
                      },
                    );
                  }
                  return Center(child: LinearProgressIndicator());
                }),
                SizedBox(height: 10.h),
                MyProfileTextfield(
                  focusNode: _birthDateFocus,
                  isReadOnly: birthDateReadOnly,
                  headerLabel: context.tr("my_profile.date_of_birth"),
                  controller: _dateOfBirthCtl,
                  useSuffix: true,
                  isDateTimeField: true,
                  dateTimeFieldOnTap: () => _selectDate(context),
                ),
                SizedBox(height: 5.h),
                // TODO dimatikan untuk prototype testing
                // _textFieldPinPass(
                //   context,
                //   headerLabel: context.tr("my_profile.password"),
                //   controller: _passwordCtl,
                //   hintText: context.tr("my_profile.password"),
                //   isObscure: _passObscure,
                //   onPressed: () {
                //     setState(() {
                //       _passObscure = !_passObscure;
                //     });
                //   },
                //   isReadOnly: _passReadOnly,
                //   focusNode: _passFocus,
                //   onEditPressed: () {
                //     setState(() {
                //       _passReadOnly = !_passReadOnly;
                //       if (_passReadOnly == false) {
                //         _passFocus.requestFocus();
                //       }
                //     });
                //   },
                // ),
                // SizedBox(height: 5.h),
                // _textFieldPinPass(
                //   context,
                //   headerLabel: context.tr("my_profile.pin"),
                //   controller: _pinCtl,
                //   hintText: context.tr("my_profile.pin"),
                //   isObscure: _pinObscure,
                //   onPressed: () {
                //     setState(() {
                //       _pinObscure = !_pinObscure;
                //     });
                //   },
                //   isReadOnly: _pinReadOnly,
                //   focusNode: _pinFocus,
                //   onEditPressed: () {
                //     setState(() {
                //       _pinReadOnly = !_pinReadOnly;
                //       if (_pinReadOnly == false) {
                //         _pinFocus.requestFocus();
                //       }
                //     });
                //   },
                // ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, state) {
                      return _myProfileBtn(
                        context,
                        btnLabel: context.tr("my_profile.save_btn"),
                        colors: [
                          appTheme.yellowA700,
                          theme(context).colorScheme.primary,
                        ],
                        strokeWidth: 2.h,
                        onPressed: state is UserProfileLoading &&
                                state.loadingState == LoadingEnum.update
                            ? null
                            : () => _updateProfileFunc(),
                      );
                    }),
                    _myProfileBtn(
                      context,
                      btnLabel: context.tr("my_profile.log_out_btn"),
                      colors: [
                        appTheme.redA700,
                        theme(context).colorScheme.primaryContainer,
                      ],
                      strokeWidth: 1.h,
                      onPressed: _logoutProfileFunc,
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _myProfileAppBar(BuildContext context) {
    return CustomAppBar(title: context.tr("my_profile.title"));
  }

  Widget _buildTextFieldPhoneNumber(
    BuildContext context, {
    required String headerLabel,
    required TextEditingController controller,
    // required FocusNode focusNode,
    // required bool isReadOnly,
    // required Function()? onEditPressed,
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
                // focusNode: focusNode,
                readOnly: true,
                textInputType: TextInputType.phone,
                // suffix: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Align(
                //       alignment: Alignment.centerRight,
                //       child: Padding(
                //         padding: EdgeInsets.only(right: 10.h),
                //         child: InkWell(
                //           onTap: onEditPressed,
                //           child: Text(
                //             context.tr(
                //               isReadOnly ? "my_profile.edit" : "common.cancel",
                //             ),
                //             style:
                //                 CustomTextStyles(context).bodySmall12.copyWith(
                //                       color: isReadOnly
                //                           ? theme(context).colorScheme.primary
                //                           : theme(context)
                //                               .colorScheme
                //                               .primaryContainer,
                //                     ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderTextField(
    BuildContext context, {
    required String headerLabel,
    required String selectedGender,
    required List<String> items,
    required String hintText,
    Function(String)? onChange,
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
            SizedBox(height: 4.h),
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.only(left: 16.h),
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 25.h,
                ),
              ),
              iconSize: 25.h,
              hintText: hintText,
              value: selectedGender,
              items: items,
              contentPadding: EdgeInsets.all(10.h),
              onChange: onChange,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _textFieldPinPass(
  //   BuildContext context, {
  //   required String headerLabel,
  //   required TextEditingController controller,
  //   required FocusNode focusNode,
  //   required String hintText,
  //   required bool isObscure,
  //   required Function()? onPressed,
  //   required bool isReadOnly,
  //   required Function()? onEditPressed,
  // }) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 10.h),
  //     child: SizedBox(
  //       width: double.maxFinite,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             headerLabel,
  //             textAlign: TextAlign.center,
  //             style: theme(context).textTheme.bodyMedium!.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //           SizedBox(height: 5.h),
  //           CustomTextFormField(
  //             focusNode: focusNode,
  //             controller: controller,
  //             hintText: hintText,
  //             textInputType: TextInputType.text,
  //             obscureText: isObscure,
  //             readOnly: isReadOnly,
  //             suffix: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 IconButton(
  //                   onPressed: onPressed,
  //                   icon: Icon(
  //                     isObscure ? Icons.visibility : Icons.visibility_off,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(right: 10.h),
  //                   child: InkWell(
  //                     onTap: onEditPressed,
  //                     child: Text(
  //                       context.tr(
  //                           isReadOnly ? "my_profile.edit" : "common.cancel"),
  //                       style: CustomTextStyles(context).bodySmall12.copyWith(
  //                             color: isReadOnly
  //                                 ? theme(context).colorScheme.primary
  //                                 : theme(context).colorScheme.primaryContainer,
  //                           ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _myProfileBtn(
    BuildContext context, {
    required String btnLabel,
    required List<Color> colors,
    Function()? onPressed,
    required double strokeWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: CustomGradientOutlinedButton(
        text: btnLabel,
        width: 100.h,
        outerPadding: EdgeInsets.symmetric(horizontal: 20.h),
        strokeWidth: strokeWidth,
        colors: colors,
        textStyle:
            CustomTextStyles(context).titleMediumOnPrimaryContainer.copyWith(
                  color: theme(context).colorScheme.primaryContainer,
                ),
        onPressed: onPressed,
      ),
    );
  }
}
