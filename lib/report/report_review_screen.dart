import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_alert_dialog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/data/model/review_model.dart';
import 'package:kualiva/report/feature/report_review_reason.dart';
import 'package:kualiva/report/widget/report_review_detail.dart';

class ReportReviewScreen extends StatefulWidget {
  const ReportReviewScreen({super.key, required this.reviewData});

  final ReviewModel reviewData;

  @override
  State<ReportReviewScreen> createState() => _ReportReviewScreenState();
}

class _ReportReviewScreenState extends State<ReportReviewScreen> {
  ReviewModel get reviewData => super.widget.reviewData;

  final selectedReason = ValueNotifier<String>("");

  final TextEditingController _detailCtl = TextEditingController();

  @override
  void dispose() {
    _detailCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _reportPlaceAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
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
              valueListenable: selectedReason,
              builder: (context, reason, child) {
                return ReportReviewReason(
                  selectedReason: reason,
                  onChange: (value) => selectedReason.value = value,
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
          onPressed: () {
            customAlertDialog(
              context: context,
              dismissable: true,
              title: Text(
                "Conratulation!",
              ),
              content: Text(
                "You get 10 points",
              ),
              icon: Icon(
                Icons.generating_tokens_outlined,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
