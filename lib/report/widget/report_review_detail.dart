import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';

class ReportReviewDetail extends StatelessWidget {
  const ReportReviewDetail({
    super.key,
    required this.detailCtl,
  });

  final TextEditingController detailCtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("report.detail"),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: detailCtl,
            textInputAction: TextInputAction.done,
            maxLines: 11,
            contentPadding: EdgeInsets.all(12.h),
            fillColor: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withValues(alpha: 0.6),
            inputBorder: TextFormFieldStyleHelper.outlineBlackTL24,
          ),
        ],
      ),
    );
  }
}
