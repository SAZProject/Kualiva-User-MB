import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_radio_button.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';
import 'package:like_it/data/model/review_model.dart';

class ReportReviewScreen extends StatefulWidget {
  const ReportReviewScreen({super.key, required this.reviewData});

  final ReviewModel reviewData;

  @override
  State<ReportReviewScreen> createState() => _ReportReviewScreenState();
}

class _ReportReviewScreenState extends State<ReportReviewScreen> {
  ReviewModel get reviewData => super.widget.reviewData;

  String selectedReason = "";

  TextEditingController detailCtl = TextEditingController();

  @override
  void dispose() {
    detailCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: Sizeutils.height,
          decoration: BoxDecoration(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            image: DecorationImage(
              image: AssetImage(ImageConstant.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _reportPlaceAppBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              _buildReason(context),
              SizedBox(height: 10.h),
              _buildDetail(context),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _reportPlaceAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(10.h),
        child: IconButton(
          iconSize: 40.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("report.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _buildReason(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
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
          CustomRadioButton(
            text: context.tr("report.reason_review_1"),
            value: context.tr("report.reason_review_1"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            decoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              selectedReason = value;
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_2"),
            value: context.tr("report.reason_review_2"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            decoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              selectedReason = value;
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_3"),
            value: context.tr("report.reason_review_3"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            decoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              selectedReason = value;
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_4"),
            value: context.tr("report.reason_review_4"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            decoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              selectedReason = value;
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_5"),
            value: context.tr("report.reason_review_5"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            decoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              selectedReason = value;
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_6"),
            value: context.tr("report.reason_review_6"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            decoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              selectedReason = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
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
            boxDecoration:
                CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                      borderRadius: BorderRadius.circular(10.h),
                    ),
            inputBorder: TextFormFieldStyleHelper.fillOnSecondaryContainer,
          ),
        ],
      ),
    );
  }
}
