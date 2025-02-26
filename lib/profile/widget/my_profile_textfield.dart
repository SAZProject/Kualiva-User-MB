import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';

class MyProfileTextfield extends StatelessWidget {
  const MyProfileTextfield({
    super.key,
    required this.headerLabel,
    required this.controller,
    this.hintText,
    this.useSuffix = false,
    this.suffixOnTap,
    this.suffix,
    this.useVerifyWidget = false,
    this.verifyOnTap,
    this.isDateTimeField = false,
    this.dateTimeFieldOnTap,
  });

  final String headerLabel;
  final TextEditingController controller;
  final String? hintText;
  final bool useSuffix;
  final String? suffix;
  final Function()? suffixOnTap;
  final bool useVerifyWidget;
  final Function()? verifyOnTap;
  final bool isDateTimeField;
  final Function()? dateTimeFieldOnTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> listVerifiedTextField = [
      CustomTextFormField(
        width: useVerifyWidget ? 250.h : null,
        controller: controller,
        readOnly: true,
        suffix: useSuffix
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: isDateTimeField ? 0.0 : 10.h),
                      child: isDateTimeField
                          ? IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                                size: 25.h,
                                color: theme(context).colorScheme.primary,
                              ),
                              onPressed: dateTimeFieldOnTap,
                            )
                          : InkWell(
                              onTap: suffixOnTap,
                              child: Text(
                                suffix ?? "",
                                style: CustomTextStyles(context)
                                    .bodySmall12
                                    .copyWith(
                                      color: theme(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    ];
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
            useVerifyWidget
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...listVerifiedTextField,
                      CustomElevatedButton(
                        margin: EdgeInsets.only(right: 10.h),
                        width: 60.h,
                        decoration: CustomDecoration(context)
                            .outlineOnSecondaryContainer,
                        buttonTextStyle: CustomTextStyles(context).bodySmall12,
                        buttonStyle:
                            CustomButtonStyles.outlineOnSecondaryContainer(
                                context),
                        initialText: context.tr("my_profile.verify"),
                        onPressed: verifyOnTap,
                      ),
                    ],
                  )
                : listVerifiedTextField.first,
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
}
