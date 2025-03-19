import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/review/argument/review_argument.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/bloc/review_place_other_read_bloc.dart';
import 'package:kualiva/review/cubit/review_filter_cubit.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';
import 'package:kualiva/review/feature/review_filter_feature.dart';
import 'package:kualiva/review/feature/review_my_review_feature.dart';
import 'package:kualiva/review/feature/review_other_review_feature.dart';
import 'package:kualiva/review/feature/review_search_bar_feature.dart';
import 'package:kualiva/review/widget/review_verify_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.reviewArgument});

  final ReviewArgument reviewArgument;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String get placeId => widget.reviewArgument.placeUniqueId;
  PlaceCategoryEnum get placeCategory => widget.reviewArgument.placeCategory;

  final _scrollController = ScrollController();
  final _paging = ValueNotifier(Paging());

  void _onScrollListener() {
    if (_scrollController.position.pixels !=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<ReviewPlaceOtherReadBloc>().state;
    if (state is! ReviewPlaceOtherReadSuccess) return;
    final pagination = state.reviewPlacePage.pagination;
    _nextPaging(pagination);
  }

  void _nextPaging(Pagination pagination) {
    debugPrint("_nextPaging");
    if (_paging.value.page == pagination.totalPage) return;
    _paging.value = Paging(
      page: pagination.nextPage ?? pagination.totalPage,
      size: pagination.size,
    );
    context.read<ReviewFilterCubit>().pagination(paging: _paging.value);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollListener);
    context
        .read<ReviewPlaceMyReadBloc>()
        .add(ReviewPlaceMyReadFetched(placeId: placeId));
    context.read<ReviewPlaceOtherReadBloc>().add(ReviewPlaceOtherReadFetched(
          placeId: placeId,
          isRefreshed: true,
          isNextPaging: false,
        ));
    context.read<ReviewSearchBarCubit>().load();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScrollListener);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewFilterCubit, ReviewFilterState>(
      listener: (context, state) {
        if (state is! ReviewFilterSuccess) return;
        final reviewFilter = state.reviewFilter;
        context
            .read<ReviewPlaceOtherReadBloc>()
            .add(ReviewPlaceOtherReadFetched(
              paging: state.paging,
              isNextPaging: state.isNextPaging,
              isRefreshed: state.isRefreshed,
              placeId: placeId,
              description: reviewFilter.description,
              selectedUser: reviewFilter.selectedUser,
              withMedia: reviewFilter.withMedia,
              rating: reviewFilter.rating,
              order: reviewFilter.order,
            ));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _reviewAppBar(context),
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
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  ReviewSearchBarFeature(),
                  SizedBox(height: 5.h),
                  ReviewFilterFeature(),
                  SizedBox(height: 5.h),
                  ReviewMyReviewFeature(),
                  SizedBox(height: 5.h),
                  ReviewOtherReviewFeature(),
                  SizedBox(height: 50.h),
                  BlocBuilder<ReviewPlaceOtherReadBloc,
                      ReviewPlaceOtherReadState>(
                    builder: (context, state) {
                      if (state is! ReviewPlaceOtherReadSuccess) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 50.h),
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
        child: BlocBuilder<ReviewPlaceMyReadBloc, ReviewPlaceMyReadState>(
          builder: (context, state) {
            String text = 'review.write_title_n_btn';
            if (state is ReviewPlaceMyReadSuccess) {
              text = 'review.update_title_n_btn';
            }
            return CustomGradientOutlinedButton(
              text: context.tr(text),
              outerPadding: EdgeInsets.zero,
              innerPadding: EdgeInsets.all(2.h),
              strokeWidth: 2.h,
              colors: [
                appTheme.yellowA700,
                theme(context).colorScheme.primary,
              ],
              buttonStyle:
                  CustomButtonStyles.fillOnSecondaryContainerNoBdr(context),
              textStyle:
                  CustomTextStyles(context).titleMediumOnPrimaryContainer,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => ReviewVerifyModal(
                    placeUniqueId: placeId,
                    placeCategory: placeCategory,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
