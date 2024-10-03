import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/ui_model/home_event_model.dart';

class HomeEventDetailScreen extends StatelessWidget {
  const HomeEventDetailScreen({super.key, required this.eventModel});

  final HomeEventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _eventDetailAppBar(context),
        body: Container(
          width: double.maxFinite,
          height: Sizeutils.height,
          decoration: BoxDecoration(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            image: DecorationImage(
              image: AssetImage(ImageConstant.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _eventDetailImages(context),
            SizedBox(height: 5.h),
            _eventDetailAbout(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _eventDetailAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50.h,
      leadingWidth: 50.h,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        decoration: BoxDecoration(
          color:
              theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _eventDetailImages(BuildContext context) {
    return CustomImageView(
      imagePath: eventModel.imagePath,
      height: 360.h,
      width: double.maxFinite,
      boxFit: BoxFit.cover,
    );
  }

  Widget _eventDetailAbout(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              context.tr("f_n_b_detail.about"),
              style: theme(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(5.h),
            decoration:
                CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAboutContent(
                  context,
                  label: eventModel.eventTitle,
                  maxLines: 1,
                  customTextStyle:
                      CustomTextStyles(context).titleLargeOnPrimaryContainer,
                ),
                SizedBox(height: 8.h),
                _buildAboutContent(
                  context,
                  label: eventModel.eventHost,
                  maxLines: 1,
                  customTextStyle: CustomTextStyles(context).bodySmall10,
                ),
                SizedBox(height: 8.h),
                _buildAboutContent(
                  context,
                  label: eventModel.eventDate,
                  maxLines: 1,
                  customTextStyle: CustomTextStyles(context).bodySmall10,
                ),
                SizedBox(height: 8.h),
                _buildAboutContent(
                  context,
                  label: eventModel.eventDesc,
                  maxLines: 500,
                  customTextStyle: CustomTextStyles(context).bodySmall10,
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(
    BuildContext context, {
    required String label,
    int? maxLines,
    void Function()? onPressed,
    required TextStyle customTextStyle,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: InkWell(
          onTap: onPressed,
          child: Text(
            label,
            style: onPressed != null
                ? customTextStyle.copyWith(
                    color: theme(context).colorScheme.onPrimary,
                  )
                : customTextStyle,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
