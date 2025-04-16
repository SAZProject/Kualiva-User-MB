import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/places/spa/model/spa_nearest_model.dart';

class SpaNearestItem extends StatelessWidget {
  const SpaNearestItem({
    super.key,
    required this.merchant,
    required this.onPressed,
  });

  final SpaNearestModel merchant;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230.h,
      margin: EdgeInsets.all(5.h),
      decoration: merchant.isMerchant
          ? CustomDecoration(context).outlinePrmOnScd
          : CustomDecoration(context)
              .outlineOnSecondaryContainer
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadiusStyle.roundedBorder9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: merchant.featuredImage ??
                    "${ImageConstant.fnb1Path}/A/2.jpg",
                height: 130.h,
                width: double.maxFinite,
                boxFit: BoxFit.cover,
              ),
              SizedBox(width: 5.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      child: Row(
                        children: [
                          Visibility(
                            visible: merchant.isMerchant,
                            child: CustomImageView(
                              imagePath: ImageConstant.appLogo2,
                              height: 20.h,
                              width: 20.h,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              merchant.name,
                              style: theme(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: theme(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            merchant.averageRating.toString(),
                            style: theme(context).textTheme.bodySmall!.copyWith(
                                color: theme(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              merchant.cityOrVillage,
                              style: CustomTextStyles(context).bodySmall10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            " - ",
                            style: CustomTextStyles(context).bodySmall10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            merchant.distanceFromUser,
                            style: CustomTextStyles(context).bodySmall10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    _tagList(context),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tagList(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount:
            merchant.categories.length >= 2 ? 2 : merchant.categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 1) {
            return _tagView(
              context,
              context.tr(
                "spa.tags_more",
                args: [(merchant.categories.length - 1).toString()],
              ),
            );
          }
          return _tagView(context, merchant.categories[index]);
        },
      ),
    );
  }

  Widget _tagView(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles(context).bodySmall10.copyWith(
                color: theme(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }
}
