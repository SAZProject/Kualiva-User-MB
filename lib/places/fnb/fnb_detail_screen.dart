import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/model/util_model/get_time_g_api_util_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/filter_dataset.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_float_modal.dart';
import 'package:kualiva/common/widget/custom_map_bottom_sheet.dart';
import 'package:kualiva/common/widget/custom_scroll_text.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/_data/model/ui_model/promo_model.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/common/widget/custom_snack_bar.dart';
import 'package:kualiva/places/argument/place_argument.dart';

import 'package:kualiva/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/_data/model/util_model/filter_toggle_model.dart';
import 'package:kualiva/report/argument/report_place_argument.dart';
import 'package:kualiva/review/argument/review_argument.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class FnbDetailScreen extends StatelessWidget {
  FnbDetailScreen({
    super.key,
    required this.placeArgument,
  });

  static const PlaceCategoryEnum placeCategory = PlaceCategoryEnum.fnb;

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
        .read<FnbDetailBloc>()
        .add(FnbDetailFetched(placeId: placeArgument.placeId));
    return BlocConsumer<FnbDetailBloc, FnbDetailState>(
      listener: (context, state) {
        if (state is FnbDetailSuccess) {}
        if (state is FnbDetailFailure) {
          showSnackBar(context, Icons.error_outline, Colors.red,
              context.tr("common.error_try_again"), Colors.red);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is FnbDetailSuccess) {
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
              appBar: _fnbAppBar(context),
              body: SizedBox(
                width: double.maxFinite,
                height: Sizeutils.height,
                child: _body(context, state.fnbDetail, hasCallSupport),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: _fnbAppBar(context),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _body(
    BuildContext context,
    FnbDetailModel fnbDetail,
    bool hasCallSupport,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _fnbPlaceImages(context),
              SizedBox(height: 5.h),
              _fnbPlaceName(context, fnbDetail),
              _sectionDivider(context, true),
              _fnbPlaceAbout(context, fnbDetail, hasCallSupport),
              _sectionDivider(context, true),
              _fnbPromo(context, fnbDetail),
              _sectionDivider(context, placeArgument.isMerchant),
              _fnbPlaceMenu(context, fnbDetail),
              _sectionDivider(context, placeArgument.isMerchant),
              _fnbPlaceReviews(context, fnbDetail),
              SizedBox(height: 10.h),
              _fnbClaimButton(context),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionDivider(BuildContext context, bool isShowed) {
    return Visibility(
      visible: isShowed,
      child: Divider(
        height: 5.h,
        thickness: 1.h,
        color: theme(context).colorScheme.onPrimaryContainer,
        indent: 10.h,
        endIndent: 10.h,
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
          autoPlay: false,
          scrollPhysics: NeverScrollableScrollPhysics(),
          // enlargeCenterPage: true,
        ),
      ),
    );
  }

  PreferredSizeWidget _fnbAppBar(BuildContext context) {
    return CustomAppBar(
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
      actions: [
        SizedBox(width: 5.h),
        _buildPopupMenuItem(context, 0, Icons.favorite),
        SizedBox(width: 5.h),
        _buildPopupMenuItem(context, 1, Icons.flag),
        SizedBox(width: 5.h),
        _buildPopupMenuItem(context, 2, Icons.share),
        SizedBox(width: 5.h),
      ],
    );
  }

  Widget _buildPopupMenuItem(BuildContext context, int index, IconData icon) {
    return IconButton(
      icon: Center(child: Icon(icon, size: 25.h)),
      onPressed: () => _popUpMenuAction(context, index),
    );
  }

  void _popUpMenuAction(BuildContext context, int index) {
    switch (index) {
      case 1:
        LeLog.sd(this, _popUpMenuAction, '');
        Navigator.pushNamed(context, AppRoutes.reportPlaceScreen,
            arguments: ReportPlaceArgument(
              placeCategoryEnum: PlaceCategoryEnum.fnb,
              placeId: placeArgument.placeId,
            ));
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

  Widget _fnbPlaceName(BuildContext context, FnbDetailModel fnbDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            Flexible(
              child: CustomScrollText(
                key: ValueKey(fnbDetail.name ?? ""),
                text: fnbDetail.name ?? "",
                style: placeArgument.isMerchant
                    ? theme(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: theme(context).colorScheme.primary)
                    : theme(context).textTheme.titleLarge,
                height: 40.h,
              ),
            ),
            SizedBox(
              height: 10.h,
              width: 10.h,
              child: VerticalDivider(
                thickness: 1.0,
              ),
            ),
            SizedBox(
              height: 20.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.attach_money,
                    size: 15.h,
                    color: index <= ((fnbDetail.rating ?? 1.0).floor() - 1)
                        ? theme(context).colorScheme.primary
                        : null,
                  );
                }),
              ),
            ),
          ],
        ),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Tooltip(
        //     key: _toolTipKey,
        //     triggerMode: TooltipTriggerMode.manual,
        //     message: placeArgument.isMerchant
        //         ? context.tr("f_n_b_detail.place_claimed")
        //         : context.tr("f_n_b_detail.place_not_claimed"),
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

  Widget _fnbClaimButton(BuildContext context) {
    return Visibility(
      visible: !placeArgument.isMerchant,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: SizedBox(
          width: double.maxFinite,
          child: Align(
            alignment: Alignment.center,
            child: CustomElevatedButton(
              initialText: context.tr("f_n_b_detail.claim_btn"),
              height: 30.h,
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              buttonStyle: CustomButtonStyles.none,
              decoration:
                  CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(
                      context),
              buttonTextStyle:
                  CustomTextStyles(context).titleMediumOnPrimaryContainer,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Widget _fnbPlaceAbout(
      BuildContext context, FnbDetailModel fnbDetail, bool hasCallSupport) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            _buildAboutContent(
              context,
              icon: Icons.tag,
              label: "",
              trailingWidget: _aboutTag(context, fnbDetail),
              visible: fnbDetail.types != null,
            ),
            SizedBox(height: 8.h),
            _buildAboutContent(
              context,
              icon: Icons.timer,
              label: "",
              trailingWidget: _aboutOperationalTime(context, fnbDetail),
              visible: fnbDetail.currentOpeningHours != null,
            ),
            SizedBox(height: 8.h),
            _buildAboutContent(
              context,
              icon: Icons.table_bar_outlined,
              label: "",
              trailingWidget: _aboutFacilities(context, fnbDetail),
              visible: placeArgument.isMerchant,
            ),
            SizedBox(height: 8.h),
            _buildAboutContent(
              context,
              icon: Icons.phone,
              label: fnbDetail.formattedPhoneNumber ?? "",
              onPressed: hasCallSupport
                  ? () => _launchContact(
                      fnbDetail.formattedPhoneNumber ?? "".replaceAll("-", ""))
                  : null,
              visible: fnbDetail.formattedPhoneNumber != null,
            ),
            SizedBox(height: 8.h),
            _buildAboutContent(
              context,
              icon: Icons.place,
              label: fnbDetail.formattedAddress ?? "",
              maxLines: 4,
              onPressed: () {
                customMapBottomSheet(
                  context,
                  fnbDetail.geometry == null
                      ? 0.0
                      : fnbDetail.geometry!.location.lat,
                  fnbDetail.geometry == null
                      ? 0.0
                      : fnbDetail.geometry!.location.lng,
                  fnbDetail.name ?? "",
                );
              },
              visible: fnbDetail.formattedAddress != null,
            ),
            SizedBox(height: 8.h),
            _buildAboutContent(
              context,
              icon: Icons.attach_money,
              label: "",
              trailingWidget: _aboutPrice(context, fnbDetail),
              visible: placeArgument.isMerchant,
            ),
          ],
        ),
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
            leadingWidget ??
                Icon(
                  icon,
                  size: 25.h,
                  color: theme(context).colorScheme.primary,
                ),
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

  Widget _aboutTag(BuildContext context, FnbDetailModel fnbDetail) {
    return Visibility(
      visible: fnbDetail.types != null,
      child: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          children: List<Widget>.generate(
            fnbDetail.types == null ? 0 : fnbDetail.types!.length,
            (index) => _tagView(
              context,
              label: fnbDetail.types![index],
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

  Widget _aboutOperationalTime(BuildContext context, FnbDetailModel fnbDetail) {
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
            //   context.tr("f_n_b_detail.about_open"),
            //   style: CustomTextStyles(context).bodyMedium_13,
            // ),
            _operationalDayHourView(context,
                DatetimeUtils.getTodayOperationalTime(), true, fnbDetail),
          ],
        ),
        children: fnbDetail.currentOpeningHours != null
            ? fnbDetail.currentOpeningHours!.weekdayText.map((openingDay) {
                return _operationalDayHourView(
                    context,
                    fnbDetail.currentOpeningHours!.weekdayText
                        .indexOf(openingDay),
                    false,
                    fnbDetail);
              }).toList()
            : [0, 1, 2, 3, 4, 5, 6].map(
                (index) {
                  return _operationalDayHourView(
                      context, index, false, fnbDetail);
                },
              ).toList(),
      ),
    );
  }

  Widget _operationalDayHourView(
      BuildContext context, int index, bool isTitle, FnbDetailModel fnbDetail) {
    late DateTime openTime;
    late DateTime closeTime;
    if (fnbDetail.currentOpeningHours != null) {
      String placeOpenCloseTime =
          fnbDetail.currentOpeningHours!.weekdayText[index];

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
              fnbDetail.currentOpeningHours != null
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
                  fnbDetail.currentOpeningHours != null
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
                  fnbDetail.currentOpeningHours != null
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

  Widget _aboutFacilities(BuildContext context, FnbDetailModel fnbDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(bottom: 10.h),
        dense: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 0.0),
        title: _facilitiesView(context, null, true, fnbDetail),
        children: FilterDataset.facilitiesDataset.map(
          (filterData) {
            return _facilitiesView(context, filterData, false, fnbDetail);
          },
        ).toList(),
      ),
    );
  }

  Widget _facilitiesView(BuildContext context, FilterToggleModel? filterData,
      bool isTitle, FnbDetailModel fnbDetail) {
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
                  ? context.tr("f_n_b_detail.facilities")
                  : filterData!.label,
              style: CustomTextStyles(context).bodySmall12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutPrice(BuildContext context, FnbDetailModel fnbDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(bottom: 5.h),
        dense: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 0.0),
        title: Text(
          context.tr(
            "f_n_b_detail.about_price",
            namedArgs: {"price": "30.000"},
          ),
          style: CustomTextStyles(context).bodyMedium_13,
        ),
        children: ["35.000", "25.000"].map(
          (price) {
            return _priceStartFromFnB(
                context, price, ["35.000", "25.000"].indexOf(price));
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

  Widget _fnbPromo(BuildContext context, FnbDetailModel fnbDetail) {
    return Visibility(
      visible: placeArgument.isMerchant,
      replacement: const SizedBox(),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        child: Column(
          children: [
            CustomSectionHeader(
              label: context.tr("f_n_b_detail.promo"),
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

  Widget _fnbPlaceMenu(BuildContext context, FnbDetailModel fnbDetail) {
    return Visibility(
      visible: placeArgument.isMerchant,
      replacement: const SizedBox(),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        child: Column(
          children: [
            CustomSectionHeader(
              label: context.tr("f_n_b_detail.menu"),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.fnbDetailMenuScreen,
                    arguments: [
                      "${ImageConstant.fnb3Path}/B/1.jpg",
                      "${ImageConstant.fnb3Path}/B/2.jpg",
                      "${ImageConstant.fnb3Path}/B/3.jpg",
                      "${ImageConstant.fnb3Path}/B/4.jpg",
                    ]);
              },
            ),
            Container(
              height: 150.h,
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              width: double.maxFinite,
              child: [
                "${ImageConstant.fnb3Path}/B/1.jpg",
                "${ImageConstant.fnb3Path}/B/2.jpg",
                "${ImageConstant.fnb3Path}/B/3.jpg",
                "${ImageConstant.fnb3Path}/B/4.jpg",
              ].isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: [
                        "${ImageConstant.fnb3Path}/B/1.jpg",
                        "${ImageConstant.fnb3Path}/B/2.jpg",
                        "${ImageConstant.fnb3Path}/B/3.jpg",
                        "${ImageConstant.fnb3Path}/B/4.jpg",
                      ].length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if ([
                          "${ImageConstant.fnb3Path}/B/1.jpg",
                          "${ImageConstant.fnb3Path}/B/2.jpg",
                          "${ImageConstant.fnb3Path}/B/3.jpg",
                          "${ImageConstant.fnb3Path}/B/4.jpg",
                        ].isNotEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.h, vertical: 8.h),
                            child: CustomImageView(
                              imagePath: [
                                "${ImageConstant.fnb3Path}/B/1.jpg",
                                "${ImageConstant.fnb3Path}/B/2.jpg",
                                "${ImageConstant.fnb3Path}/B/3.jpg",
                                "${ImageConstant.fnb3Path}/B/4.jpg",
                              ][index],
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
      ),
    );
  }

  Widget _fnbPlaceReviews(BuildContext context, FnbDetailModel fnbDetail) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b_detail.review"),
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
                    context.tr("f_n_b_detail.total_review", namedArgs: {
                      "total": fnbDetail.reviews == null
                          ? "0"
                          : fnbDetail.reviews!.length.toString(),
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
                              fnbDetail.rating.toString(),
                              style: CustomTextStyles(context).titleLarge_22,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              context.tr("f_n_b_detail.avg_rating"),
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
                                [0, 0, 0, 0, 1][index], fnbDetail);
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
      FnbDetailModel fnbDetail) {
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
