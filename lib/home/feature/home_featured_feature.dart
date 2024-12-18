import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/home/bloc/home_featured_bloc.dart';
import 'package:kualiva/home/widget/home_featured_item.dart';
import 'package:kualiva/router.dart';

class HomeFeaturedFeature extends StatelessWidget {
  const HomeFeaturedFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("home_screen.featured"),
            // TODO dimatikan masih belum jelas mau gimana, apakah akan dibataskan atau tampilkan list banyak
            onPressed: () {},
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 200.h,
              width: double.maxFinite,
              child: _list(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return BlocBuilder<HomeFeaturedBloc, HomeFeaturedState>(
      builder: (context, state) {
        if (state is HomeFeaturedFailure) {
          return Text('ERROR MASZEH');
        }

        if (state is! HomeFeaturedSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: state.homeFeatured.length,
          itemBuilder: (context, index) {
            return HomeFeaturedItem(
              homeFeatured: state.homeFeatured[index],
              onPressed: () {
                // context.read<FnbDetailBloc>().add(FnbDetailFetched(
                //       placeId: state.homeFeatured[index].placeId,
                //     ));
                Navigator.pushNamed(
                  context,
                  AppRoutes.fnbDetailScreen,
                );
              },
            );
          },
        );
      },
    );
  }
}
