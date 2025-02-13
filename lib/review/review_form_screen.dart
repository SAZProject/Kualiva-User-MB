import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/widget/custom_alert_dialog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_attach_media.dart';
import 'package:kualiva/common/widget/custom_checkbox_button.dart';
import 'package:kualiva/common/widget/custom_error_dialog.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_loading_dialog.dart';
import 'package:kualiva/review/bloc/review_place_create_bloc.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/widget/review_form_message.dart';
import 'package:kualiva/review/widget/review_form_rating_bar.dart';

class ReviewFormScreen extends StatefulWidget {
  const ReviewFormScreen({super.key});

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  final _reviewMsgCtl = TextEditingController();

  final _reviewMedias = ValueNotifier<List<String>>([]);
  double _ratingStar = 0.0;
  bool isHideUsername = false;
  bool _isCreated = true;
  int? _reviewId;

  void _submit() {
    context.read<ReviewPlaceCreateBloc>().add(ReviewPlaceCreatedOrUpdated(
          reviewId: _reviewId,
          isCreated: _isCreated,
          description: _reviewMsgCtl.text.trim(),
          rating: _ratingStar,
          photoFiles: _reviewMedias.value,
        ));
  }

  @override
  void initState() {
    super.initState();
    final reviewPlaceMyReadBloc = context.read<ReviewPlaceMyReadBloc>();
    if (reviewPlaceMyReadBloc.state is ReviewPlaceMyReadSuccess) {
      final reviewPlace =
          (reviewPlaceMyReadBloc.state as ReviewPlaceMyReadSuccess).reviewPlace;
      _reviewMsgCtl.text = reviewPlace.description;
      _reviewMedias.value = reviewPlace.photoFiles;
      _ratingStar = reviewPlace.rating;
      _isCreated = false; // It means for update review
      _reviewId = reviewPlace.id;
    }
  }

  @override
  void dispose() {
    _reviewMsgCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewPlaceCreateBloc, ReviewPlaceCreateState>(
      listener: (context, state) {
        if (state is ReviewPlaceCreateSuccess) {
          context
              .read<ReviewPlaceMyReadBloc>()
              .add(ReviewPlaceMyReadRefreshed(placeId: state.placeId));
          Navigator.pop(context); // pop loading dialog
          Navigator.pop(context); // Pop this screen
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
          Future.delayed(
            Duration(seconds: 3),
            () {
              if (!context.mounted) return;
              Navigator.pop(context); // Pop verify modal
            },
          );
        }
        if (state is ReviewPlaceCreateLoading) {
          customLoadingDialog(context: context);
        }
        if (state is ReviewPlaceCreateFailure) {
          Navigator.pop(context); // pop loading dialog
          customErrorDialog(context: context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _reviewFormAppBar(context),
          body: SizedBox(
            width: double.maxFinite,
            height: Sizeutils.height,
            child: _body(context),
          ),
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
              ratingStar: _ratingStar,
              onRatingUpdate: (value) {
                _ratingStar = value;
              },
            ),
            SizedBox(height: 20.h),
            ReportReviewMessage(reviewMsgCtl: _reviewMsgCtl),
            SizedBox(height: 10.h),
            ValueListenableBuilder(
              valueListenable: _reviewMedias,
              builder: (context, medias, child) {
                return CustomAttachMedia(
                  headerLabel: "review.attach_media",
                  listImages: medias,
                  onPressedGallery: () {
                    ImageUtility()
                        .getMultipleMediaFromGallery(context, medias)
                        .then((value) => _reviewMedias.value = value);
                    Navigator.pop(context);
                  },
                  onPressedCamera: () {
                    ImageUtility()
                        .getMediaFromCamera(context, medias)
                        .then((value) => _reviewMedias.value = value);
                    Navigator.pop(context);
                  },
                  onCancelPressed: () => Navigator.pop(context),
                  onRemovePressed: (index) {
                    final temp = [..._reviewMedias.value];
                    temp.removeAt(index);
                    _reviewMedias.value = temp;
                  },
                );
              },
            ),
            SizedBox(height: 10.h),
            _buildHideUsername(context),
            SizedBox(height: 25.h),
            _reviewSubmitBtn(),
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
          isHideUsername = value;
        },
      ),
    );
  }

  Widget _reviewSubmitBtn() {
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
          onPressed: _submit,
        ),
      ),
    );
  }
}
