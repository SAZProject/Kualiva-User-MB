import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/location_util.dart';
import 'package:kualiva/_data/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/_data/feature/current_location/current_location_feature.dart';

class FnbAppBarFeature extends StatefulWidget {
  const FnbAppBarFeature({super.key});

  @override
  State<FnbAppBarFeature> createState() => _FnbAppBarFeatureState();
}

class _FnbAppBarFeatureState extends State<FnbAppBarFeature> {
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
      automaticallyImplyLeading: true,
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
          CurrentLocationFeature(),
        ],
      ),
      toolbarHeight: 100.h,
    );
  }
}
