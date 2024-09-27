import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/dataset/f_n_b_filter_dataset.dart';
import 'package:like_it/common/utility/location_utility.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/common/widget/sliver_app_bar_delegate.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/ui_model/filters_model.dart';
import 'package:like_it/data/model/util_model/user_curr_loc_model.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_filters_item.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_place_item.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_promo_item.dart';

class FNBScreen extends StatefulWidget {
  const FNBScreen({super.key});

  @override
  State<FNBScreen> createState() => _FNBScreenState();
}

class _FNBScreenState extends State<FNBScreen> {
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

  final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;

  final List<String> _listTagsFilter = FNBFilterDataset.fnbFilter;

  ValueNotifier<Set<String>> selectedFilters = ValueNotifier<Set<String>>({});
  late FiltersModel filtersModel;

  final List<String> _dummyImageData = [
    "${ImageConstant.fnb1Path}/A/2.jpg",
    "${ImageConstant.fnb2Path}/A/2.jpg",
    "${ImageConstant.fnb3Path}/A/2.jpg",
    "${ImageConstant.fnb4Path}/A/2.jpg",
    "${ImageConstant.fnb5Path}/A/2.jpg",
  ];

  late UserCurrLocModel getUserCurrentLoc;

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    selectedFilters.dispose();
    super.dispose();
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
              _tagsFilter(context),
              SizedBox(height: 5.h),
              _nearestList(context),
              SizedBox(height: 5.h),
              _promoList(context),
              SizedBox(height: 5.h),
              _cuisine(context),
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
      automaticallyImplyLeading: true,
      pinned: false,
      snap: false,
      floating: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
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
      onTap: () {},
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

  Widget _tagsFilter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: SizedBox(
        height: 30.h,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: _listTagsFilter.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //TODO add waiting, empty, error state in future
            if (index == 0) return _filterScreenBtn(context, index, label: "");
            return FNBFiltersItem(
              label: _listTagsFilter[index - 1],
              isWrap: false,
              multiSelect: true,
              multiSelectedChoices: selectedFilters,
            );
          },
        ),
      ),
    );
  }

  Widget _filterScreenBtn(BuildContext context, int index, {String? label}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.h),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.fnbFilterScreen).then(
          (value) {
            setState(() {
              filtersModel = value as FiltersModel;
            });
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration: CustomDecoration(context).fillPrimary.copyWith(
              borderRadius: BorderRadius.circular(50.h),
            ),
        child: Center(
          child: Center(
            child: Icon(
              Icons.filter_alt,
              size: 20.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nearestList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.nearest"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 450.h,
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
              child: ListView.builder(
                controller: _childScrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  //TODO add waiting, empty, error state in future
                  return FNBPlaceItem(
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

  Widget _promoList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.promo"),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.locationScreen);
            },
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 200.h,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                //TODO add waiting, empty, error state in future
                return FNBPromoItem(
                  fnbModel: featuredListItems[index],
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.fnbDetailScreen,
                        arguments: featuredListItems[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cuisine(BuildContext context) {
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
            label: context.tr("f_n_b.cuisine"),
            onPressed: () {},
          ),
          Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: _dummyImageData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of items in each row
                    ),
                    itemCount: _dummyImageData.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (_dummyImageData.isNotEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 8.h),
                          child: CustomImageView(
                            imagePath: _dummyImageData[index],
                            height: 120.h,
                            width: 100.h,
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
    );
  }
}
