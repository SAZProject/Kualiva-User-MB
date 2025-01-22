import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/model/ui_model/promo_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';

class PromoPlaceDetail extends StatelessWidget {
  const PromoPlaceDetail({super.key, required this.promo});

  final PromoModel promo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _promoDetaiAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _promoDetaiAppBar(BuildContext context) {
    return CustomAppBar(onBackPressed: () => Navigator.pop(context));
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              width: Sizeutils.width,
              height: 200.h,
              boxFit: BoxFit.cover,
              imagePath: promo.imagePath,
            ),
            Divider(
              color: theme(context).colorScheme.primary,
              height: 15.h,
              thickness: 2.h,
              indent: 25.h,
              endIndent: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.title,
                    style: theme(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    context.tr("f_n_b_detail.promo_date",
                        namedArgs: {"date": DatetimeUtils.dmy(promo.date)}),
                    style: CustomTextStyles(context).bodySmall12,
                    maxLines: 1,
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
          ],
        ),
      ),
    );
  }
}
