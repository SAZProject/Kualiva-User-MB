import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_rating_bar.dart';
import 'package:kualiva/report/argument/report_review_argument.dart';
import 'package:kualiva/review/bloc/review_like_bloc.dart';
import 'package:kualiva/review/model/review_place_model.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key, required this.reviewData});

  final ReviewPlaceModel reviewData;

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  ReviewPlaceModel get reviewData => widget.reviewData;
  final _isLiked = ValueNotifier<bool>(false);
  final _countLiked = ValueNotifier<int>(0);

  void _popUpMenuAction(BuildContext context, int index) {
    switch (index) {
      default:
        LeLog.sd(this, _popUpMenuAction, reviewData.toString());
        Navigator.pushNamed(context, AppRoutes.reportReviewScreen,
            arguments: ReportReviewArgument(
              reviewId: reviewData.id,
            ));
        break;
    }
  }

  void _toggleLikedIcon() {
    LeLog.sd(this, _toggleLikedIcon, _isLiked.value.toString());
    if (_isLiked.value) {
      context
          .read<ReviewLikeBloc>()
          .add(ReviewLikeAdded(reviewId: reviewData.id));
      _countLiked.value = _countLiked.value + 1;
    } else {
      context
          .read<ReviewLikeBloc>()
          .add(ReviewLikeRemoved(reviewId: reviewData.id));
      _countLiked.value = _countLiked.value == 0 ? 0 : _countLiked.value - 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _countLiked.value = reviewData.count ?? 0;
    _isLiked.value = reviewData.isLikedByMe ?? false;
    _isLiked.addListener(_toggleLikedIcon);
  }

  @override
  void dispose() {
    super.dispose();
    _isLiked.removeListener(_toggleLikedIcon);
    _isLiked.dispose();
    _countLiked.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.h,
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
      decoration: CustomDecoration(context).backgroundBlur.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    minRadius: 25.h,
                    maxRadius: 25.h,
                    child: Center(
                      child: Icon(Icons.person, size: 50.h),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewData.author.username,
                            style: theme(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Text(
                                  reviewData.rating.toString(),
                                  style: theme(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                CustomRatingBar(
                                  initialRating: reviewData.rating,
                                  color: theme(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _countLiked,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "$value",
                        style: theme(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _isLiked,
                  builder: (context, value, child) {
                    return Container(
                      margin: EdgeInsets.only(left: 4.h),
                      child: IconButton(
                        onPressed: () {
                          _isLiked.value = !_isLiked.value;
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 20.h,
                          color: value ? Colors.redAccent : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuButton(
                  position: PopupMenuPosition.under,
                  padding: EdgeInsets.zero,
                  iconSize: 20.h,
                  constraints: BoxConstraints(
                    maxWidth: 50.h,
                  ),
                  itemBuilder: (ctx) => [
                    _buildPopupMenuItem(context, 0, Icons.flag),
                  ],
                  child: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DatetimeUtils.dmy(reviewData.createdAt),
                  // DatetimeUtils.dmy(reviewData.reviewDate),
                  style: theme(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  reviewData.description,
                  style: CustomTextStyles(context).bodySmall12,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      BuildContext context, int index, IconData icon) {
    return PopupMenuItem(
      padding: EdgeInsets.zero,
      height: 0.0,
      onTap: () => _popUpMenuAction(context, index),
      value: index,
      child: Center(child: Icon(icon, size: 25.h)),
    );
  }
}
