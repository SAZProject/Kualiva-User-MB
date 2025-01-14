import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/utility/location_util.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/_data/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/_data/feature/current_location/current_location_feature.dart';

class HomeAppBarFeature extends StatefulWidget {
  const HomeAppBarFeature({
    super.key,
    this.automaticallyImplyLeading = false,
  });

  final bool automaticallyImplyLeading;

  @override
  State<HomeAppBarFeature> createState() => _HomeAppBarFeatureState();
}

class _HomeAppBarFeatureState extends State<HomeAppBarFeature> {
  @override
  void initState() {
    super.initState();
    _checkPermissionLocation();
  }

  void _checkPermissionLocation() async {
    if (!await LocationUtil.checkPermission(context)) {
      if (!mounted) return;
      context.read<CurrentLocationBloc>().add(CurrentLocationNoPermission());
    }
    if (!mounted) return;
    context.read<CurrentLocationBloc>().add(CurrentLocationFetched());
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("common.current_location"),
            style: CustomTextStyles(context).titleLargeOnPrimaryContainer,
          ),
          CurrentLocationFeature(),
        ],
      ),
      toolbarHeight: 100.h,
      actions: [
        IconButton(
          onPressed: () {
            ImageUtility().getMediaFromCamera(context, []);
          },
          icon: Icon(
            Icons.qr_code_scanner,
            size: 25.h,
            color: theme(context).colorScheme.onPrimaryContainer,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            size: 25.h,
            color: theme(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
