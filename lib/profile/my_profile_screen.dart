import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/profile/bloc/user_profile_bloc.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _usernameCtl = TextEditingController();
  final _firstnameCtl = TextEditingController();
  final _lastnameCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _genderCtl = TextEditingController();
  final _dateOfBirthCtl = TextEditingController();

  bool firstOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(UserProfileFetched());
  }

  @override
  void dispose() {
    _usernameCtl.dispose();
    _firstnameCtl.dispose();
    _lastnameCtl.dispose();
    _emailCtl.dispose();
    _genderCtl.dispose();
    _dateOfBirthCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileSuccess && firstOpen == false) {
          firstOpen = true;
          final user = state.user;

          _usernameCtl.text = user.username;
          _firstnameCtl.text = user.profile.firstname;
          _lastnameCtl.text = user.profile.lastname;
          _emailCtl.text = user.email;
          _genderCtl.text = user.profile.gender;
          _dateOfBirthCtl.text = DatetimeUtils.dmy(user.profile.birthDate);
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
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _buildUserImage(context),
              SizedBox(height: 5.h),
              _buildTextField(
                context,
                headerLabel: context.tr("my_profile.username"),
                controller: _usernameCtl,
                // hintText: context.tr("my_profile.username_hint"),
                // suffix: context.tr("my_profile.edit"),
              ),
              SizedBox(height: 5.h),
              _buildTextField(
                context,
                headerLabel: context.tr("my_profile.firstname"),
                controller: _firstnameCtl,
              ),
              SizedBox(height: 5.h),
              _buildTextField(
                context,
                headerLabel: context.tr("my_profile.lastname"),
                controller: _lastnameCtl,
              ),
              SizedBox(height: 5.h),
              _buildTextField(
                context,
                headerLabel: context.tr("my_profile.email"),
                controller: _emailCtl,
                // suffix: context.tr("my_profile.verify"),
              ),
              SizedBox(height: 5.h),
              _buildTextField(
                context,
                headerLabel: context.tr("my_profile.gender"),
                controller: _genderCtl,
              ),
              SizedBox(height: 5.h),
              _buildTextField(
                context,
                headerLabel: context.tr("my_profile.date_of_birth"),
                controller: _dateOfBirthCtl,
              ),
              SizedBox(height: 100.h),
              _saveBtn(context),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _myProfileAppBar(BuildContext context) {
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
          context.tr("my_profile.title"),
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

  Widget _buildTextField(
    BuildContext context, {
    required String headerLabel,
    required TextEditingController controller,
    String? hintText,
    String? suffix,
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
            CustomTextFormField(
              controller: controller,
              readOnly: true,
              suffix: suffix != null
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.h),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            suffix,
                            style:
                                CustomTextStyles(context).bodySmall12.copyWith(
                                      color: theme(context).colorScheme.primary,
                                    ),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            Text(
              hintText ?? "",
              textAlign: TextAlign.center,
              style: theme(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveBtn(BuildContext context) {
    return CustomGradientOutlinedButton(
      text: context.tr("my_profile.save_btn"),
      outerPadding: EdgeInsets.symmetric(horizontal: 20.h),
      innerPadding: EdgeInsets.all(2.h),
      strokeWidth: 2.h,
      colors: [
        appTheme.yellowA700,
        theme(context).colorScheme.primary,
      ],
      textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () {},
    );
  }
}
