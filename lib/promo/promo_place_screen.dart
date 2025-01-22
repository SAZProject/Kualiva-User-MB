import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/model/ui_model/promo_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/promo/widget/promo_place_item.dart';

class PromoPlaceScreen extends StatelessWidget {
  const PromoPlaceScreen({super.key, required this.listPromo});

  final List<PromoModel> listPromo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _promoPlaceAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _promoPlaceAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("promo.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            _buildListPromoPlace(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildListPromoPlace(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listPromo.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          child: PromoPlaceItem(promo: listPromo[index]),
        );
      },
    );
  }
}
