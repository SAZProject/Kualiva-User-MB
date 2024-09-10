import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/datetime_utils.dart';
import 'package:like_it/common/widget/custom_rating_bar.dart';
import 'package:like_it/data/model/review_model.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key, required this.reviewData});

  final ReviewModel reviewData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
      decoration: CustomDecoration(context).orangeColorBackgroundBlur.copyWith(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
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
                    alignment: Alignment.centerLeft,
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
                                const CustomRatingBar(
                                  initialRating: 5.0,
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
                  padding: EdgeInsets.only(left: 4.h, top: 4.h),
                  child: Text(
                    "???",
                    style: theme(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.h),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.favorite,
                    size: 20.h,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.h),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.menu,
                    size: 20.h,
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
                  style: CustomTextStyles(context).bodySmallGray800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  reviewData.content,
                  style: CustomTextStyles(context).bodySmallGray800,
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
}
