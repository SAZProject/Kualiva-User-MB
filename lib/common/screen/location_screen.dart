import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/screen/widget/location_popular_city_items.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/_data/model/ui_model/loc_full_address_model.dart';
import 'package:kualiva/_data/model/ui_model/loc_popular_city_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<LocPopularCityModel> listPopularCity = [];
  final List<String> _cityNames = [
    "Jakarta",
    "Yogyakarta",
    "Bali",
    "Banda Aceh",
    "Bandung"
  ];
  final List<double> _latCoord = [
    -6.200000,
    -7.797068,
    -8.650000,
    5.548290,
    -6.914864,
  ];
  final List<double> _longCoord = [
    106.816666,
    110.370529,
    115.216667,
    95.323753,
    107.608238,
  ];

  final List<LocFullAddressModel> _listRecentLoc = [
    LocFullAddressModel(
      placeName: "Park Royale Executive Suites",
      addressDetail:
          "Jl. Gatot Subroto No.Kav. 35-39, RT.9/RW.2, Bend. Hilir, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10210",
      latitude: -6.212788577345902,
      longitude: 106.80943878888415,
    ),
  ];

  final List<LocFullAddressModel> _listNearbyLoc = [
    LocFullAddressModel(
      placeName: "Jakarta Convention Center",
      addressDetail:
          "Jl. Gatot Subroto No.1, RT.1/RW.3, Gelora, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10270",
      latitude: -6.214119994408115,
      longitude: 106.80715476007873,
    ),
    LocFullAddressModel(
      placeName: "Plaza Semanggi",
      addressDetail:
          "Kawasan Bisnis Granadha, Jl. Jend. Sudirman No.Kav.50, RT.1/RW.4, Karet Semanggi, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12930",
      latitude: -6.219495528551825,
      longitude: 106.81443963975221,
    ),
    LocFullAddressModel(
      placeName: "Pacific Place Mall",
      addressDetail:
          "Jl. Jend. Sudirman kav 52-53, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190",
      latitude: -6.224172863811721,
      longitude: 106.8102377975414,
    ),
  ];

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
          cityName: _cityNames[index],
          latitude: _latCoord[index],
          longitude: _longCoord[index],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _locationAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          // decoration: BoxDecoration(
          //   color: theme(context)
          //       .colorScheme
          //       .onSecondaryContainer
          //       .withOpacity(0.6),
          //   image: DecorationImage(
          //     image: AssetImage(ImageConstant.background2),
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
        child: Column(
          children: [
            SizedBox(height: 5.h),
            _searchBar(context),
            SizedBox(height: 5.h),
            _userCurrLocBtn(context),
            SizedBox(height: 5.h),
            _popularCity(context),
            SizedBox(height: 5.h),
            _recentLoc(context),
            SizedBox(height: 5.h),
            _nearbyLoc(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _locationAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("location.title"),
          style: theme(context).textTheme.headlineSmall,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: CustomElevatedButton(
        initialText: context.tr("location.current_loc_btn"),
        buttonStyle: CustomButtonStyles.none,
        decoration:
            CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
        buttonTextStyle:
            CustomTextStyles(context).titleMediumOnPrimaryContainer,
        onPressed: () {},
      ),
    );
  }

  Widget _popularCity(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            useIcon: false,
            label: context.tr("location.popular_city"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 150.h,
              width: double.maxFinite,
              child: listPopularCity.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          listPopularCity.isEmpty ? 1 : listPopularCity.length,
                      itemBuilder: (context, index) {
                        if (listPopularCity.isNotEmpty) {
                          return LocationPopularCityItems(
                            locPopularCityModel: listPopularCity[index],
                            onPressed: () {},
                          );
                        }
                        return const CustomEmptyState();
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentLoc(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            useIcon: false,
            label: context.tr("location.recent_location"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  //TODO add waiting, empty, error state in future
                  if (index < _listRecentLoc.length) {
                    return _buildAddressItems(
                      context,
                      leadingIcon: Icons.repeat,
                      title: _listRecentLoc[index].placeName,
                      content: _listRecentLoc[index].addressDetail,
                    );
                  }
                  return _buildAddressItems(
                    context,
                    leadingIcon: Icons.repeat,
                    title: context.tr("location.content_title_hint"),
                    content: context.tr("location.content_detail_hint"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nearbyLoc(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            useIcon: false,
            label: context.tr("location.nearby_landmark"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  //TODO add waiting, empty, error state in future
                  if (index < _listNearbyLoc.length) {
                    return _buildAddressItems(
                      context,
                      leadingIcon: Icons.place,
                      title: _listNearbyLoc[index].placeName,
                      content: _listNearbyLoc[index].addressDetail,
                    );
                  }
                  return _buildAddressItems(
                    context,
                    leadingIcon: Icons.place,
                    title: context.tr("location.content_title_hint"),
                    content: context.tr("location.content_detail_hint"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItems(
    BuildContext context, {
    required IconData leadingIcon,
    required String title,
    required String content,
    int maxLinesTitle = 1,
    int maxLinesContent = 3,
    void Function()? onPressed,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(leadingIcon, size: 30.h),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CustomTextStyles(context)
                          .bodySmall12
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: maxLinesTitle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      content,
                      style: CustomTextStyles(context).bodySmall12,
                      maxLines: maxLinesContent,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
