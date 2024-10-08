import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/image_utility.dart';
import 'package:like_it/common/widget/custom_attach_media.dart';
import 'package:like_it/common/widget/custom_gradient_outlined_button.dart';
import 'package:like_it/common/widget/custom_radio_button.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';
import 'package:like_it/data/model/f_n_b_model.dart';

class ReportPlaceScreen extends StatefulWidget {
  const ReportPlaceScreen({super.key, required this.fnbModel});

  final FNBModel fnbModel;

  @override
  State<ReportPlaceScreen> createState() => _ReportPlaceScreenState();
}

class _ReportPlaceScreenState extends State<ReportPlaceScreen> {
  FNBModel get fnbData => super.widget.fnbModel;

  TextEditingController reasonCtl = TextEditingController();

  String selectedReason = "";

  List<String> reportMedia = [];

  @override
  void dispose() {
    reasonCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _reportPlaceAppBar(context),
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
            _buildReason(context),
            SizedBox(height: 10.h),
            CustomAttachMedia(
              headerLabel: "report.attach_media",
              listImages: reportMedia,
              onPressedGallery: () {
                ImageUtility()
                    .getMediaFromGallery(context, reportMedia)
                    .then((value) => setState(() => reportMedia = value));
                Navigator.pop(context);
              },
              onPressedCamera: () {
                ImageUtility()
                    .getMediaFromCamera(context, reportMedia)
                    .then((value) => setState(() => reportMedia = value));
                Navigator.pop(context);
              },
              onCancelPressed: () => Navigator.pop(context),
              onRemovePressed: (index) {
                setState(() {
                  reportMedia.remove(reportMedia[index]);
                });
              },
            ),
            SizedBox(height: 25.h),
            _buildSubmitButton(context),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _reportPlaceAppBar(BuildContext context) {
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
          context.tr("report.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _buildReason(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("report.reason"),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          CustomRadioButton(
            text: context.tr("report.reason_place_1"),
            value: context.tr("report.reason_place_1"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_place_2"),
            value: context.tr("report.reason_place_2"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_place_3"),
            value: context.tr("report.reason_place_3"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          CustomRadioButton(
            text: context.tr("report.reason_place_4"),
            value: context.tr("report.reason_place_4"),
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              setState(() {
                selectedReason = value;
              });
            },
          ),
          SizedBox(height: 4.h),
          Visibility(
            visible: selectedReason == context.tr("report.reason_place_4"),
            child: CustomTextFormField(
              controller: reasonCtl,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              contentPadding: EdgeInsets.all(12.h),
              fillColor: theme(context).colorScheme.onSecondaryContainer,
              boxDecoration:
                  CustomDecoration(context).outlineOnPrimaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
              inputBorder: TextFormFieldStyleHelper.fillOnSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.maxFinite,
      child: CustomGradientOutlinedButton(
        text: context.tr("report.submit_btn"),
        outerPadding: EdgeInsets.symmetric(horizontal: 30.h),
        innerPadding: EdgeInsets.all(2.h),
        strokeWidth: 2.h,
        colors: [
          appTheme.yellowA700,
          theme(context).colorScheme.primary,
        ],
        textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      ),
    );
  }
}
