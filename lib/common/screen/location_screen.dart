import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/screen/widget/location_popular_city_items.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/ui_model/loc_full_address_model.dart';
import 'package:like_it/data/model/ui_model/loc_popular_city_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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

  List<LocFullAddressModel> listRecentLoc = [
    LocFullAddressModel(
      placeName: "Park Royale Executive Suites",
      addressDetail:
          "Jl. Gatot Subroto No.Kav. 35-39, RT.9/RW.2, Bend. Hilir, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10210",
      latitude: -6.212788577345902,
      longitude: 106.80943878888415,
    ),
  ];
  List<LocFullAddressModel> listNearbyLoc = [
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
      initialText: context.tr("location.current_loc_btn"),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () {},
    );
  }

  Widget _popularCity(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("location.popular_city"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 150.h,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listPopularCity.isEmpty ? 1 : listPopularCity.length,
              itemBuilder: (context, index) {
                if (listPopularCity.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return LocationPopularCityItems(
                  locPopularCityModel: listPopularCity[index],
                  onPressed: () {},
                );
              },
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
            label: context.tr("location.recent_location"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 150.h,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (context, index) {
                if (index < listRecentLoc.length) {
                  return _buildAddressItems(
                    context,
                    leadingIcon: Icons.repeat,
                    title: listRecentLoc[index].placeName,
                    content: listRecentLoc[index].addressDetail,
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
            label: context.tr("location.nearby_landmark"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 150.h,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (context, index) {
                if (index < listNearbyLoc.length) {
                  return _buildAddressItems(
                    context,
                    leadingIcon: Icons.repeat,
                    title: listNearbyLoc[index].placeName,
                    content: listNearbyLoc[index].addressDetail,
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
                      title,
                      style: CustomTextStyles(context).bodySmall12,
                      maxLines: maxLinesContent,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
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
