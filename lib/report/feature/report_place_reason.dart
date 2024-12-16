import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_radio_button.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';

class ReportPlaceReason extends StatelessWidget {
  const ReportPlaceReason({
    super.key,
    required this.reasonCtl,
    required this.selectedReason,
    required this.onChange,
  });

  final TextEditingController reasonCtl;
  final String selectedReason;
  final Function(String) onChange;

  static List<String> dummyReasonList = [
    "report.reason_place_4",
    "report.reason_place_1",
    "report.reason_place_2",
    "report.reason_place_3",
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
          Visibility(
            visible: selectedReason == dummyReasonList[0],
            child: CustomTextFormField(
              controller: reasonCtl,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              contentPadding: EdgeInsets.all(12.h),
              fillColor: theme(context).colorScheme.onSecondaryContainer,
              boxDecoration:
                  CustomDecoration(context).outlineOnPrimaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
              inputBorder: TextFormFieldStyleHelper.fillOnSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
