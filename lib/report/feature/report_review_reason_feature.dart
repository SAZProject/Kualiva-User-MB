import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_radio_button.dart';
import 'package:kualiva/report/bloc/report_review_read_bloc.dart';

class ReportReviewReasonFeature extends StatelessWidget {
  const ReportReviewReasonFeature({
    super.key,
    required this.selectedReason,
    required this.onChange,
  });

  final String selectedReason;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: BlocBuilder<ReportReviewReadBloc, ReportReviewReadState>(
        builder: (context, state) {
          if (state is ReportReviewReadFailure) {
            return CustomErrorState(
              errorMessage: context.tr("common.error"),
              onRetry: () => context
                  .read<ReportReviewReadBloc>()
                  .add(ReportReviewReadRefreshed()),
            );
          }

          if (state is ReportReviewReadSuccess) {
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
