import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_section_header.dart';

class FNBFiltersSlider extends StatelessWidget {
  const FNBFiltersSlider({
    super.key,
    required this.label,
    required this.minLabel,
    required this.maxLabel,
    required this.rangeValuesNotifier,
    required this.slideMinVal,
    required this.slideMaxVal,
    required this.division,
    this.onChangeEnd,
  });

  final String label;
  final String minLabel;
  final String maxLabel;
  final ValueNotifier<RangeValues> rangeValuesNotifier;
  final double slideMinVal;
  final double slideMaxVal;
  final int division;
  final Function(RangeValues)? onChangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer.copyWith(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: label,
            useIcon: false,
          ),
          _buildSlider(context),
        ],
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            alignment: Alignment.center,
            child: Text(
              minLabel,
              style: CustomTextStyles(context).bodySmall12,
              textAlign: TextAlign.center,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: rangeValuesNotifier,
            builder: (context, value, child) => Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200.h,
                child: SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorColor: theme(context).colorScheme.primary,
                    valueIndicatorTextStyle:
                        CustomTextStyles(context).bodySmall12,
                  ),
                  child: RangeSlider(
                    activeColor: theme(context).colorScheme.primary,
                    min: slideMinVal,
                    max: slideMaxVal,
                    values: value,
                    labels: RangeLabels(
                      rangeValuesNotifier.value.start.round().toString(),
                      rangeValuesNotifier.value.end.round().toString(),
                    ),
                    onChanged: (newValues) {
                      rangeValuesNotifier.value = newValues;
                    },
                    onChangeEnd: onChangeEnd,
                    divisions: division,
                  ),
                ),
              ),
            ),
          ),
          FittedBox(
            alignment: Alignment.center,
            child: Text(
              maxLabel,
              style: CustomTextStyles(context).bodySmall12,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
