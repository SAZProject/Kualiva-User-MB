import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_promo_bloc.dart';
import 'package:kualiva/places/spa/feature/spa_app_bar_feature.dart';
import 'package:kualiva/places/spa/feature/spa_nearest_feature.dart';
import 'package:kualiva/places/spa/feature/spa_promo_feature.dart';

class SpaScreen extends StatefulWidget {
  const SpaScreen({super.key});

  @override
  State<SpaScreen> createState() => _SpaScreenState();
}

class _SpaScreenState extends State<SpaScreen> {
  static const placeCategoryEnum = PlaceCategoryEnum.spa;

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
            .read<SpaPromoBloc>()
            .add(SpaPromoFetched(placeCategoryEnum: placeCategoryEnum));
        if (state is! CurrentLocationSuccess) return;

        context.read<SpaNearestBloc>().add(SpaNearestFetched(
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
            SpaAppBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              SpaNearestFeature(
                parentContext: context,
                parentScrollController: _parentScrollController,
                childScrollController: _childScrollController,
              ),
              SizedBox(height: 5.h),
              SpaPromoFeature(),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
