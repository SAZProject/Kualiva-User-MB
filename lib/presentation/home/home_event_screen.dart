import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/ui_model/loc_popular_city_model.dart';

class WhatGoingOnScreen extends StatefulWidget {
  const WhatGoingOnScreen({super.key});

  @override
  State<WhatGoingOnScreen> createState() => _WhatGoingOnScreenState();
}

class _WhatGoingOnScreenState extends State<WhatGoingOnScreen> {
  final ScrollController _parentScrollController = ScrollController();
  final ScrollController _childScrollController = ScrollController();

  List<LocPopularCityModel> listPopularCity = [];
  List<String> cityNames = [
    "Jakarta",
    "Yogyakarta",
    "Bali",
    "Banda Aceh",
    "Bandung"
  ];
  List<double> latCoord = [
    -6.200000,
    -7.797068,
    -8.650000,
    5.548290,
    -6.914864,
  ];
  List<double> longCoord = [
    106.816666,
    110.370529,
    115.216667,
    95.323753,
    107.608238,
  ];

  final List<String> _homeEventList = [
    ImageConstant.event1,
    ImageConstant.event2,
    ImageConstant.event3,
  ];

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    List.generate(
      5,
      (index) {
        Faker faker = Faker();
        Random rng = Random();
        listPopularCity.add(LocPopularCityModel(
          cityImagePath: faker.image.loremPicsum(random: rng.nextInt(300)),
          cityName: cityNames[index],
          latitude: latCoord[index],
          longitude: longCoord[index],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: theme(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(ImageConstant.background2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: _body(context),
          ),
        ],
      ),
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
            _searchBar(context),
            SizedBox(height: 5.h),
            _userCurrLocBtn(context),
            SizedBox(height: 5.h),
            _eventList(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            focusNode: FocusNode(),
            padding: WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.h)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            onSubmitted: (value) {
              setState(() {
                controller.closeView(value);
              });
            },
            onTapOutside: (event) {
              FocusScopeNode focusNode = FocusScope.of(context);
              if (focusNode.hasPrimaryFocus) {
                focusNode.unfocus();
              }
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _userCurrLocBtn(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("event.current_loc_btn"),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () {},
    );
  }

  Widget _eventList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSectionHeader(
              label: context.tr("event.event"),
              onPressed: () {},
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: double.maxFinite,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      debugPrint('Reached the bottom');
                      _parentScrollController.animateTo(
                          _parentScrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    } else if (notification.metrics.pixels ==
                        notification.metrics.minScrollExtent) {
                      debugPrint('Reached the top');
                      _parentScrollController.animateTo(
                          _parentScrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    }
                  }
                  return true;
                },
                child: _homeEventList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: _childScrollController,
                        itemCount: _homeEventList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (listPopularCity.isNotEmpty) {
                            return _eventListItems(
                                context, _homeEventList[index]);
                          }
                          return const CustomEmptyState();
                        },
                      ),
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _eventListItems(BuildContext context, String imgUrl) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 4.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: () {},
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.h, sigmaY: 3.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "(Date Today/Yesterday/DD-MM-YYYy)",
                        style: CustomTextStyles(context).bodySmall10,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Title",
                        style: theme(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Description",
                        style: CustomTextStyles(context).bodySmall12,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.h),
              CustomImageView(
                imagePath: imgUrl,
                height: double.maxFinite,
                width: 100.h,
                radius: BorderRadiusStyle.roundedBorder10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
