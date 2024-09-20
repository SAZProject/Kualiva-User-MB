import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/presentation/review/widget/review_filters_item.dart';
import 'package:like_it/presentation/review/widget/review_view.dart';
import 'package:like_it/presentation/review/widget/special_review_view.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.fnbModel});

  final FNBModel fnbModel;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  FNBModel get fnbData => super.widget.fnbModel;
  List<ReviewModel> get listReviewData => super.widget.fnbModel.review;

  List<String> filterByCategory = [
    "review.filter_1",
    "review.filter_2",
    "review.filter_3",
    "review.filter_4",
  ];

  List<String> selectedCategory = [];

  List<String> filterByStar = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  String selectedStar = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _reviewAppBar(context),
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
            SizedBox(height: 5.h),
            _reviewFilter(context),
            SizedBox(height: 5.h),
            _myReview(context),
            SizedBox(height: 5.h),
            _otherReview(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _reviewAppBar(BuildContext context) {
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
          context.tr("review.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _reviewFilter(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10.h,
            spacing: 10.h,
            children: List<Widget>.generate(
              filterByCategory.length,
              (index) {
                return ReviewFiltersItem(
                  label: context.tr(filterByCategory[index]),
                  multiSelect: true,
                  multiSelectedChoices: selectedCategory,
                  onSelected: (value) {
                    setState(() {
                      selectedCategory
                              .contains(context.tr(filterByCategory[index]))
                          ? selectedCategory
                              .remove(context.tr(filterByCategory[index]))
                          : selectedCategory
                              .add(context.tr(filterByCategory[index]));
                    });
                  },
                );
              },
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10.h,
            spacing: 10.h,
            children: List<Widget>.generate(
              filterByStar.length,
              (index) {
                return ReviewFiltersItem(
                  label: filterByStar[index],
                  multiSelect: false,
                  singleSelectedChoices: selectedStar,
                  onSelected: (value) {
                    setState(() {
                      if (selectedStar == filterByStar[index]) {
                        selectedStar = "";
                      } else {
                        selectedStar = filterByStar[index];
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _myReview(BuildContext context) {
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
            label: context.tr("review.my_review"),
            useIcon: false,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.reviewFormScreen,
                  arguments: fnbData);
            },
            child: Container(
              height: 150.h,
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              width: double.maxFinite,
              child: Center(
                child: Text(
                  context.tr("review.no_review"),
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _otherReview(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("review.other_review"),
            useIcon: false,
          ),
          Container(
            height: 200.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listReviewData.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ReviewModel reviewData = listReviewData[index];
                if (reviewData.specialReview) {
                  return SpecialReviewView(reviewData: reviewData);
                }
                return ReviewView(reviewData: reviewData);
              },
            ),
          ),
        ],
      ),
    );
  }
}
