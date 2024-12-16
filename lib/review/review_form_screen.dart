import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/image_utility.dart';
import 'package:like_it/common/widget/custom_app_bar.dart';
import 'package:like_it/common/widget/custom_attach_media.dart';
import 'package:like_it/common/widget/custom_checkbox_button.dart';
import 'package:like_it/review/feature/review_form_submit_button.dart';
import 'package:like_it/review/widget/review_form_message.dart';
import 'package:like_it/review/widget/review_form_rating_bar.dart';

class ReviewFormScreen extends StatefulWidget {
  const ReviewFormScreen({super.key, required this.transaction});

  // final FNBModel fnbModel;
  final String transaction;

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  // FNBModel get fnbData => super.widget.fnbModel;
  String get transaction => super.widget.transaction;

  final _reviewMsgCtl = TextEditingController();

  List<String> reviewMedia = [];

  double ratingStar = 0.0;

  bool isHideUsername = false;

  @override
  void dispose() {
    _reviewMsgCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _reviewFormAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
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
            SizedBox(height: 10.h),
            ReportReviewRatingBar(
              ratingStar: ratingStar,
              onRatingUpdate: (value) {
                ratingStar = value;
              },
            ),
            SizedBox(height: 20.h),
            ReportReviewMessage(reviewMsgCtl: _reviewMsgCtl),
            SizedBox(height: 10.h),
            CustomAttachMedia(
              headerLabel: "review.attach_media",
              listImages: reviewMedia,
              onPressedGallery: () {
                ImageUtility()
                    .getMediaFromGallery(context, reviewMedia)
                    .then((value) => setState(() => reviewMedia = value));
                Navigator.pop(context);
              },
              onPressedCamera: () {
                ImageUtility()
                    .getMediaFromCamera(context, reviewMedia)
                    .then((value) => setState(() => reviewMedia = value));
                Navigator.pop(context);
              },
              onCancelPressed: () => Navigator.pop(context),
              onRemovePressed: (index) {
                setState(() {
                  reviewMedia.remove(reviewMedia[index]);
                });
              },
            ),
            SizedBox(height: 10.h),
            _buildHideUsername(context),
            SizedBox(height: 25.h),
            ReportReviewSubmitButton(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _reviewFormAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("review.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildHideUsername(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: CustomCheckboxButton(
        text: context.tr("review.hide_username"),
        value: isHideUsername,
        onChange: (value) {
          setState(() {
            isHideUsername = value;
          });
        },
      ),
    );
  }
}
