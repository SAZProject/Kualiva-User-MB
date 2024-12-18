import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/f_n_b_dataset.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/data/model/f_n_b_model.dart';
import 'package:kualiva/data/model/review_model.dart';
import 'package:kualiva/review/feature/review_filter_feature.dart';
import 'package:kualiva/review/feature/review_my_review_feature.dart';
import 'package:kualiva/review/feature/review_other_review_feature.dart';
import 'package:kualiva/review/feature/review_search_bar_feature.dart';
import 'package:kualiva/review/widget/review_verify_modal.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  FNBModel get fnbData => FNBDataset().featuredItemsDataset[0];
  List<ReviewModel> get listReviewData =>
      FNBDataset().featuredItemsDataset[0].review;

  List<String> filterByCategory = [
    "review.filter_user",
    "review.filter_kualiva",
    "review.filter_google",
  ];

  ValueNotifier<Set<String>> selectedCategory = ValueNotifier<Set<String>>({});

  List<String> menuFilter = [
    "review.filter_time",
    "review.filter_media",
    "review.filter_rating",
  ];

  @override
  void dispose() {
    selectedCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _reviewAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h),
                ReviewSearchBarFeature(),
                SizedBox(height: 5.h),
                ReviewFilterFeature(
                  filterByCategory: filterByCategory,
                  menuFilter: menuFilter,
                  selectedCategory: selectedCategory,
                ),
                SizedBox(height: 5.h),
                ReviewMyReviewFeature(fnbData: fnbData),
                SizedBox(height: 5.h),
                ReviewOtherReviewFeature(listReviewData: listReviewData),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
        _buildWriteReviewBtn(context),
      ],
    );
  }

  PreferredSizeWidget _reviewAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("review.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildWriteReviewBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
        child: CustomGradientOutlinedButton(
          text: context.tr("review.write_title_n_btn"),
          outerPadding: EdgeInsets.zero,
          innerPadding: EdgeInsets.all(2.h),
          strokeWidth: 2.h,
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.primary,
          ],
          buttonStyle:
              CustomButtonStyles.fillOnSecondaryContainerNoBdr(context),
          textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) =>
                  ReviewVerifyModal(fnbData: fnbData),
            );
          },
        ),
      ),
    );
  }
}
