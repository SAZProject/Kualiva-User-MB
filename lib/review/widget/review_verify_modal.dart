import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/widget/custom_attach_media.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';
import 'package:kualiva/data/place_category_enum.dart';
import 'package:kualiva/review/bloc/review_place_create_bloc.dart';

class ReviewVerifyModal extends StatefulWidget {
  const ReviewVerifyModal({
    super.key,
    required this.placeUniqueId,
    required this.placeCategory,
  });

  final String placeUniqueId;
  final PlaceCategoryEnum placeCategory;

  @override
  State<ReviewVerifyModal> createState() => _ReviewVerifyModalState();
}

class _ReviewVerifyModalState extends State<ReviewVerifyModal> {
  final _transactionCtl = TextEditingController();

  List<String> invoiceMedia = [];

  @override
  void dispose() {
    _transactionCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _reviewVerifyAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CustomAttachMedia(
                headerLabel: "review.attach_invoice",
                listImages: invoiceMedia,
                onPressedGallery: () {
                  ImageUtility()
                      .getMediaFromGallery(context, invoiceMedia)
                      .then((value) => setState(() => invoiceMedia = value));
                  Navigator.pop(context);
                },
                onPressedCamera: () {
                  ImageUtility()
                      .getMediaFromCamera(context, invoiceMedia)
                      .then((value) => setState(() => invoiceMedia = value));
                  Navigator.pop(context);
                },
                onCancelPressed: () => Navigator.pop(context),
                onRemovePressed: (index) {
                  setState(() {
                    invoiceMedia.remove(invoiceMedia[index]);
                  });
                },
              ),
              SizedBox(height: 10.h),
              _buildReason(context, _transactionCtl),
              SizedBox(height: 10.h),
              _buildWriteReviewBtn(context),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _reviewVerifyAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Text(
          context.tr("review.write_title_n_btn"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _buildReason(BuildContext context, TextEditingController controller) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("review.input_transaction_number"),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: controller,
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 14.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWriteReviewBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
        child: CustomGradientOutlinedButton(
          text: context.tr("review.confirm_btn"),
          outerPadding: EdgeInsets.zero,
          innerPadding: EdgeInsets.all(2.h),
          strokeWidth: 2.h,
          colors: [
            appTheme.yellowA700,
            theme(context).colorScheme.primary,
          ],
          buttonStyle:
              CustomButtonStyles.fillOnSecondaryContainerNoBdr(context),
          textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
          onPressed: () {
            context.read<ReviewPlaceCreateBloc>().add(ReviewPlaceTempCreated(
                  placeUniqueId: widget.placeUniqueId,
                  placeCategory: widget.placeCategory,
                  invoice: _transactionCtl.text.trim(),
                  invoiceFile: invoiceMedia[0],
                ));
            Navigator.pushNamed(context, AppRoutes.reviewFormScreen);
          },
        ),
      ),
    );
  }
}
