import 'dart:math';

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
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).outlinePrmOnScd,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 130.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: homeFeatured.featuredImage ??
                        "${ImageConstant.fnb1Path}/A/2.jpg",
                    height: 130.h,
                    width: double.maxFinite,
                    radius: BorderRadius.vertical(
                      top: Radius.circular(10.h),
                    ),
                    boxFit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                      ),
                      decoration: CustomDecoration(context).outlinePrmPromo,
                      child: Text(
                        context.tr("home_screen.promo_value", args: [
                          (Random().nextInt(50) + 20).toString()
                        ]), // TODO: Percentage promo
                        style: theme(context).textTheme.labelLarge!.copyWith(
                              color: theme(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.appLogo2,
                    height: 20.h,
                    width: 20.h,
                    boxFit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Text(
                      homeFeatured.name,
                      style: theme(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: theme(context).colorScheme.primary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    homeFeatured.averageRating.toString(),
                    style: theme(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: theme(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      homeFeatured.fullAddress,
                      style: theme(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${Random().nextInt(9) + 1} Km",
                    style: theme(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            _listTag(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _listTag(BuildContext context) {
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
          if (index == 1) {
            return _tagView(
              context,
              context.tr(
                "home_screen.tags_more",
                args: [(homeFeatured.categories.length - 1).toString()],
              ),
            );
          }
          return _tagView(context, homeFeatured.categories[index]);
        },
      ),
    );
  }

  Widget _tagView(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles(context).bodySmall10.copyWith(
                color: theme(context).colorScheme.onSecondaryContainer,
              ),
        ),
      ),
    );
  }
}
