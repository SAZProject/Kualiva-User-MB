import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/ui_model/promo_model.dart';
import 'package:kualiva/_data/model/util_model/filter_toggle_model.dart';
import 'package:kualiva/_data/model/util_model/get_time_g_api_util_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/filter_dataset.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_float_modal.dart';
import 'package:kualiva/common/widget/custom_map_bottom_sheet.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/common/widget/custom_snack_bar.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_detail_bloc.dart';
import 'package:kualiva/places/nightlife/model/nightlife_detail_model.dart';
import 'package:kualiva/report/argument/report_place_argument.dart';
import 'package:kualiva/review/argument/review_argument.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class NightlifeDetailScreen extends StatelessWidget {
  NightlifeDetailScreen({super.key, required this.placeArgument});

  static const PlaceCategoryEnum placeCategory = PlaceCategoryEnum.nightLife;

  // final GlobalKey _toolTipKey = GlobalKey();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  final PlaceArgument placeArgument;

  final List<Widget> imageSliders = [];

  List<PromoModel> listPromo = [
    PromoModel(
      imagePath: ImageConstant.arasaka,
      title: "Discount 10% (Max Rp20.000)",
      publisher: "Arasaka Corp",
      date: DateTime.now(),
      from: Faker()
          .date
          .dateTimeBetween(DateTime(2025, 1, 1), DateTime(2025, 1, 14)),
      to: Faker()
          .date
          .dateTimeBetween(DateTime(2025, 1, 15), DateTime(2025, 1, 31)),
    ),
    PromoModel(
      imagePath: ImageConstant.arasaka,
      title: "Discount 100%",
      publisher: "Arasaka Corp",
      date: DateTime.now(),
      from: Faker()
          .date
          .dateTimeBetween(DateTime(2025, 1, 1), DateTime(2025, 1, 14)),
      to: Faker()
          .date
          .dateTimeBetween(DateTime(2025, 1, 15), DateTime(2025, 1, 31)),
    ),
  ];

  // Future showAndCloseTooltip() async {
  //   await Future.delayed(const Duration(milliseconds: 10));
  //   final dynamic tooltip = _toolTipKey.currentState;
  //   tooltip?.ensureTooltipVisible();
  //   await Future.delayed(const Duration(seconds: 3));
  //   tooltip?.deactivate();
  // }

  Future<void> _launchContact(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void _showModal(BuildContext context, String? imagePath) {
    _overlayEntry = OverlayEntry(
      builder: (context) => SizedBox(
        width: double.maxFinite,
        child: CompositedTransformFollower(
          link: _layerLink,
          child: CustomFloatModal(imagePath: imagePath ?? ""),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry);
  }

  void _dismissModal() {
    // if (_overlayEntry != null) {
    //   _overlayEntry?.remove();
    //   _overlayEntry = null;
    // }
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<NightlifeDetailBloc>()
        .add(NightlifeDetailFetched(placeId: placeArgument.placeId));
    return BlocConsumer<NightlifeDetailBloc, NightlifeDetailState>(
      listener: (context, state) {
        if (state is NightlifeDetailSuccess) {}
        if (state is NightlifeDetailFailure) {
          showSnackBar(context, Icons.error_outline, Colors.red,
              context.tr("common.error_try_again"), Colors.red);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is NightlifeDetailSuccess) {
          bool hasCallSupport = true;
          // showAndCloseTooltip();
          canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
            hasCallSupport = result;
          });
          imageSliders.addAll(List.generate(
            1,
            (index) {
              return CustomImageView(
                imagePath:
                    placeArgument.featuredImage ?? Faker().image.loremPicsum(),
                boxFit: BoxFit.cover,
                height: 360.h,
                width: double.maxFinite,
              );
            },
          ));
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              body: SizedBox(
                width: double.maxFinite,
                height: Sizeutils.height,
                child: _body(context, state.nightlifeDetail, hasCallSupport),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _body(
    BuildContext context,
    NightlifeDetailModel nightlifeDetail,
    bool hasCallSupport,
  ) {
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
                child: _nightLifePlaceImages(context),
              ),
              Column(
                children: [
                  SizedBox(height: 5.h),
                  _nightLifeAppBar(context),
                  SizedBox(height: 100.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: placeArgument.isMerchant
                              ? CustomDecoration(context).outlinePrimary_06
                              : CustomDecoration(context)
                                  .fillOnSecondaryContainer
                                  .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder10,
                                  ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 5.h),
                                _nightLifePlaceName(context, nightlifeDetail),
                                SizedBox(height: 5.h),
                                _nightLifePlaceAbout(
                                    context, nightlifeDetail, hasCallSupport),
                                SizedBox(height: 5.h),
                                _nightPromo(context, nightlifeDetail),
                                SizedBox(height: 5.h),
                                _nightLifePlaceReviews(
                                    context, nightlifeDetail),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
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

  Widget _nightLifePlaceImages(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: false,
          // enlargeCenterPage: true,
        ),
      ),
    );
  }

  Widget _nightLifeAppBar(BuildContext context) {
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
                  .withValues(alpha: 0.6),
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
        color: theme(context)
            .colorScheme
            .onSecondaryContainer
            .withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Center(child: Icon(icon, size: 25.h)),
        onPressed: () => _popUpMenuAction(context, index),
      ),
    );
  }

  void _popUpMenuAction(BuildContext context, int index) {
    switch (index) {
      case 1:
        LeLog.sd(this, _popUpMenuAction, '');
        Navigator.pushNamed(
          context,
          AppRoutes.reportPlaceScreen,
          arguments: ReportPlaceArgument(
            placeCategoryEnum: PlaceCategoryEnum.nightLife,
            placeId: placeArgument.placeId,
          ),
        );
        break;
      case 2:
        break;
      default:
      // TODO dimatikan untuk V!
      // showModalBottomSheet(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       top: Radius.circular(25.h),
      //     ),
      //   ),
      //   context: context,
      //   builder: (BuildContext context) => const SaveToCollection(),
      // );
    }
  }

  Widget _nightLifePlaceName(
      BuildContext context, NightlifeDetailModel nightlifeDetail) {
    // var brightness = Theme.of(context).brightness;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child:
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
                child: Text(
                  nightlifeDetail.name ?? "",
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: !placeArgument.isMerchant,
                child: CustomElevatedButton(
                  initialText: context.tr("nightlife_detail.claim_btn"),
                  height: 30.0,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  buttonStyle: CustomButtonStyles.none,
                  decoration:
                      CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(
                          context),
                  buttonTextStyle:
                      CustomTextStyles(context).titleMediumOnPrimaryContainer,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Tooltip(
        //     key: _toolTipKey,
        //     triggerMode: TooltipTriggerMode.manual,
        //     message: placeArgument.isMerchant
        //         ? context.tr("nightlife_detail.place_claimed")
        //         : context.tr("nightlife_detail.place_not_claimed"),
        //     child: CustomImageView(
        //       width: 20.h,
        //       height: 20.h,
        //       imagePath: placeArgument.isMerchant
        //           ? ImageConstant.placeVerify
        //           : brightness == Brightness.light
        //               ? ImageConstant.placeVerifyLight
        //               : ImageConstant.placeVerifyDark,
        //     ),
        //   ),
        // ),
        // ],
        // ),
      ),
    );
  }

  Widget _nightLifePlaceAbout(BuildContext context,
      NightlifeDetailModel nightlifeDetail, bool hasCallSupport) {
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
              context.tr("nightlife_detail.about"),
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
                trailingWidget: _aboutTag(context, nightlifeDetail),
                visible: nightlifeDetail.types != null,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.timer,
                label: "",
                trailingWidget: _aboutOperationalTime(context, nightlifeDetail),
                visible: nightlifeDetail.currentOpeningHours != null,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.table_bar_outlined,
                label: "",
                trailingWidget: _aboutFacilities(context, nightlifeDetail),
                visible: placeArgument.isMerchant,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.phone,
                label: nightlifeDetail.formattedPhoneNumber ?? "",
                onPressed: hasCallSupport
                    ? () => _launchContact(
                        nightlifeDetail.formattedPhoneNumber ??
                            "".replaceAll("-", ""))
                    : null,
                visible: nightlifeDetail.formattedPhoneNumber != null,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.place,
                label: nightlifeDetail.formattedAddress ?? "",
                maxLines: 4,
                onPressed: () {
                  customMapBottomSheet(
                    context,
                    nightlifeDetail.geometry == null
                        ? 0.0
                        : nightlifeDetail.geometry!.location.lat,
                    nightlifeDetail.geometry == null
                        ? 0.0
                        : nightlifeDetail.geometry!.location.lng,
                    nightlifeDetail.name ?? "",
                  );
                },
                visible: nightlifeDetail.formattedAddress != null,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.attach_money,
                label: "",
                trailingWidget: _aboutPrice(context, nightlifeDetail),
                visible: placeArgument.isMerchant,
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
    bool visible = false,
  }) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leadingWidget ?? Icon(icon, size: 25.h),
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
      ),
    );
  }

  Widget _aboutTag(BuildContext context, NightlifeDetailModel nightlifeDetail) {
    return Visibility(
      visible: nightlifeDetail.types != null,
      child: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          children: List<Widget>.generate(
            nightlifeDetail.types == null ? 1 : nightlifeDetail.types!.length,
            (index) => _tagView(
              context,
              label: nightlifeDetail.types![index],
              businessStatus: placeArgument.isMerchant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _tagView(BuildContext context,
      {required String label, required bool businessStatus}) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration: businessStatus
            ? CustomDecoration.fillBlack900_06.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder5,
              )
            : CustomDecoration(context).fillPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder5,
                ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: businessStatus
                ? CustomTextStyles(context)
                    .bodyMedium_13
                    .copyWith(color: theme(context).colorScheme.primary)
                : CustomTextStyles(context).bodyMedium_13,
          ),
        ),
      ),
    );
  }

  Widget _aboutOperationalTime(
      BuildContext context, NightlifeDetailModel nightlifeDetail) {
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
            // Text(
            //   context.tr("nightlife_detail.about_open"),
            //   style: CustomTextStyles(context).bodyMedium_13,
            // ),
            _operationalDayHourView(context,
                DatetimeUtils.getTodayOperationalTime(), true, nightlifeDetail),
          ],
        ),
        children: nightlifeDetail.currentOpeningHours != null
            ? nightlifeDetail.currentOpeningHours!.weekdayText
                .map((openingDay) {
                return _operationalDayHourView(
                    context,
                    nightlifeDetail.currentOpeningHours!.weekdayText
                        .indexOf(openingDay),
                    false,
                    nightlifeDetail);
              }).toList()
            : [0, 1, 2, 3, 4, 5, 6].map(
                (index) {
                  return _operationalDayHourView(
                      context, index, false, nightlifeDetail);
                },
              ).toList(),
      ),
    );
  }

  Widget _operationalDayHourView(BuildContext context, int index, bool isTitle,
      NightlifeDetailModel nightlifeDetail) {
    late DateTime openTime;
    late DateTime closeTime;
    if (nightlifeDetail.currentOpeningHours != null) {
      String placeOpenCloseTime =
          nightlifeDetail.currentOpeningHours!.weekdayText[index];

      GetTimeGApiUtilModel getOpenTime =
          DatetimeUtils.getOpenHourGAPIFormat(placeOpenCloseTime);
      openTime =
          DateTime(0, 0, 0, getOpenTime.hour ?? 0, getOpenTime.minute ?? 0);

      GetTimeGApiUtilModel getCloseTime =
          DatetimeUtils.getCloseHourGAPIFormat(placeOpenCloseTime);
      closeTime =
          DateTime(0, 0, 0, getCloseTime.hour ?? 0, getCloseTime.minute ?? 0);
    }
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: isTitle ? 80.h : 120.h,
            child: Text(
              nightlifeDetail.currentOpeningHours != null
                  ? "${DatetimeUtils.getDays(index)},"
                  : "${DatetimeUtils.getDays([
                      0,
                      1,
                      2,
                      3,
                      4,
                      5,
                      6,
                      7
                    ][index])},",
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
                  nightlifeDetail.currentOpeningHours != null
                      ? DatetimeUtils.getHour(openTime)
                      : DatetimeUtils.getHour([
                          DateTime(0, 0, 0, 10, 0),
                          DateTime(0, 0, 0, 10, 0),
                          DateTime(0, 0, 0, 10, 0),
                          DateTime(0, 0, 0, 10, 0),
                          DateTime(0, 0, 0, 10, 0),
                          DateTime(0, 0, 0, 10, 0),
                          DateTime(0, 0, 0, 10, 0),
                        ][index]),
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
                  nightlifeDetail.currentOpeningHours != null
                      ? DatetimeUtils.getHour(closeTime)
                      : DatetimeUtils.getHour([
                          DateTime(0, 0, 0, 22, 0),
                          DateTime(0, 0, 0, 22, 0),
                          DateTime(0, 0, 0, 22, 0),
                          DateTime(0, 0, 0, 22, 0),
                          DateTime(0, 0, 0, 22, 0),
                          DateTime(0, 0, 0, 22, 0),
                          DateTime(0, 0, 0, 22, 0),
                        ][index]),
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

  Widget _aboutFacilities(
      BuildContext context, NightlifeDetailModel nightlifeDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(bottom: 10.h),
        dense: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 0.0),
        title: _facilitiesView(context, null, true, nightlifeDetail),
        children: FilterDataset.facilitiesDataset.map(
          (filterData) {
            return _facilitiesView(context, filterData, false, nightlifeDetail);
          },
        ).toList(),
      ),
    );
  }

  Widget _facilitiesView(BuildContext context, FilterToggleModel? filterData,
      bool isTitle, NightlifeDetailModel nightlifeDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: !isTitle,
            child: Icon(
              filterData == null ? Icons.abc : filterData.icon,
              size: 15.h,
            ),
          ),
          SizedBox(width: isTitle ? 0.0 : 10.h),
          SizedBox(
            width: isTitle ? 80.h : 120.h,
            child: Text(
              isTitle
                  ? context.tr("nightlife_detail.facilities")
                  : filterData!.label,
              style: CustomTextStyles(context).bodySmall12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutPrice(
      BuildContext context, NightlifeDetailModel nightlifeDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        title: Text(
          context.tr(
            "nightlife_detail.about_price",
            namedArgs: {"price": "30.000"},
          ),
          style: CustomTextStyles(context).bodyMedium_13,
        ),
      ),
    );
  }

  Widget _nightPromo(
      BuildContext context, NightlifeDetailModel nightlifeDetail) {
    return Visibility(
      visible: placeArgument.isMerchant,
      replacement: const SizedBox(),
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        child: Column(
          children: [
            CustomSectionHeader(
              label: context.tr("nightlife_detail.promo"),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.promoPlaceScreen,
                    arguments: listPromo);
              },
              useIcon: true,
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
      ),
    );
  }

  Widget _eventListItems(BuildContext context, int index, PromoModel promo) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.promoDetailScreen,
            arguments: promo);
      },
      onLongPressStart: (details) {
        _showModal(context, promo.imagePath);
      },
      onLongPressMoveUpdate: (details) {
        if (details.localOffsetFromOrigin.distance > 100) {
          _dismissModal();
        }
      },
      onLongPressEnd: (details) {
        _dismissModal();
      },
      child: Container(
        width: 300.h,
        margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
        decoration:
            CustomDecoration(context).orangeColorBackgroundBlur.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder10,
                ),
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
              context.tr("nightlife_detail.promo_date",
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

  Widget _nightLifePlaceReviews(
      BuildContext context, NightlifeDetailModel nightlifeDetail) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("nightlife_detail.review"),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.reviewScreen,
                arguments: ReviewArgument(
                  placeUniqueId: placeArgument.placeId,
                  placeCategory: placeCategory,
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.reviewScreen,
                arguments: ReviewArgument(
                  placeUniqueId: placeArgument.placeId,
                  placeCategory: placeCategory,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr("nightlife_detail.total_review", namedArgs: {
                      "total": nightlifeDetail.reviews == null
                          ? "0"
                          : nightlifeDetail.reviews!.length.toString(),
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
                              nightlifeDetail.rating.toString(),
                              style: CustomTextStyles(context).titleLarge_22,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              context.tr("nightlife_detail.avg_rating"),
                              style: CustomTextStyles(context)
                                  .bodySmall12
                                  .copyWith(
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
                          itemCount: [0, 0, 0, 0, 1].length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return _reviewIndicator(context, index,
                                [0, 0, 0, 0, 1][index], nightlifeDetail);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewIndicator(BuildContext context, int index, int totalRate,
      NightlifeDetailModel nightlifeDetail) {
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
            value: (totalRate / 1).toDouble(),
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
