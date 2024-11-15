import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_gradient_outlined_button.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/review/widget/review_filters_item.dart';
import 'package:like_it/review/widget/review_filters_modal.dart';
import 'package:like_it/review/widget/review_verify_modal.dart';
import 'package:like_it/review/widget/review_view.dart';
import 'package:like_it/review/widget/special_review_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  // final FNBModel fnbModel;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // FNBModel get fnbData => super.widget.fnbModel;
  // List<ReviewModel> get listReviewData => super.widget.fnbModel.review;

  FNBModel get fnbData => FNBDataset().featuredItemsDataset[0];
  List<ReviewModel> get listReviewData =>
      FNBDataset().featuredItemsDataset[0].review;

  List<String> filterByCategory = [
    "review.filter_user",
    "review.filter_like_it",
    "review.filter_google",
  ];

  ValueNotifier<Set<String>> selectedCategory = ValueNotifier<Set<String>>({});

  List<String> menuFilter = [
    "review.filter_time",
    "review.filter_media",
    "review.filter_rating",
  ];

  ValueNotifier<String> selectedStar = ValueNotifier<String>("");

  String? transaction;
  String? message;
  double? rating;
  String? date;

  @override
  void dispose() {
    selectedCategory.dispose();
    selectedStar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dummyData();
  }

  void dummyData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      transaction = prefs.getString('transaction');
      message = prefs.getString('message');
      date = prefs.getString('date');
      rating = prefs.getDouble('rating');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _reviewAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          // decoration: BoxDecoration(
          //   color: theme(context)
          //       .colorScheme
          //       .onSecondaryContainer
          //       .withOpacity(0.6),
          //   image: DecorationImage(
          //     image: AssetImage(ImageConstant.background2),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    List<Widget> myReview = [SizedBox()];
    debugPrint('LeRucco Add Review');
    debugPrint('transaction $transaction');
    debugPrint('message $message');
    debugPrint('date $date');
    debugPrint('rating $rating');
    if (transaction != null &&
        message != null &&
        date != null &&
        rating != null) {
      myReview = [_myReview(context), SizedBox(height: 5.h)];
    }
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h),
                _searchBar(context),
                SizedBox(height: 5.h),
                _reviewFilter(context),
                SizedBox(height: 5.h),
                ...myReview,
                // _myReview(context),
                // SizedBox(height: 5.h),
                _otherReview(context),
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
          onPressed: () async {
            // final SharedPreferences prefs =
            //     await SharedPreferences.getInstance();
            // await prefs.remove('transaction');
            // await prefs.remove('message');
            // await prefs.remove('rating');
            // await prefs.remove('date');
            SharedPreferences.getInstance().then((prefs) {
              Future.wait([
                prefs.remove('transaction'),
                prefs.remove('message'),
                prefs.remove('rating'),
                prefs.remove('date'),
              ]).then(
                (value) {},
              );
            });
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

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            focusNode: FocusNode(),
            padding: WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.h)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            onSubmitted: (value) {
              setState(() {
                controller.closeView(value);
              });
            },
            onTapOutside: (event) {
              FocusScopeNode focusNode = FocusScope.of(context);
              if (focusNode.hasPrimaryFocus) {
                focusNode.unfocus();
              }
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            },
          );
        },
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
                );
              },
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runSpacing: 10.h,
            spacing: 10.h,
            children: List<Widget>.generate(
              menuFilter.length,
              (index) {
                // return ReviewFiltersItem(
                //   label: menuFilter[index],
                //   multiSelect: false,
                //   singleSelectedChoices: selectedStar,
                // );
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const ReviewFiltersModal(),
                    ).then(
                      (value) {
                        if (value == null) return;
                        debugPrint(value.toString());
                        List<String?> resVal = value as List<String?>;
                        for (int i = 0; i < resVal.length; i++) {
                          if (resVal[i] != null) {
                            setState(() {
                              menuFilter[i] = resVal[i]!;
                            });
                          }
                        }
                      },
                    );
                  },
                  child: FittedBox(
                    child: Card(
                      color: theme(context).colorScheme.onSecondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.roundedBorder20,
                        side: BorderSide(
                            color:
                                theme(context).colorScheme.onPrimaryContainer),
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 5.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.h, vertical: 5.h),
                        child: Center(
                          child: Row(
                            children: [
                              index == 2
                                  ? Icon(
                                      Icons.star,
                                      size: 20.h,
                                      color: theme(context).colorScheme.primary,
                                    )
                                  : const SizedBox(),
                              Text(
                                context.tr(menuFilter[index]),
                                textAlign: TextAlign.center,
                                style: theme(context).textTheme.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _myReview(BuildContext context) {
    ReviewModel review = FNBDataset().featuredItemsDataset[1].review[0];
    if (transaction != null &&
        message != null &&
        date != null &&
        rating != null) {
      review = review.copyWith(
          rating: rating,
          reviewDate: date == null ? DateTime.now() : DateTime.parse(date!),
          content: message);
    }
    debugPrint('_myReview');
    debugPrint(review.toString());

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
              // Navigator.pushNamed(context, AppRoutes.reviewFormScreen,
              //     arguments: fnbData);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: ReviewView(
                reviewData: review,
              ),
            ),

            // Container(
            //   height: 150.h,
            //   margin: EdgeInsets.symmetric(horizontal: 5.h),
            //   width: double.maxFinite,
            //   child: Center(
            //     child: Text(
            //       context.tr("review.no_review"),
            //       textAlign: TextAlign.center,
            //       style: theme(context).textTheme.headlineSmall,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //   ),
            // ),
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
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: listReviewData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listReviewData.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (listReviewData.isNotEmpty) {
                        ReviewModel reviewData = listReviewData[index];
                        if (reviewData.specialReview) {
                          return SpecialReviewView(reviewData: reviewData);
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          child: ReviewView(reviewData: reviewData),
                        );
                      }
                      return const CustomEmptyState();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
