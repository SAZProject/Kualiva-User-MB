import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/utility/location_utility.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/common/widget/sliver_app_bar_delegate.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/ui_model/home_event_model.dart';
import 'package:like_it/data/model/ui_model/home_grid_menu_model.dart';
import 'package:like_it/data/model/util_model/user_curr_loc_model.dart';
import 'package:like_it/presentation/home/widget/home_featured_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _parentScrollController = ScrollController();
  final ScrollController _childScrollController = ScrollController();
  bool _locIsInitialized = false;
  // final List<LocDropdownModel> _dummyLoc = [
  //   LocDropdownModel(
  //     id: "0",
  //     subdistrict: "Tanah Abang",
  //     city: "Jakarta Pusat",
  //     latitude: "-6.186486",
  //     longitude: "106.834091",
  //   ),
  //   LocDropdownModel(
  //     id: "1",
  //     subdistrict: "Pondok Gede",
  //     city: "Bekasi",
  //     latitude: "-6.241586",
  //     longitude: "106.992416",
  //   ),
  // ];

  final List<HomeGridMenuModel> _homeGridMenu = [
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeFood, label: "home_screen.grid_1"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeHotel, label: "home_screen.grid_2"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeGroceries, label: "home_screen.grid_3"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeLounge, label: "home_screen.grid_4"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeSpa, label: "home_screen.grid_5"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeMall, label: "home_screen.grid_6"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeRecreation, label: "home_screen.grid_7"),
    HomeGridMenuModel(
        imageUrl: ImageConstant.homeBar, label: "home_screen.grid_8"),
  ];

  final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;

  final List<HomeEventModel> _homeEventList = [
    HomeEventModel(
      imagePath: ImageConstant.event1,
      eventTitle: "Peter Pan On Ice",
      eventDate:
          "14-15 December 2024, Planetary Hall Jakarta Convention Center",
      eventHost: "By KONSERKITA",
      eventDesc:
          '''The classic story of Peter Pan on ice will come back to Jakarta, Indonesia, the enchanting tale of adventure, imagination, and childhood nostalgia comes to life on ice for 6 Shows (3 shows each day) at Indonesia Arena, Senayan Jakarta.
The world-renowned International Ice Stars brings to your theatre a new adaptation of this famous fantasy adventure by J.M. Barrie. This event offers a unique and unforgettable entertainment option for families celebrating Idul Fitri, allowing them to witness the skillful performances of The International Ice Stars as they bring to life the timeless characters of Peter Pan, Wendy, Captain Hook, and more.

Syarat dan Ketentuan :
Tiket yang sudah dibeli tidak dapat dikembalikan.
Penukaran Tiket harus menunjukan identitas diri ( Ktp/ Sim/ Paspor) apabila diwakilkan atau nama tidak sesuai dengan yang tertera di e-tiket harus membawa surat kuasa yang ditandatangani oleh pembeli tiket.
Tiket hanya berlaku untuk 1 (satu) orang dan 1 (satu) kali pertunjukan. Penggunaannya harus sesuai dengan tanggal dan jam yang tertera pada Tiket.
Tiket yang hilang karena kelalaian pembeli/ pemegang tiket tidak dapat dicetak ulang.
Anak berusia 2 (dua) tahun ke atas, wajib memiliki tiket masuk di bawah usia 2 (dua) tahun free dengan catatan harus duduk di pangkuan orang tua atau walinya saat menonton pertunjukan.
Semua anak dibawah usia 12 tahun harus didampingi orang tua atau wali 18 tahun keatas.
Seat Number akan diberikan pada saat melakukan penukaran tiket khusus untuk kategori Super VIP dan VIP sedangkan kategori Gold dan Silver bersifat free seating.
Penyelenggara acara berhak melarang pengunjung untuk memasuki lokasi acara apabila pengunjung tidak memiliki tiket yang sah.''',
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

  final List<String> _adBannerList = [
    ImageConstant.event1,
    ImageConstant.foodSugarSpice,
    ImageConstant.event2,
    ImageConstant.foodTable8,
    ImageConstant.event3,
  ];

  late UserCurrLocModel getUserCurrentLoc;

  void _gridMenuAction(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.fnbScreen);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        controller: _parentScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _homeAppBar(context),
            _searchBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _adBanner(context),
              SizedBox(height: 5.h),
              _gridMenu(context),
              SizedBox(height: 5.h),
              _featured(context),
              SizedBox(height: 5.h),
              _eventList(context),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      automaticallyImplyLeading: false,
      pinned: false,
      snap: false,
      floating: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("common.current_location"),
            style: CustomTextStyles(context).titleLargeOnPrimaryContainer,
          ),
          _currentUserLocation(context),
        ],
      ),
      toolbarHeight: 100.h,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.qr_code_scanner,
            size: 30.h,
            color: appTheme.black900,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            size: 30.h,
            color: appTheme.black900,
          ),
        ),
      ],
    );
  }

  Widget _currentUserLocation(BuildContext context) {
    return FutureBuilder<UserCurrLocModel>(
      future: Future<UserCurrLocModel>(
        () async {
          if (!context.mounted) return Future.error("No context mounted");
          if (_locIsInitialized == false) {
            if (await LocationUtility.checkPermission(context)) {
              try {
                final res = await LocationUtility.getUserCurrLoc();
                setState(() {
                  getUserCurrentLoc = res;
                  _locIsInitialized = true;
                });
              } catch (e) {
                return Future.error(e);
              }
            } else {
              return Future.error("No Connection or error on locator");
            }
          }
          return getUserCurrentLoc;
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildUserLoc(context, context.tr("common.error"));
        }
        if (snapshot.hasData) {
          return _buildUserLoc(context,
              "${getUserCurrentLoc.userCurrSubDistrict}, ${getUserCurrentLoc.userCurrCity}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildUserLoc(BuildContext context, String label) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.locationScreen);
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.h,
        maxHeight: 60.h,
        child: Padding(
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
        ),
      ),
    );
  }

  Widget _adBanner(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: SizedBox(
        height: 200.h,
        width: double.maxFinite,
        child: _adBannerList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _childScrollController,
                itemCount: _adBannerList.length,
                itemBuilder: (context, index) {
                  if (_adBannerList.isNotEmpty) {
                    return _adBannerListItem(context, _adBannerList[index]);
                  }
                  return const CustomEmptyState();
                },
              ),
      ),
    );
  }

  Widget _adBannerListItem(BuildContext context, String imgUrl) {
    return Container(
      height: 180.h,
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
        child: CustomImageView(
          imagePath: imgUrl,
          height: 180.h,
          width: 320.h,
          radius: BorderRadiusStyle.roundedBorder10,
        ),
      ),
    );
  }

  Widget _gridMenu(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 8.h),
      decoration:
          CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder14,
              ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 91.h,
              crossAxisCount: 4,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              return _gridMenuItem(context, index, _homeGridMenu[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _gridMenuItem(
      BuildContext context, int index, HomeGridMenuModel gridMenu) {
    return InkWell(
      borderRadius: BorderRadiusStyle.roundedBorder10,
      onTap: index == 0 ? () => _gridMenuAction(index) : null,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration:
            CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder10,
                ),
        foregroundDecoration:
            index == 0 ? null : CustomDecoration(context).foregroundBlur,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.h),
            index == 7
                ? Center(
                    child: Icon(Icons.add, size: 60.h),
                  )
                : CustomImageView(
                    imagePath: gridMenu.imageUrl,
                    height: 60.h,
                    width: double.maxFinite,
                  ),
            SizedBox(height: 6.h),
            Text(
              context.tr(gridMenu.label),
              style: CustomTextStyles(context).bodySmall12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _featured(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("home_screen.featured"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 200.h,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  //TODO add waiting, empty, error state in future
                  return HomeFeaturedItem(
                    fnbModel: featuredListItems[index],
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.fnbDetailScreen,
                          arguments: featuredListItems[index]);
                    },
                  );
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
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSectionHeader(
              label: context.tr("home_screen.event", args: ["Jakarta"]),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.homeEventScreen);
              },
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
                          if (_homeEventList.isNotEmpty) {
                            return _eventListItems(
                                context, index, _homeEventList[index]);
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
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        homeEventModel.eventTitle,
                        style: theme(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        homeEventModel.eventDesc,
                        style: CustomTextStyles(context).bodySmall12,
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
