import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_alert_dialog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/report/argument/report_review_argument.dart';
import 'package:kualiva/report/bloc/report_review_create_bloc.dart';
import 'package:kualiva/report/bloc/report_review_read_bloc.dart';
import 'package:kualiva/report/feature/report_review_reason_feature.dart';
import 'package:kualiva/report/widget/report_review_detail.dart';

class ReportReviewScreen extends StatefulWidget {
  const ReportReviewScreen({super.key, required this.reportReviewArgument});

  final ReportReviewArgument reportReviewArgument;

  @override
  State<ReportReviewScreen> createState() => _ReportReviewScreenState();
}

class _ReportReviewScreenState extends State<ReportReviewScreen> {
  int get reviewId => widget.reportReviewArgument.reviewId;

  final _selectedReasonId = ValueNotifier<String>("");

  final TextEditingController _detailCtl = TextEditingController();

  void _submit() {
    LeLog.sd(this, _submit, reviewId.toString());
    context.read<ReportReviewCreateBloc>().add(ReportReviewCreated(
          reviewId: reviewId,
          reasonId: int.parse(_selectedReasonId.value),
          description: _detailCtl.value.text,
        ));
  }

  @override
  void initState() {
    super.initState();
    context.read<ReportReviewReadBloc>().add(ReportReviewReadFecthed());
  }

  @override
  void dispose() {
    _detailCtl.dispose();
    _selectedReasonId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportReviewCreateBloc, ReportReviewCreateState>(
      listener: (context, state) {
        LeLog.sd(this, build, state.toString());
        if (state is ReportReviewCreateSuccess) {
          LeLog.sd(this, build, "Harusnya muncul pop up cuy");
          customAlertDialog(
            context: context,
            dismissable: true,
            title: Text(
              "Conratulation!",
            ),
            content: Text(
              "You get ${state.point} points",
            ),
            icon: Icon(
              Icons.generating_tokens_outlined,
            ),
          );
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _reportPlaceAppBar(context),
          body: SizedBox(
            width: double.maxFinite,
            height: Sizeutils.height,
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            ValueListenableBuilder(
              valueListenable: _selectedReasonId,
              builder: (context, reason, child) {
                return ReportReviewReasonFeature(
                  selectedReason: reason,
                  onChange: (value) => _selectedReasonId.value = value,
                );
              },
            ),
            SizedBox(height: 10.h),
            ReportReviewDetail(detailCtl: _detailCtl),
            SizedBox(height: 25.h),
            _reportReviewSubmitBtn(),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _reportPlaceAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("report.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _reportReviewSubmitBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: SizedBox(
        height: 60.h,
        width: double.maxFinite,
        child: CustomGradientOutlinedButton(
          text: context.tr("review.submit_btn"),
          outerPadding: EdgeInsets.symmetric(horizontal: 30.h),
          innerPadding: EdgeInsets.all(2.h),
          strokeWidth: 2.h,
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.primary,
          ],
          textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
          onPressed: _submit,
        ),
      ),
    );
  }
}
