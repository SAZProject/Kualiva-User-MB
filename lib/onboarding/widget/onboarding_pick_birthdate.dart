import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';

class OnboardingPickBirthdate extends StatelessWidget {
  const OnboardingPickBirthdate({
    super.key,
    required this.fullNameCtl,
    required this.fullNameHint,
    this.leftIcon,
    required this.label,
    required this.hintText,
    this.onHintPressed,
    this.onPressed,
  });

  final TextEditingController fullNameCtl;
  final String fullNameHint;
  final IconData? leftIcon;
  final String label;
  final String hintText;
  final Function()? onHintPressed;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldFullname(context),
          SizedBox(height: 10.h),
          CustomElevatedButton(
            alignment: Alignment.center,
            leftIcon: Icon(
              leftIcon,
              size: 20.h,
              color: theme(context).colorScheme.onPrimaryContainer,
            ),
            initialText: label,
            onPressed: onPressed,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomDecoration(context).outline,
            buttonTextStyle:
                CustomTextStyles(context).titleMediumOnPrimaryContainer,
          ),
          SizedBox(height: 10.h),
          InkWell(
            onTap: onHintPressed,
            child: Text(
              hintText,
              style: CustomTextStyles(context).bodySmallPrimary12,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _textFieldFullname(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomTextFormField(
        controller: fullNameCtl,
        hintText: fullNameHint,
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
}
