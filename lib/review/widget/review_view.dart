import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/datetime_utils.dart';
import 'package:like_it/common/widget/custom_rating_bar.dart';
import 'package:like_it/data/model/review_model.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key, required this.reviewData});

  final ReviewModel reviewData;

  void _popUpMenuAction(BuildContext context, int index) {
    switch (index) {
      default:
        Navigator.pushNamed(context, AppRoutes.reportReviewScreen,
            arguments: reviewData);
        break;
    }
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
                            reviewData.username,
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
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "???",
                    style: theme(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.h),
                  child: Icon(
                    Icons.favorite,
                    size: 20.h,
                  ),
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
                  DatetimeUtils.dmy(reviewData.reviewDate),
                  style: theme(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  reviewData.content,
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
