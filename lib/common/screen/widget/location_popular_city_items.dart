import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/data/model/ui_model/loc_popular_city_model.dart';

class LocationPopularCityItems extends StatelessWidget {
  const LocationPopularCityItems({
    super.key,
    required this.locPopularCityModel,
    required this.onPressed,
  });

  final LocPopularCityModel locPopularCityModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.h,
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.h),
      decoration: CustomDecoration(context)
          .outlineOnSecondaryContainer
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              alignment: Alignment.center,
              imagePath: locPopularCityModel.cityImagePath,
              boxFit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
              radius: BorderRadiusStyle.roundedBorder10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                decoration:
                    CustomDecoration(context).fillOnSecondaryContainer_06,
                child: Text(
                  locPopularCityModel.cityName,
                  style: theme(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
