import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/datetime_utils.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_float_modal.dart';
import 'package:like_it/common/widget/custom_map_bottom_sheet.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/ui_model/promo_model.dart';

import 'package:like_it/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:like_it/places/fnb/model/fnb_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class FnbDetailScreen extends StatelessWidget {
  FnbDetailScreen({
    super.key,
    required this.placeId,
  });

  final GlobalKey _toolTipKey = GlobalKey();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  final String placeId;

  final List<Widget> imageSliders = [];

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

  Future showAndCloseTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final dynamic tooltip = _toolTipKey.currentState;
    tooltip?.ensureTooltipVisible();
    await Future.delayed(const Duration(seconds: 3));
    tooltip?.deactivate();
  }

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
    context.read<FnbDetailBloc>().add(FnbDetailFetched(placeId: placeId));
    return BlocConsumer<FnbDetailBloc, FnbDetailState>(
      listener: (context, state) {
        debugPrint('Le Rucco');
        if (state is FnbDetailSuccess) {
          debugPrint(state.fnbDetail.toString());
        }
        debugPrint(state.toString());
      },
      builder: (context, state) {
        if (state is FnbDetailSuccess) {
          bool hasCallSupport = true;
          showAndCloseTooltip();
          canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
            hasCallSupport = result;
          });
          imageSliders.addAll(List.generate(
            3,
            (index) {
              return CustomImageView(
                imagePath: Faker().image.loremPicsum(),
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
                child: _body(context, state.fnbDetail, hasCallSupport),
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
    FnbDetailModel fnbDetail,
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
                child: _fnbPlaceImages(context),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    _fnbAppBar(context),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.h, vertical: 10.h),
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
                              _fnbPlaceName(context, fnbDetail),
                              SizedBox(height: 5.h),
                              _fnbPlaceAbout(
                                  context, fnbDetail, hasCallSupport),
                              SizedBox(height: 5.h),
                              _fnbPromo(context),
                              SizedBox(height: 5.h),
                              _fnbPlaceMenu(context, fnbDetail),
                              SizedBox(height: 5.h),
                              _fnbPlaceReviews(context, fnbDetail),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  void _popUpMenuAction(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(
          context,
          AppRoutes.reportPlaceScreen,
          // arguments: fnbData, // TODO
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

  Widget _fnbPlaceName(BuildContext context, FnbDetailModel fnbDetail) {
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
                  fnbDetail.name,
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
                message: fnbDetail.businessStatus
                    ? context.tr("f_n_b_detail.place_claimed")
                    : context.tr("f_n_b_detail.place_not_claimed"),
                child: CustomImageView(
                  width: 20.h,
                  height: 20.h,
                  imagePath: fnbDetail.businessStatus
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

  Widget _fnbPlaceAbout(
      BuildContext context, FnbDetailModel fnbDetail, bool hasCallSupport) {
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
                trailingWidget: _aboutTag(context, fnbDetail),
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.timer,
                label: "",
                trailingWidget: _aboutOperationalTime(context, fnbDetail),
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.phone,
                label: fnbDetail.formattedPhoneNumber,
                onPressed: hasCallSupport
                    ? () => _launchContact(
                        fnbDetail.formattedPhoneNumber.replaceAll("-", ""))
                    : null,
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.place,
                label: fnbDetail.formattedAddress,
                maxLines: 4,
                onPressed: () {
                  customMapBottomSheet(
                    context,
                    fnbDetail.geometry.location.lat,
                    fnbDetail.geometry.location.lng,
                    fnbDetail.name,
                  );
                },
              ),
              SizedBox(height: 8.h),
              _buildAboutContent(
                context,
                icon: Icons.attach_money,
                label: "",
                trailingWidget: _aboutPrice(context, fnbDetail),
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

  Widget _aboutTag(BuildContext context, FnbDetailModel fnbDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        children: List<Widget>.generate(
          fnbDetail.types.length,
          (index) => _tagView(context, label: fnbDetail.types[index]),
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
            Text(
              context.tr("f_n_b_detail.about_open"),
              style: CustomTextStyles(context).bodyMedium_13,
            ),
            _operationalDayHourView(context,
                DatetimeUtils.getTodayOperationalTime(), true, fnbDetail),
          ],
        ),
        children: [0, 1, 2, 3, 4, 5, 6].map(
          (index) {
            return _operationalDayHourView(context, index, false, fnbDetail);
          },
        ).toList(),
      ),
    );
  }

  Widget _operationalDayHourView(
      BuildContext context, int index, bool isTitle, FnbDetailModel fnbDetail) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: isTitle ? 80.h : 120.h,
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
                  DatetimeUtils.getHour([
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
                  DatetimeUtils.getHour([
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

  Widget _fnbPromo(BuildContext context) {
    return Visibility(
      // visible: Random().nextBool(),
      visible: true,
      replacement: const SizedBox(),
      child: Container(
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
      ),
    );
  }

  Widget _eventListItems(BuildContext context, int index, PromoModel promo) {
    return GestureDetector(
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
            CustomDecoration(context).gradientYellowAToOnPrimary.copyWith(
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
      visible: Random().nextBool(),
      replacement: const SizedBox(),
      child: Container(
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
              Navigator.pushNamed(
                context,
                AppRoutes.reviewScreen,
                arguments: fnbDetail,
              );
            },
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.reviewScreen,
                  arguments: fnbDetail);
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
                      "total": fnbDetail.reviews.length.toString(),
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
