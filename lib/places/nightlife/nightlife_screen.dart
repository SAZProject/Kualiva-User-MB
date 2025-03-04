import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_app_bar_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_nearest_feature.dart';

class NightlifeScreen extends StatefulWidget {
  const NightlifeScreen({super.key});

  @override
  State<NightlifeScreen> createState() => _NightlifeScreenState();
}

class _NightlifeScreenState extends State<NightlifeScreen> {
  final _parentScrollController = ScrollController();
  final _childScrollController = ScrollController();

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        context
            .read<NightlifeNearestBloc>()
            .add(NightlifeNearestFetched(latitude: 0.0, longitude: 0.0));
        if (state is! CurrentLocationSuccess) return;

        context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
      },
      child: SafeArea(
        child: Scaffold(
          body: _body(context),
        ),
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
            NightlifeAppBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              // _nearestList(context),
              NightlifeNearestFeature(
                parentContext: context,
                parentScrollController: _parentScrollController,
                childScrollController: _childScrollController,
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
