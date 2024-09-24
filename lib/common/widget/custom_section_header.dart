import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class CustomSectionHeader extends StatelessWidget {
  const CustomSectionHeader({
    super.key,
    required this.label,
    this.onPressed,
    this.useIcon = true,
  });

  final String label;
  final Function()? onPressed;
  final bool useIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.h),
      width: double.maxFinite,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: useIcon
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme(context).textTheme.titleLarge!.copyWith(
                  color: theme(context).colorScheme.onPrimaryContainer),
            ),
            useIcon
                ? Icon(Icons.arrow_forward_ios, size: 20.h)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
