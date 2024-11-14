import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:like_it/common/style/custom_decoration.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/sized_utils.dart';
import 'package:like_it/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:like_it/router.dart';

class FnbDetailScreen extends StatelessWidget {
  FnbDetailScreen({
    super.key,
    required this.placeId,
  });

  final String placeId;

  final List<Widget> imageSliders = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FnbDetailBloc, FnbDetailState>(
      listener: (context, state) {
        debugPrint('Le Rucco');
        if (state is FnbDetailSuccess) {
          debugPrint(state.fnbDetail.toString());
        }
        debugPrint(state.toString());
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: SizedBox(
              width: double.maxFinite,
              height: Sizeutils.height,
              child: _body(context),
            ),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
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
                              // _fnbPlaceName(context),
                              // SizedBox(height: 5.h),
                              // _fnbPlaceAbout(context),
                              // SizedBox(height: 5.h),
                              // _fnbPromo(context),
                              // SizedBox(height: 5.h),
                              // _fnbPlaceMenu(context),
                              // SizedBox(height: 5.h),
                              // _fnbPlaceReviews(context),
                              // SizedBox(height: 10.h),
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
}
