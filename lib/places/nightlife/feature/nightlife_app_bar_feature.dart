import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/feature/current_location/current_location_feature.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/location_util.dart';

class NightlifeAppBarFeature extends StatefulWidget {
  const NightlifeAppBarFeature({super.key});

  @override
  State<NightlifeAppBarFeature> createState() => _NightlifeAppBarFeatureState();
}

class _NightlifeAppBarFeatureState extends State<NightlifeAppBarFeature> {
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
            style: CustomTextStyles(context).bodySmallPrimary12,
          ),
          CurrentLocationFeature(),
        ],
      ),
      toolbarHeight: 70.h,
    );
  }
}
