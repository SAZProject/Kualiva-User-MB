import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/_data/feature/current_location/current_location_bloc.dart';

class CurrentLocationFeature extends StatelessWidget {
  const CurrentLocationFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
      builder: (context, state) {
        if (state is CurrentLocationFailure) {
          return _buildUserLoc(context, context.tr("common.error"));
        }
        if (state is CurrentLocationSuccess) {
          return _buildUserLoc(context,
              "${state.currentLocationModel.subLocality}, ${state.currentLocationModel.locality}");
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
