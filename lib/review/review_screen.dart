import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/bloc/review_place_read_bloc.dart';
import 'package:kualiva/review/feature/review_filter_feature.dart';
import 'package:kualiva/review/feature/review_my_review_feature.dart';
import 'package:kualiva/review/feature/review_other_review_feature.dart';
import 'package:kualiva/review/feature/review_search_bar_feature.dart';
import 'package:kualiva/review/widget/review_verify_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    super.key,
    required this.placeId,
    required this.placeCategory,
  });

  final String placeId;
  final PlaceCategoryEnum placeCategory;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String get placeId => widget.placeId;
  PlaceCategoryEnum get placeCategory => widget.placeCategory;

  List<String> filterByCategory = [
    "review.filter_user",
    "review.filter_kualiva",
  ];

  ValueNotifier<Set<String>> selectedCategory = ValueNotifier<Set<String>>({});

  ValueNotifier<List<String>> menuFilter = ValueNotifier<List<String>>([
    "review.filter_time",
    "review.filter_media",
    "review.filter_rating",
  ]);

  @override
  void initState() {
    super.initState();
    context
        .read<ReviewPlaceOtherReadBloc>()
        .add(ReviewPlaceOtherReadFetched(placeId: placeId));
    context
        .read<ReviewPlaceMyReadBloc>()
        .add(ReviewPlaceMyReadFetched(placeId: placeId));
  }

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
    return MultiBlocListener(
      listeners: [
        BlocListener<ReviewPlaceOtherReadBloc, ReviewPlaceOtherReadState>(
          listener: (context, state) {
            LeLog.sd(this, _body, state.toString());
            if (state is! ReviewPlaceOtherReadSuccess) return;
            if (state is! ReviewPlaceOtherReadLoading) return;
          },
        ),
        BlocListener<ReviewPlaceMyReadBloc, ReviewPlaceMyReadState>(
          listener: (context, state) {
            LeLog.sd(this, _body, state.toString());
            if (state is! ReviewPlaceMyReadSuccess) return;
            if (state is! ReviewPlaceMyReadLoading) return;
          },
        ),
      ],
      child: Stack(
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
                  ReviewMyReviewFeature(),
                  SizedBox(height: 5.h),
                  ReviewOtherReviewFeature(),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
          _buildWriteReviewBtn(context),
        ],
      ),
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
              builder: (BuildContext context) => ReviewVerifyModal(
                placeUniqueId: placeId,
                placeCategory: placeCategory,
              ),
            );
          },
        ),
      ),
    );
  }
}
