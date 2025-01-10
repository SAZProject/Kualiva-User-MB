import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/home/bloc/home_ad_banner_bloc.dart';
import 'package:kualiva/home/bloc/home_featured_bloc.dart';
import 'package:kualiva/home/feature/home_ad_banner_feature.dart';
import 'package:kualiva/home/feature/home_app_bar_feature.dart';
import 'package:kualiva/home/feature/home_featured_feature.dart';
import 'package:kualiva/home/feature/home_search_bar_feature.dart';
import 'package:kualiva/home/model/home_grid_menu_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _parentScrollController = ScrollController();
  final _childScrollController = ScrollController();

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

//   final List<HomeEventModel> _homeEventList = [
//     HomeEventModel(
//       imagePath: ImageConstant.event1,
//       eventTitle: "Peter Pan On Ice",
//       eventDate:
//           "14-15 December 2024, Planetary Hall Jakarta Convention Center",
//       eventHost: "By KONSERKITA",
//       eventDesc:
//           ''' The classic story of Peter Pan on ice will come back to Jakarta, Indonesia, the enchanting tale of adventure, imagination, and childhood nostalgia comes to life on ice for 6 Shows (3 shows each day) at Indonesia Arena, Senayan Jakarta.
// The world-renowned International Ice Stars brings to your theatre a new adaptation of this famous fantasy adventure by J.M. Barrie. This event offers a unique and unforgettable entertainment option for families celebrating Idul Fitri, allowing them to witness the skillful performances of The International Ice Stars as they bring to life the timeless characters of Peter Pan, Wendy, Captain Hook, and more.

// Syarat dan Ketentuan :
// - Tiket yang sudah dibeli tidak dapat dikembalikan.
// - Penukaran Tiket harus menunjukan identitas diri ( Ktp/ Sim/ Paspor) apabila diwakilkan atau nama tidak sesuai dengan yang tertera di e-tiket harus membawa surat kuasa yang ditandatangani oleh pembeli tiket.
// - Tiket hanya berlaku untuk 1 (satu) orang dan 1 (satu) kali pertunjukan. Penggunaannya harus sesuai dengan tanggal dan jam yang tertera pada Tiket.
// - Tiket yang hilang karena kelalaian pembeli/ pemegang tiket tidak dapat dicetak ulang.
// - Anak berusia 2 (dua) tahun ke atas, wajib memiliki tiket masuk di bawah usia 2 (dua) tahun free dengan catatan harus duduk di pangkuan orang tua atau walinya saat menonton pertunjukan.
// - Semua anak dibawah usia 12 tahun harus didampingi orang tua atau wali 18 tahun keatas.
// - Seat Number akan diberikan pada saat melakukan penukaran tiket khusus untuk kategori Super VIP dan VIP sedangkan kategori Gold dan Silver bersifat free seating.
// - Penyelenggara acara berhak melarang pengunjung untuk memasuki lokasi acara apabila pengunjung tidak memiliki tiket yang sah.''',
//     ),
//     HomeEventModel(
//       imagePath: ImageConstant.event2,
//       eventTitle: "Event Title",
//       eventDate: "Date(dd/mm/yyyy), Place",
//       eventHost: "By Dummy",
//       eventDesc: "Event Desc",
//     ),
//     HomeEventModel(
//       imagePath: ImageConstant.event3,
//       eventTitle: "Event Title",
//       eventDate: "Date(dd/mm/yyyy), Place",
//       eventHost: "By Dummy",
//       eventDesc: "Event Desc",
//     ),
//   ];

  void _gridMenuAction(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.fnbScreen);
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.hostelryScreen);
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeAdBannerBloc>().add(HomeAdBannerFetched());
    context.read<HomeFeaturedBloc>().add(HomeFeaturedFetched());
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
            HomeAppBarFeature(),
            HomeSearchBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              HomeAdBannerFeature(
                childScrollController: _childScrollController,
              ),
              SizedBox(height: 5.h),
              _gridMenu(context),
              SizedBox(height: 5.h),
              HomeFeaturedFeature(),
              // TODO hide it for V1 version
              // SizedBox(height: 5.h),
              // _eventList(context),
              SizedBox(height: 50.h),
            ],
          ),
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
      onTap: index == 0 || index == 1 ? () => _gridMenuAction(index) : null,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration:
            CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder10,
                ),
        foregroundDecoration: index == 0 || index == 1
            ? null
            : CustomDecoration(context).foregroundBlur,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _eventList(BuildContext context) {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: Container(
  //       width: double.maxFinite,
  //       margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h),
  //       padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 14.h),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           CustomSectionHeader(
  //             label: context.tr("home_screen.event", args: ["Jakarta"]),
  //             onPressed: () {
  //               Navigator.pushNamed(context, AppRoutes.homeEventScreen);
  //             },
  //           ),
  //           SizedBox(height: 4.h),
  //           SizedBox(
  //             width: double.maxFinite,
  //             child: NotificationListener(
  //               onNotification: (ScrollNotification notification) {
  //                 if (notification is ScrollUpdateNotification) {
  //                   if (notification.metrics.pixels ==
  //                       notification.metrics.maxScrollExtent) {
  //                     _parentScrollController.animateTo(
  //                         _parentScrollController.position.maxScrollExtent,
  //                         duration: const Duration(seconds: 1),
  //                         curve: Curves.easeIn);
  //                   } else if (notification.metrics.pixels ==
  //                       notification.metrics.minScrollExtent) {
  //                     _parentScrollController.animateTo(
  //                         _parentScrollController.position.minScrollExtent,
  //                         duration: const Duration(seconds: 1),
  //                         curve: Curves.easeIn);
  //                   }
  //                 }
  //                 return true;
  //               },
  //               child: _homeEventList.isEmpty
  //                   ? const Center(child: CircularProgressIndicator())
  //                   : ListView.builder(
  //                       controller: _childScrollController,
  //                       itemCount: _homeEventList.length,
  //                       shrinkWrap: true,
  //                       itemBuilder: (context, index) {
  //                         if (_homeEventList.isNotEmpty) {
  //                           return _eventListItems(
  //                               context, index, _homeEventList[index]);
  //                         }
  //                         return const CustomEmptyState();
  //                       },
  //                     ),
  //             ),
  //           ),
  //           SizedBox(height: 4.h),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _eventListItems(
  //     BuildContext context, int index, HomeEventModel homeEventModel) {
  //   return Container(
  //     height: 120.h,
  //     margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 4.h),
  //     padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 4.h),
  //     decoration:
  //         CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
  //               borderRadius: BorderRadiusStyle.roundedBorder10,
  //             ),
  //     clipBehavior: Clip.antiAlias,
  //     child: InkWell(
  //       borderRadius: BorderRadiusStyle.roundedBorder10,
  //       onTap: () {
  //         Navigator.pushNamed(context, AppRoutes.homeEventDetailScreen,
  //             arguments: homeEventModel);
  //       },
  //       child: BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 3.h, sigmaY: 3.h),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       homeEventModel.eventDate,
  //                       style: CustomTextStyles(context).bodySmall10,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     SizedBox(height: 4.h),
  //                     Text(
  //                       homeEventModel.eventTitle,
  //                       style: theme(context).textTheme.titleMedium,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     SizedBox(height: 4.h),
  //                     Text(
  //                       homeEventModel.eventDesc,
  //                       style: CustomTextStyles(context).bodySmall12,
  //                       maxLines: 3,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 10.h),
  //             CustomImageView(
  //               imagePath: homeEventModel.imagePath,
  //               height: double.maxFinite,
  //               width: 100.h,
  //               radius: BorderRadiusStyle.roundedBorder10,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
