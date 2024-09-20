import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/f_n_b_model.dart';

class FNBNearestItem extends StatelessWidget {
  const FNBNearestItem(
      {super.key, required this.fnbModel, required this.onPressed});

  final FNBModel fnbModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: double.maxFinite,
      child: Container(
        height: 100.h,
        width: double.maxFinite,
        decoration: CustomDecoration(context)
            .outlineOnSecondaryContainer
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: InkWell(
          borderRadius: BorderRadiusStyle.roundedBorder10,
          onTap: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
                width: 85.h,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomImageView(
                      imagePath: fnbModel.placePicture[0],
                      height: 100.h,
                      width: double.maxFinite,
                      radius: BorderRadius.horizontal(
                        left: Radius.circular(10.h),
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
                        decoration: CustomDecoration(context)
                            .orange60Color
                            .copyWith(
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
                    )
                  ],
                ),
              ),
              SizedBox(width: 5.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      height: 20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.attach_money, size: 15.h),
                          Icon(Icons.attach_money, size: 15.h),
                          Icon(Icons.attach_money, size: 15.h),
                          Icon(Icons.attach_money, size: 15.h),
                          Icon(Icons.attach_money, size: 15.h),
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
        itemCount: fnbModel.tags.length > 4 ? 4 : fnbModel.tags.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 3) {
            if (fnbModel.tags.length > 4) {
              return _tagView(
                context,
                context.tr(
                  "f_n_b.tags_more",
                  args: [(fnbModel.tags.length - 3).toString()],
                ),
              );
            } else {
              return _tagView(context, fnbModel.tags[index]);
            }
          }
          return _tagView(context, fnbModel.tags[index]);
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
