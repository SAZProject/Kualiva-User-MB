import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_checkbox_button.dart';

class NotificationCheckboxItem extends StatelessWidget {
  const NotificationCheckboxItem({
    super.key,
    required this.label,
    required this.kualivaNotifVal,
    required this.emailNotifVal,
    required this.whatsappNotifVal,
    required this.kualivaNotifOnChange,
    required this.emailNotifOnChange,
    required this.whatsappNotifOnChange,
  });

  final String label;

  final bool kualivaNotifVal;
  final bool emailNotifVal;
  final bool whatsappNotifVal;

  final Function(bool) kualivaNotifOnChange;
  final Function(bool) emailNotifOnChange;
  final Function(bool) whatsappNotifOnChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.h),
      child: SizedBox(
        width: Sizeutils.width,
        height: 30.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.h),
              child: Text(
                context.tr(label),
                style: CustomTextStyles(context).bodyMedium_13,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              child: CustomCheckboxButton(
                value: kualivaNotifVal,
                onChange: kualivaNotifOnChange,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              child: CustomCheckboxButton(
                value: emailNotifVal,
                onChange: emailNotifOnChange,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              child: CustomCheckboxButton(
                value: whatsappNotifVal,
                onChange: whatsappNotifOnChange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
