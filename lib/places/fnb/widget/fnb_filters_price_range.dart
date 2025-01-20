import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_radio_button.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';

class FnbFiltersPriceRange extends StatelessWidget {
  const FnbFiltersPriceRange(
      {super.key,
      required this.label,
      required this.selectedPrice,
      required this.onChange});

  final String label;
  final String selectedPrice;
  final Function(String) onChange;
  final List<String> listPriceRange = const [
    "filter.price_range_value_1",
    "filter.price_range_value_2",
    "filter.price_range_value_3",
    "filter.price_range_value_4",
    "filter.price_range_value_5",
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> priceRangeWidgetList = [];
    for (int i = 0; i < listPriceRange.length; i++) {
      priceRangeWidgetList.add(
        CustomRadioButton(
          text: context.tr(listPriceRange[i]),
          preWidget: Row(
            children: List.generate(
              5,
              (iconIdx) => Icon(
                Icons.attach_money,
                color: iconIdx <= i
                    ? theme(context).colorScheme.primary
                    : theme(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          value: listPriceRange[i],
          groupValue: selectedPrice,
          padding: EdgeInsets.all(10.h),
          boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
          onChange: onChange,
        ),
      );
    }
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.5.h),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          CustomSectionHeader(
            label: label,
            useIcon: false,
          ),
          ...priceRangeWidgetList
        ],
      ),
    );
  }
}
