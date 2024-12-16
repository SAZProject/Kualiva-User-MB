import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_app_bar.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/report/feature/report_review_reason.dart';
import 'package:like_it/report/widget/report_review_detail.dart';
import 'package:like_it/review/feature/review_form_submit_button.dart';

class ReportReviewScreen extends StatefulWidget {
  const ReportReviewScreen({super.key, required this.reviewData});

  final ReviewModel reviewData;

  @override
  State<ReportReviewScreen> createState() => _ReportReviewScreenState();
}

class _ReportReviewScreenState extends State<ReportReviewScreen> {
  ReviewModel get reviewData => super.widget.reviewData;

  String selectedReason = "";

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
            ReportReviewReason(
              selectedReason: selectedReason,
              onChange: (value) => setState(() => selectedReason = value),
            ),
            SizedBox(height: 10.h),
            ReportReviewDetail(detailCtl: _detailCtl),
            SizedBox(height: 25.h),
            ReportReviewSubmitButton(),
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
}
