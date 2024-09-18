import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/screen/save_to_collection.dart';
import 'package:like_it/common/utility/datetime_utils.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/presentation/review/widget/review_view.dart';
import 'package:like_it/presentation/review/widget/special_review_view.dart';
import 'package:url_launcher/url_launcher.dart';

class FNBDetailScreen extends StatefulWidget {
  const FNBDetailScreen({super.key, required this.fnbModel});

  final FNBModel fnbModel;

  @override
  State<FNBDetailScreen> createState() => _FNBDetailScreenState();
}

class _FNBDetailScreenState extends State<FNBDetailScreen> {
  FNBModel get fnbData => super.widget.fnbModel;
  bool _hasCallSupport = false;

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

  @override
  void initState() {
    super.initState();
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
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _fnbAppBar(context),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            _fnbPlaceImages(context),
            SizedBox(height: 5.h),
            _fnbPlaceName(context),
            SizedBox(height: 5.h),
            _fnbPlaceAbout(context),
            SizedBox(height: 5.h),
            _fnbPlaceMenu(context),
            SizedBox(height: 5.h),
            _fnbPlaceReviews(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _fnbAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50.h,
      leadingWidth: 50.h,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: true,
      leading: Container(
        margin: const EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          color:
              theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: PopupMenuButton(
            position: PopupMenuPosition.under,
            iconSize: 25.h,
            constraints: BoxConstraints(
              maxWidth: 50.h,
            ),
            itemBuilder: (ctx) => [
              _buildPopupMenuItem(context, 0, Icons.favorite),
              _buildPopupMenuItem(context, 1, Icons.flag),
              _buildPopupMenuItem(context, 2, Icons.share),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      BuildContext context, int index, IconData icon) {
    return PopupMenuItem(
      onTap: () => _popUpMenuAction(context, index),
      value: index,
      child: Center(child: Icon(icon, size: 25.h)),
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
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              fnbData.placeName,
              textAlign: TextAlign.center,
              style: theme(context).textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.reviewScreen,
                    arguments: fnbData);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.star,
                      size: 20.h,
                      color: appTheme.amber700,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      fnbData.overallRating.toString(),
                      textAlign: TextAlign.center,
                      style: theme(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          SizedBox(height: 6.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(5.h),
            decoration:
                CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      ? () => _launchContact(
                          fnbData.phoneNumber.replaceAll("-", ""))
                      : null,
                ),
                SizedBox(height: 8.h),
                //TODO navigate to maps app
                _buildAboutContent(
                  context,
                  icon: Icons.place,
                  label: fnbData.placeAddress,
                  maxLines: 4,
                ),
                SizedBox(height: 8.h),
                _buildAboutContent(
                  context,
                  icon: Icons.star,
                  label: context.tr(
                    "f_n_b_detail.about_price",
                    namedArgs: {"price": "45.000"},
                  ),
                  leadingWidget: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.attach_money, size: 20.0),
                      Icon(Icons.attach_money, size: 20.0),
                      Icon(Icons.attach_money, size: 20.0),
                      Icon(Icons.attach_money, size: 20.0),
                      Icon(Icons.attach_money, size: 20.0),
                    ],
                  ),
                ),
              ],
            ),
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
        title: Text(
          context.tr("f_n_b_detail.about_open"),
          style: CustomTextStyles(context).bodyMedium_13,
        ),
        children: fnbData.operationalDay.map(
          (index) {
            return _operationalDayHourView(context, index);
          },
        ).toList(),
      ),
    );
  }

  Widget _operationalDayHourView(BuildContext context, int index) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.h,
            child: Text(
              "${DatetimeUtils.getDays(index)},",
              style: CustomTextStyles(context).bodySmall12,
            ),
          ),
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
            child: ListView.builder(
              itemCount: fnbData.priceListMenuPicture.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.h),
                  child: CustomImageView(
                    imagePath: fnbData.priceListMenuPicture[index],
                    height: 130.h,
                    width: 200.h,
                    radius: BorderRadius.circular(10.h),
                  ),
                );
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
            height: 200.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: fnbData.review.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ReviewModel reviewData = fnbData.review[index];
                if (reviewData.specialReview) {
                  return SpecialReviewView(reviewData: reviewData);
                }
                return ReviewView(reviewData: reviewData);
              },
            ),
          ),
        ],
      ),
    );
  }
}
