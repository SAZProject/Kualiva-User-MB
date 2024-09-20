import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_outlined_button.dart';
import 'package:like_it/common/widget/custom_radio_button.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

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
        appBar: _reportPlaceAppBar(context),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildReason(context),
            SizedBox(height: 10.h),
            _buildDetail(context),
            SizedBox(height: 25.h),
            _buildSubmitButton(context),
            SizedBox(height: 25.h),
          ],
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
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
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
          CustomRadioButton(
            text: context.tr("report.reason_review_1"),
            value: context.tr("report.reason_review_1"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_2"),
            value: context.tr("report.reason_review_2"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_3"),
            value: context.tr("report.reason_review_3"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_4"),
            value: context.tr("report.reason_review_4"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_5"),
            value: context.tr("report.reason_review_5"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_review_6"),
            value: context.tr("report.reason_review_6"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
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
            fillColor: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            inputBorder: TextFormFieldStyleHelper.fillOnSecondaryContainer,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: OutlineGradientButton(
        padding: EdgeInsets.all(2.h),
        strokeWidth: 2.h,
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.primary,
          ],
        ),
        corners: const Corners(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        child: CustomOutlinedButton(
          text: context.tr("report.submit_btn"),
          buttonStyle: CustomButtonStyles.outlineTL25(context).copyWith(
            backgroundColor: WidgetStatePropertyAll(
                theme(context).colorScheme.onSecondaryContainer),
          ),
          buttonTextStyle: CustomTextStyles(context).titleMediumYellowA700,
          onPressed: () {},
        ),
      ),
    );
  }
}
