import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_radio_button.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';
import 'package:kualiva/report/bloc/report_place_bloc.dart';

class ReportPlaceReasonFeature extends StatelessWidget {
  const ReportPlaceReasonFeature({
    super.key,
    required this.reasonCtl,
    required this.selectedReason,
    required this.onChange,
  });

  final TextEditingController reasonCtl;
  final String selectedReason;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: BlocBuilder<ReportPlaceBloc, ReportPlaceState>(
        buildWhen: (previous, current) {
          if (current is ReportPlaceFetchSuccess ||
              current is ReportPlaceFetchFailure) {
            return true;
          }
          if ((previous is ReportPlaceLoading &&
                  current is ReportPlaceFetchSuccess) ||
              (previous is ReportPlaceLoading &&
                  current is ReportPlaceFetchFailure)) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is ReportPlaceFetchFailure) {
            return CustomErrorState(
              errorMessage: context.tr("common.error"),
              onRetry: () =>
                  context.read<ReportPlaceBloc>().add(ReportPlaceFetched()),
            );
          }

          if (state is ReportPlaceFetchSuccess) {
            return _list(context, state.parameter);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _list(BuildContext context, ParameterModel parameter) {
    List<Widget> reasonWidgetList = [];
    final parameterDetails = parameter.parameterDetails;
    for (int i = 0; i < parameterDetails.length; i++) {
      reasonWidgetList.add(
        CustomRadioButton(
          text: parameterDetails[i].language.en ?? parameterDetails[i].explain,
          value: '${parameterDetails[i].id}',
          groupValue: selectedReason,
          padding: EdgeInsets.all(10.h),
          boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
          onChange: onChange,
        ),
      );
      reasonWidgetList.add(SizedBox(height: 4.h));
    }

    return Column(
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
          visible:
              parameterDetails[0].explain.toLowerCase().contains('other') ||
                  parameterDetails[0].explain.toLowerCase().contains('lainnya'),
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
    );
  }
}
