import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/f_n_b_model.dart';

class FNBPromoItem extends StatelessWidget {
  const FNBPromoItem(
      {super.key, required this.fnbModel, required this.onPressed});

  final FNBModel fnbModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.h),
      decoration: CustomDecoration(context)
          .outlineOnSecondaryContainer
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    alignment: Alignment.center,
                    imagePath: fnbModel.placePicture[0],
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
                            fnbModel.overallRating.toString(),
                            style: theme(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                      ),
                      decoration: CustomDecoration(context)
                          .gradientPrimaryContainerToRedA,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.discount,
                            size: 15.h,
                          ),
                          SizedBox(width: 4.h),
                          Text(
                            context.tr("f_n_b.promo_value", args: ["60"]),
                            style: theme(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                fnbModel.placeName,
                style: theme(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                fnbModel.city,
                style: theme(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _firstTagRow(context),
                SizedBox(height: 4.h),
                fnbModel.tags.length > 2
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
        itemCount: fnbModel.tags.length >= 2 ? 2 : fnbModel.tags.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _tagView(context, fnbModel.tags[index]);
        },
      ),
    );
  }

  Widget _secondTagRow(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: fnbModel.tags.length > 4 ? 2 : 1,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 1) {
            if (fnbModel.tags.length > 4) {
              return _tagView(
                context,
                context.tr(
                  "home_screen.tags_more",
                  args: [(fnbModel.tags.length - 3).toString()],
                ),
              );
            } else {
              return _tagView(context, fnbModel.tags[index + 2]);
            }
          }
          return _tagView(context, fnbModel.tags[index + 2]);
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
