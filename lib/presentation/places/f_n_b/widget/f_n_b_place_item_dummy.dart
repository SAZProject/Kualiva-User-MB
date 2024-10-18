import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/place/place_model.dart';

class FNBPlaceItemDummy extends StatelessWidget {
  const FNBPlaceItemDummy({
    super.key,
    required this.place,
    required this.onPressed,
  });

  final Place place;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.h),
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
                  // https://lh5.googleusercontent.com/p/AF1QipNNTuC6HYtW4TGRybf5cfUi_Twx8cUyKhF08czq=w408-h408-k-no
                  // https://lh5.googleusercontent.com/p/ChIJB9Y8liH0aS4RemVuMOm5PFA=w408-h408-k-no
                  CustomImageView(
                    imagePath: place.icon,
                    // imagePath: "${ImageConstant.fnb1Path}/A/2.jpg",
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
                            '${place.rating}',
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
                      place.name,
                      style: theme(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      'jakarta',
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
    );
  }

  Widget _tagList(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: place.types.length > 4 ? 4 : place.types.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 3) {
            if (place.types.length > 4) {
              return _tagView(
                context,
                context.tr(
                  "f_n_b.tags_more",
                  args: [(place.types.length - 3).toString()],
                ),
              );
            } else {
              return _tagView(context, place.types[index]);
            }
          }
          return _tagView(context, place.types[index]);
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
