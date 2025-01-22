import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/model/ui_model/promo_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';

class PromoPlaceItem extends StatelessWidget {
  const PromoPlaceItem({super.key, required this.promo});

  final PromoModel promo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
        child: Card(
          elevation: 5.h,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.promoDetailScreen,
                  arguments: promo);
            },
            child: Padding(
              padding: EdgeInsets.all(5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    width: Sizeutils.width,
                    height: 180.h,
                    boxFit: BoxFit.contain,
                    imagePath: promo.imagePath,
                  ),
                  Text(
                    promo.title,
                    style: theme(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    promo.publisher,
                    style: CustomTextStyles(context).bodySmall10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text(
                        context.tr("promo.from",
                            namedArgs: {"date": DatetimeUtils.dmy(promo.from)}),
                        style: CustomTextStyles(context).bodySmall12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.h),
                      Text(
                        context.tr("promo.to",
                            namedArgs: {"date": DatetimeUtils.dmy(promo.to)}),
                        style: CustomTextStyles(context).bodySmall12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
