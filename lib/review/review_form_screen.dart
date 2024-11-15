import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/image_utility.dart';
import 'package:like_it/common/widget/custom_alert_dialog.dart';
import 'package:like_it/common/widget/custom_attach_media.dart';
import 'package:like_it/common/widget/custom_checkbox_button.dart';
import 'package:like_it/common/widget/custom_gradient_outlined_button.dart';
import 'package:like_it/common/widget/custom_rating_bar.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          // decoration: BoxDecoration(
          //   color: theme(context)
          //       .colorScheme
          //       .onSecondaryContainer
          //       .withOpacity(0.6),
          //   image: DecorationImage(
          //     image: AssetImage(ImageConstant.background2),
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
            _reviewRatingBar(context),
            SizedBox(height: 20.h),
            _buildReviewMsg(context),
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
            _buildSubmitButton(context),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _reviewFormAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("review.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _reviewRatingBar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomRatingBar(
        alignment: Alignment.center,
        initialRating: ratingStar,
        itemSize: 50.h,
        color: theme(context).colorScheme.primary,
        onRatingUpdate: (value) {
          ratingStar = value;
        },
      ),
    );
  }

  Widget _buildReviewMsg(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("review.review_msg"),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: _reviewMsgCtl,
            textInputAction: TextInputAction.done,
            maxLines: 11,
            contentPadding: EdgeInsets.all(12.h),
            fillColor: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            inputBorder: TextFormFieldStyleHelper.fillOnSecondaryContainer,
          ),
        ],
      ),
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

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: SizedBox(
        height: 60.h,
        width: double.maxFinite,
        child: CustomGradientOutlinedButton(
          text: context.tr("review.submit_btn"),
          outerPadding: EdgeInsets.symmetric(horizontal: 30.h),
          innerPadding: EdgeInsets.all(2.h),
          strokeWidth: 2.h,
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.primary,
          ],
          textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
          onPressed: () async {
            customAlertDialog(
              context: context,
              dismissable: true,
              title: Text(
                "Conratulation!",
              ),
              content: Text(
                "You get 10 points",
              ),
              icon: Icon(
                Icons.generating_tokens_outlined,
              ),
            );
            debugPrint('LeRucco Review Form Screen');
            debugPrint(transaction);
            debugPrint(_reviewMsgCtl.text.trim());
            debugPrint(ratingStar.toString());
            // final SharedPreferences prefs =
            //     await SharedPreferences.getInstance();
            // await prefs.setString('transaction', transaction);
            // await prefs.setString('message', _reviewMsgCtl.text.trim());
            // await prefs.setDouble('rating', ratingStar);
            // await prefs.setString("date", DateTime.now().toString());
            await Future.delayed(const Duration(seconds: 3));
            SharedPreferences.getInstance().then(
              (prefs) {
                Future.wait([
                  prefs.setString('transaction', transaction),
                  prefs.setString('message', _reviewMsgCtl.text.trim()),
                  prefs.setDouble('rating', ratingStar),
                  prefs.setString("date", DateTime.now().toString()),
                ]).then(
                  (value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.reviewScreen, (route) => false);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
