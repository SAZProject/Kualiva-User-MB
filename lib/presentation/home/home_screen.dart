import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/widget/custom_location_dropdown.dart';
import 'package:like_it/common/widget/sliver_app_bar_delegate.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/ui_model/home_grid_menu_model.dart';
import 'package:like_it/data/model/ui_model/loc_dropdown_model.dart';
import 'package:like_it/presentation/home/widget/home_featured_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<LocDropdownModel> _dummyLoc = [
    LocDropdownModel(id: "0", subdistrict: "Tanah Abang", city: "Bekasi"),
    LocDropdownModel(
        id: "1", subdistrict: "Pondok Gede", city: "Jakarta Pusat"),
  ];

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

  final List<String> _homeEventList = [
    ImageConstant.event1,
    ImageConstant.event2,
    ImageConstant.event3,
  ];

  final List<DropdownMenuItem<LocDropdownModel>> _locationsItem = [];

  LocDropdownModel? _selectedLocation;

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
              _userLevel(context),
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
            context.tr("home_screen.location"),
            style: CustomTextStyles(context).titleLargeBlack900W400_22,
          ),
          _locationFilterDropdown(context),
        ],
      ),
      toolbarHeight: 100.h,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.qr_code_scanner,
            size: 30.0,
            color: appTheme.black900,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            size: 30.0,
            color: appTheme.black900,
          ),
        ),
      ],
    );
  }

  Widget _locationFilterDropdown(BuildContext context) {
    return FutureBuilder<List<DropdownMenuItem<LocDropdownModel>>>(
      future: Future<List<DropdownMenuItem<LocDropdownModel>>>(
        () {
          _locationsItem.clear();
          _locationsItem.addAll(_dummyLoc.map(
            (locationModel) {
              return dataDropdownItem(context, locationModel,
                  "${locationModel.subdistrict}, ${locationModel.city}");
            },
          ));
          return _locationsItem;
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorDropdownItem(context);
        }
        if (snapshot.hasData) {
          return filterDropdownButton(
            context,
            _selectedLocation,
            _locationsItem,
            (value) {
              setState(() {
                _selectedLocation = value;
              });
            },
          );
        }
        return loadingDropdownItem(context);
      },
    );
  }

  Widget _searchBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                focusNode: FocusNode(),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
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

  Widget _userLevel(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 6.h,
      ),
      decoration:
          CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder14,
              ),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              minRadius: 25.h,
              maxRadius: 25.h,
              child: Center(
                child: Icon(Icons.person, size: 50.h),
              ),
            ),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bronze",
                          style: theme(context).textTheme.bodyLarge,
                        ),
                        Icon(Icons.arrow_forward_ios, size: 30.h)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Level 0",
                              style: theme(context).textTheme.bodySmall,
                            ),
                            LinearProgressIndicator(
                              value: 0.6,
                              color: theme(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.8),
                              backgroundColor:
                                  theme(context).colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "0/10",
                        style: theme(context).textTheme.bodySmall,
                      ),
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
      onTap: index == 0 ? () {} : null,
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
                ? const Center(
                    child: Icon(Icons.add, size: 60.0),
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 14.h),
            width: double.maxFinite,
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr("home_screen.featured"),
                    style: theme(context).textTheme.titleLarge!.copyWith(
                        color: theme(context).colorScheme.onPrimaryContainer),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 30.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            height: 175.h,
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(width: 14.h);
              },
              itemCount: 6,
              itemBuilder: (context, index) {
                return HomeFeaturedItem(
                  fnbModel: featuredListItems[index],
                  onPressed: () {},
                );
              },
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
            SizedBox(
              width: double.maxFinite,
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr("home_screen.event", args: ["Jakarta"]),
                      style: theme(context).textTheme.titleLarge!.copyWith(
                          color: theme(context).colorScheme.onPrimaryContainer),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 30.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: _homeEventList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _eventListItems(context, _homeEventList[index]);
                },
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
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
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
