import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/style/custom_decoration.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/image_constant.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_image_view.dart';
import 'package:kualiva/home/model/home_featured_model.dart';

class HomeFeaturedItem extends StatelessWidget {
  const HomeFeaturedItem({
    super.key,
    required this.homeFeatured,
    required this.onPressed,
  });

  final HomeFeaturedModel homeFeatured;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      decoration: CustomDecoration(context)
          .outlineOnSecondaryContainer
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomImageView(
                    imagePath: homeFeatured.featuredImage ??
                        "${ImageConstant.fnb1Path}/A/2.jpg",
                    height: 100.h,
                    width: double.maxFinite,
                    radius: BorderRadius.vertical(
                      top: Radius.circular(10.h),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20.h,
                      width: 50.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 2.h,
                      ),
                      decoration:
                          CustomDecoration(context).orange60Color.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder10,
                              ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.star,
                              size: 12.h,
                            ),
                          ),
                          SizedBox(width: 4.h),
                          Text(
                            homeFeatured.averageRating.toString(),
                            style: theme(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                homeFeatured.name,
                style: theme(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                homeFeatured.fullAddress,
                style: theme(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
            Column(
              children: [
                _firstTagRow(context),
                SizedBox(height: 4.h),
                homeFeatured.categories.length > 2
                    ? _secondTagRow(context)
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _firstTagRow(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: homeFeatured.categories.length >= 2
            ? 2
            : homeFeatured.categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _tagView(context, homeFeatured.categories[index]);
        },
      ),
    );
  }

  Widget _secondTagRow(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: homeFeatured.categories.length > 4 ? 2 : 1,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 1) {
            if (homeFeatured.categories.length > 4) {
              return _tagView(
                context,
                context.tr(
                  "home_screen.tags_more",
                  args: [(homeFeatured.categories.length - 3).toString()],
                ),
              );
            } else {
              return _tagView(context, homeFeatured.categories[index + 2]);
            }
          }
          return _tagView(context, homeFeatured.categories[index + 2]);
        },
      ),
    );
  }

  Widget _tagView(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      decoration: CustomDecoration(context).fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles(context).bodySmall10,
        ),
      ),
    );
  }
}
