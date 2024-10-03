import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/screen/save_to_collection.dart';
import 'package:like_it/common/utility/datetime_utils.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_map_bottom_sheet.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/ui_model/promo_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FNBDetailScreen extends StatefulWidget {
  const FNBDetailScreen({super.key, required this.fnbModel});

  final FNBModel fnbModel;

  @override
  State<FNBDetailScreen> createState() => _FNBDetailScreenState();
}

class _FNBDetailScreenState extends State<FNBDetailScreen> {
  final GlobalKey _toolTipKey = GlobalKey();

  FNBModel get fnbData => super.widget.fnbModel;
  bool _hasCallSupport = false;

  List<PromoModel> listPromo = [
    PromoModel(
      imagePath: ImageConstant.arasaka,
      title: "Discount 10%\n(Max Rp20.000)",
      publisher: "Arasaka Corp",
      date: DateTime.now(),
    ),
    PromoModel(
      imagePath: ImageConstant.arasaka,
      title: "Discount 100%",
      publisher: "Arasaka Corp",
      date: DateTime.now(),
    ),
  ];

  List<Widget> imageSliders = [];

  void _popUpMenuAction(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(context, AppRoutes.reportPlaceScreen,
            arguments: fnbData);
        break;
      case 2:
        break;
      default:
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.h),
            ),
          ),
          context: context,
          builder: (BuildContext context) => const SaveToCollection(),
        );
    }
  }

  Future<void> _launchContact(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future showAndCloseTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final dynamic tooltip = _toolTipKey.currentState;
    tooltip?.ensureTooltipVisible();
    await Future.delayed(const Duration(seconds: 3));
    tooltip?.deactivate();
  }

  @override
  void initState() {
    super.initState();
    showAndCloseTooltip();
    imageSliders = fnbData.placePicture.map(
      (image) {
        return CustomImageView(
          imagePath: image,
          boxFit: BoxFit.cover,
          height: 360.h,
          width: double.maxFinite,
        );
      },
    ).toList();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.maxFinite,
          height: Sizeutils.height,
          decoration: BoxDecoration(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            image: DecorationImage(
              image: AssetImage(ImageConstant.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: _fnbPlaceImages(context),
              ),
              Column(
                children: [
                  SizedBox(height: 5.h),
                  _fnbAppBar(context),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: Container(
                      width: double.maxFinite,
                      decoration: CustomDecoration(context)
                          .fillOnSecondaryContainer_06
                          .copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10,
                          ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 5.h),
                            _fnbPlaceName(context),
                            SizedBox(height: 5.h),
                            _fnbPlaceAbout(context),
                            SizedBox(height: 5.h),
                            _fnbPromo(context),
                            SizedBox(height: 5.h),
                            _fnbPlaceMenu(context),
                            SizedBox(height: 5.h),
                            _fnbPlaceReviews(context),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fnbAppBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.h),
            decoration: BoxDecoration(
              color: theme(context)
                  .colorScheme
                  .onSecondaryContainer
                  .withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 25.h,
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Row(
            children: [
              _buildPopupMenuItem(context, 0, Icons.favorite),
              SizedBox(width: 5.h),
              _buildPopupMenuItem(context, 1, Icons.flag),
              SizedBox(width: 5.h),
              _buildPopupMenuItem(context, 2, Icons.share),
              SizedBox(width: 5.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenuItem(BuildContext context, int index, IconData icon) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Center(child: Icon(icon, size: 25.h)),
        onPressed: () => _popUpMenuAction(context, index),
      ),
    );
  }

  Widget _fnbPlaceImages(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          // enlargeCenterPage: true,
        ),
      ),
    );
  }

  Widget _fnbPlaceName(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 30.h,
                child: Text(
                  fnbData.placeName,
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Tooltip(
                key: _toolTipKey,
                triggerMode: TooltipTriggerMode.manual,
                message: fnbData.isClaimed
                    ? context.tr("f_n_b_detail.place_claimed")
                    : context.tr("f_n_b_detail.place_not_claimed"),
                child: CustomImageView(
                  width: 20.h,
                  height: 20.h,
                  imagePath: fnbData.isClaimed
                      ? ImageConstant.placeVerify
                      : brightness == Brightness.light
                          ? ImageConstant.placeVerifyLight
                          : ImageConstant.placeVerifyDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fnbPlaceAbout(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              context.tr("f_n_b_detail.about"),
              style: theme(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 5.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.tag,
                label: "",
                trailingWidget: _aboutTag(context),
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.timer,
                label: "",
                trailingWidget: _aboutOperationalTime(context),
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.phone,
                label: fnbData.phoneNumber,
                onPressed: _hasCallSupport
                    ? () =>
                        _launchContact(fnbData.phoneNumber.replaceAll("-", ""))
                    : null,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.place,
                label: fnbData.placeAddress,
                maxLines: 4,
                onPressed: () {
                  customMapBottomSheet(
                    context,
                    double.parse(fnbData.latitude),
                    double.parse(fnbData.longitude),
                    fnbData.placeName,
                  );
                },
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.attach_money,
                label: "",
                trailingWidget: _aboutPrice(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(
    BuildContext context, {
    Widget? leadingWidget,
    Widget? trailingWidget,
    required IconData icon,
    required String label,
    int maxLines = 1,
    void Function()? onPressed,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingWidget ?? Icon(icon, size: 20.h),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: trailingWidget ??
                  InkWell(
                    onTap: onPressed,
                    child: Text(
                      label,
                      style: onPressed != null
                          ? CustomTextStyles(context).bodySmall12.copyWith(
                                color: theme(context).colorScheme.onPrimary,
                              )
                          : CustomTextStyles(context).bodySmall12,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutTag(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        children: List<Widget>.generate(
          fnbData.tags.length,
          (index) => _tagView(context, label: fnbData.tags[index]),
        ),
      ),
    );
  }

  Widget _tagView(BuildContext context, {required String label}) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration: CustomDecoration(context).fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: CustomTextStyles(context).bodyMedium_13,
          ),
        ),
      ),
    );
  }

  Widget _aboutOperationalTime(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(bottom: 5.h),
        dense: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 0.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr("f_n_b_detail.about_open"),
              style: CustomTextStyles(context).bodyMedium_13,
            ),
            _operationalDayHourView(
                context, DatetimeUtils.getTodayOperationalTime(), true),
          ],
        ),
        children: fnbData.operationalDay.map(
          (index) {
            return _operationalDayHourView(context, index, false);
          },
        ).toList(),
      ),
    );
  }

  Widget _operationalDayHourView(
      BuildContext context, int index, bool isTitle) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: isTitle ? 60.h : 120.h,
            child: Text(
              "${DatetimeUtils.getDays(index)},",
              style: CustomTextStyles(context).bodySmall12,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 50.h,
                child: Text(
                  DatetimeUtils.getHour(fnbData.operationalTimeOpen[index]),
                  style: CustomTextStyles(context).bodySmall12,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 20.h,
                child: Text(
                  " - ",
                  style: CustomTextStyles(context).bodySmall12,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 50.h,
                child: Text(
                  DatetimeUtils.getHour(fnbData.operationalTimeClose[index]),
                  style: CustomTextStyles(context).bodySmall12,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _aboutPrice(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(bottom: 5.h),
        dense: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 0.0),
        title: Text(
          context.tr(
            "f_n_b_detail.about_price",
            namedArgs: {"price": fnbData.avgPrice},
          ),
          style: CustomTextStyles(context).bodyMedium_13,
        ),
        children: fnbData.listPriceFnB.map(
          (price) {
            return _priceStartFromFnB(
                context, price, fnbData.listPriceFnB.indexOf(price));
          },
        ).toList(),
      ),
    );
  }

  Widget _priceStartFromFnB(BuildContext context, String price, int index) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 5.h),
          Icon(
            index == 0 ? Icons.restaurant : Icons.local_drink,
            size: 16.h,
          ),
          SizedBox(width: 10.h),
          Text(
            context.tr("f_n_b_detail.about_price_f_n_b", namedArgs: {
              "price": price,
            }),
            style: CustomTextStyles(context).bodySmall12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _fnbPromo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b_detail.promo"),
            onPressed: () {},
            useIcon: false,
          ),
          Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: listPromo.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: listPromo.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (listPromo.isNotEmpty) {
                        return _eventListItems(
                            context, index, listPromo[index]);
                      }
                      return const CustomEmptyState();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _eventListItems(BuildContext context, int index, PromoModel promo) {
    return Container(
      width: 300.h,
      margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
      decoration: CustomDecoration(context).gradientYellowAToOnPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                      promo.publisher,
                      style: CustomTextStyles(context).bodySmall10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                CustomImageView(
                  width: 75.h,
                  height: 75.h,
                  boxFit: BoxFit.contain,
                  imagePath: promo.imagePath,
                )
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              context.tr("f_n_b_detail.promo_date",
                  namedArgs: {"date": DatetimeUtils.dmy(promo.date)}),
              style: CustomTextStyles(context).bodySmall12,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fnbPlaceMenu(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b_detail.menu"),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.fnbDetailMenuScreen,
                  arguments: fnbData.priceListMenuPicture);
            },
          ),
          Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: fnbData.priceListMenuPicture.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: fnbData.priceListMenuPicture.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (fnbData.priceListMenuPicture.isNotEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 8.h),
                          child: CustomImageView(
                            imagePath: fnbData.priceListMenuPicture[index],
                            height: 130.h,
                            width: 200.h,
                            radius: BorderRadius.circular(10.h),
                          ),
                        );
                      }
                      return const CustomEmptyState();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _fnbPlaceReviews(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b_detail.review"),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.reviewScreen,
                  arguments: fnbData);
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr("f_n_b_detail.total_review", namedArgs: {
                    "total": fnbData.totalReview.toString(),
                  }),
                  style: CustomTextStyles(context).bodySmall12,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.h,
                      height: 100.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            fnbData.avgRating.toString(),
                            style: CustomTextStyles(context).titleLarge_22,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            context.tr("f_n_b_detail.avg_rating"),
                            style:
                                CustomTextStyles(context).bodySmall12.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fnbData.totalRatingPerStar.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return _reviewIndicator(context, index,
                              fnbData.totalRatingPerStar[index]);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewIndicator(BuildContext context, int index, int totalRate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 20.h,
          child: Text(
            "${index + 1}",
            style: CustomTextStyles(context).bodySmall12,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 100.h,
          child: LinearProgressIndicator(
            color: theme(context).colorScheme.primary,
            value: (totalRate / fnbData.totalReview).toDouble(),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 50.h,
          child: Text(
            "$totalRate",
            style: CustomTextStyles(context).bodySmall12,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
