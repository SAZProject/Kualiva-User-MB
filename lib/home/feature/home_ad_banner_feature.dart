import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/common/style/custom_decoration.dart';
import 'package:like_it/common/utility/sized_utils.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_image_view.dart';
import 'package:like_it/home/bloc/home_ad_banner_bloc.dart';
import 'package:like_it/home/model/home_ad_banner_model.dart';
import 'package:like_it/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:like_it/router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeAdBannerFeature extends StatelessWidget {
  const HomeAdBannerFeature({
    super.key,
    required this.childScrollController,
  });

  final ScrollController childScrollController;

  /// TODO Rucci buat LauncherUtil
  /// Web
  /// Gmail / microsoft outlook
  /// Telpon
  /// SMS
  /// Open folder
  Future<void> _launchWeb(String url) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: url,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: SizedBox(
        height: 200.h,
        width: double.maxFinite,
        child: _list(),
      ),
    );
  }

  Widget _list() {
    return BlocBuilder<HomeAdBannerBloc, HomeAdBannerState>(
      builder: (context, state) {
        if (state is HomeAdBannerFailure) {
          /// TODO Winky
          return Text('Error Maszeh');
        }
        if (state is! HomeAdBannerSuccess) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: childScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: state.adBanners.length,
          itemBuilder: (context, index) {
            if (state.adBanners.isEmpty) {
              return CustomEmptyState();
            }
            return _adBannerListItem(context, state.adBanners[index]);
          },
        );
      },
    );
  }

  Widget _adBannerListItem(
    BuildContext context,
    HomeAdBannerModel adBanner,
  ) {
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
        onTap: () {
          if (adBanner.placeId == null && adBanner.urlWeb == null) return;

          if (adBanner.placeId != null) {
            context.read<FnbDetailBloc>().add(FnbDetailFetched(
                  placeId: adBanner.placeId!,
                ));
            Navigator.pushNamed(
              context,
              AppRoutes.fnbDetailScreen,
              arguments: adBanner.placeId!,
            );
            return;
          }

          if (adBanner.urlWeb != null) {
            _launchWeb(adBanner.urlWeb!);
            return;
          }
        },
        child: CustomImageView(
          imagePath: adBanner.urlImage,
          height: 180.h,
          width: 320.h,
          radius: BorderRadiusStyle.roundedBorder10,
        ),
      ),
    );
  }
}
