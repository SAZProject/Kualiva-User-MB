import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/screen/widget/location_popular_city_items.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/ui_model/home_event_model.dart';
import 'package:like_it/data/model/ui_model/loc_popular_city_model.dart';
import 'package:like_it/app_routes.dart';

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

  final List<HomeEventModel> _homeEventList = [
    HomeEventModel(
      imagePath: ImageConstant.event1,
      eventTitle: "Peter Pan On Ice",
      eventDate:
          "14-15 December 2024, Planetary Hall Jakarta Convention Center",
      eventHost: "By KONSERKITA",
      eventDesc:
          ''' The classic story of Peter Pan on ice will come back to Jakarta, Indonesia, the enchanting tale of adventure, imagination, and childhood nostalgia comes to life on ice for 6 Shows (3 shows each day) at Indonesia Arena, Senayan Jakarta.
The world-renowned International Ice Stars brings to your theatre a new adaptation of this famous fantasy adventure by J.M. Barrie. This event offers a unique and unforgettable entertainment option for families celebrating Idul Fitri, allowing them to witness the skillful performances of The International Ice Stars as they bring to life the timeless characters of Peter Pan, Wendy, Captain Hook, and more.

Syarat dan Ketentuan :
- Tiket yang sudah dibeli tidak dapat dikembalikan.
- Penukaran Tiket harus menunjukan identitas diri ( Ktp/ Sim/ Paspor) apabila diwakilkan atau nama tidak sesuai dengan yang tertera di e-tiket harus membawa surat kuasa yang ditandatangani oleh pembeli tiket.
- Tiket hanya berlaku untuk 1 (satu) orang dan 1 (satu) kali pertunjukan. Penggunaannya harus sesuai dengan tanggal dan jam yang tertera pada Tiket.
- Tiket yang hilang karena kelalaian pembeli/ pemegang tiket tidak dapat dicetak ulang.
- Anak berusia 2 (dua) tahun ke atas, wajib memiliki tiket masuk di bawah usia 2 (dua) tahun free dengan catatan harus duduk di pangkuan orang tua atau walinya saat menonton pertunjukan.
- Semua anak dibawah usia 12 tahun harus didampingi orang tua atau wali 18 tahun keatas.
- Seat Number akan diberikan pada saat melakukan penukaran tiket khusus untuk kategori Super VIP dan VIP sedangkan kategori Gold dan Silver bersifat free seating.
- Penyelenggara acara berhak melarang pengunjung untuk memasuki lokasi acara apabila pengunjung tidak memiliki tiket yang sah.''',
    ),
    HomeEventModel(
      imagePath: ImageConstant.event2,
      eventTitle: "Event Title",
      eventDate: "Date(dd/mm/yyyy), Place",
      eventHost: "By Dummy",
      eventDesc: "Event Desc",
    ),
    HomeEventModel(
      imagePath: ImageConstant.event3,
      eventTitle: "Event Title",
      eventDate: "Date(dd/mm/yyyy), Place",
      eventHost: "By Dummy",
      eventDesc: "Event Desc",
    ),
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
      child: Scaffold(
        appBar: _homeEventAppBar(context),
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
            _eventList(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _homeEventAppBar(BuildContext context) {
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
          context.tr("event.title"),
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
        initialText: context.tr("event.current_loc_btn"),
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
            label: context.tr("event.popular_city"),
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

  Widget _eventList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSectionHeader(
            useIcon: false,
            label: context.tr("event.event"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
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
                                context, index, _homeEventList[index]);
                          }
                          return const CustomEmptyState();
                        },
                      ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _eventListItems(
      BuildContext context, int index, HomeEventModel homeEventModel) {
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
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.homeEventDetailScreen,
              arguments: homeEventModel);
        },
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
                        homeEventModel.eventDate,
                        style: CustomTextStyles(context).bodySmall10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        homeEventModel.eventTitle,
                        style: theme(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        homeEventModel.eventDesc,
                        style: CustomTextStyles(context).bodySmall12,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.h),
              CustomImageView(
                imagePath: homeEventModel.imagePath,
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
