import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_radio_button.dart';

class ReportReviewReason extends StatelessWidget {
  const ReportReviewReason({
    super.key,
    required this.selectedReason,
    required this.onChange,
  });

  final String selectedReason;
  final Function(String) onChange;

  static List<String> dummyReasonList = [
    "report.reason_review_1",
    "report.reason_review_2",
    "report.reason_review_3",
    "report.reason_review_4",
    "report.reason_review_5",
    "report.reason_review_6",
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> reasonWidgetList = [];
    for (int i = 0; i < dummyReasonList.length; i++) {
      reasonWidgetList.add(
        CustomRadioButton(
          text: dummyReasonList[i],
          value: dummyReasonList[i],
          groupValue: selectedReason,
          padding: EdgeInsets.all(10.h),
          boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
          onChange: onChange,
        ),
      );
      reasonWidgetList.add(SizedBox(height: 4.h));
    }
    final Widget first = reasonWidgetList.removeAt(0);
    reasonWidgetList.add(first);
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("report.reason"),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          ...reasonWidgetList,
        ],
      ),
    );
  }
}
