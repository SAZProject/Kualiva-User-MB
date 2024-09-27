import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';

class OnboardingPickBirthdate extends StatelessWidget {
  const OnboardingPickBirthdate({
    super.key,
    required this.leftIcon,
    required this.label,
    required this.hintText,
    this.onHintPressed,
    this.onPressed,
  });

  final IconData leftIcon;
  final String label;
  final String hintText;
  final Function()? onHintPressed;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          alignment: Alignment.center,
          leftIcon: Icon(
            leftIcon,
            size: 16.h,
          ),
          initialText: label,
          onPressed: onPressed,
        ),
        InkWell(
          onTap: onHintPressed,
          child: Text(
            hintText,
            style: CustomTextStyles(context).bodySmallPrimary12,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
