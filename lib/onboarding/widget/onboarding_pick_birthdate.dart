import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';

class OnboardingPickBirthdate extends StatelessWidget {
  const OnboardingPickBirthdate({
    super.key,
    this.leftIcon,
    required this.label,
    required this.hintText,
    this.onHintPressed,
    this.onPressed,
  });

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
}
