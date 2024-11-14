import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/common/style/custom_text_style.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/location_util.dart';
import 'package:like_it/common/utility/sized_utils.dart';
import 'package:like_it/data/current_location/current_location_bloc.dart';

class HomeAppBarFeature extends StatefulWidget {
  const HomeAppBarFeature({super.key});

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
      context.read<CurrentLocationBloc>().add(CurrentLocationNoPermission(
            message: 'No Connection or error on locator',
          ));
    }
    if (!mounted) return;
    context.read<CurrentLocationBloc>().add(CurrentLocationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      automaticallyImplyLeading: false,
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
        // TODO dimatikan untuk V!
        // IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.qr_code_scanner,
        //     size: 30.h,
        //     color: appTheme.black900,
        //   ),
        // ),
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
    return BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
      builder: (context, state) {
        if (state is CurrentLocationFailure) {
          return _buildUserLoc(context, context.tr("common.error"));
        }
        if (state is CurrentLocationSuccess) {
          return _buildUserLoc(context,
              "${state.currentLocationModel.userCurrSubDistrict}, ${state.currentLocationModel.userCurrCity}");
        }
        // CurrentLocationLoading
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildUserLoc(BuildContext context, String label) {
    return InkWell(
      // TODO dimatikan untuk V1
      // onTap: () {
      //   Navigator.pushNamed(context, AppRoutes.locationScreen);
      // },
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
}
