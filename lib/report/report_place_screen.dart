import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/image_utility.dart';
import 'package:like_it/common/widget/custom_app_bar.dart';
import 'package:like_it/common/widget/custom_attach_media.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/report/feature/report_place_reason.dart';
import 'package:like_it/report/feature/report_place_submit_button.dart';

class ReportPlaceScreen extends StatefulWidget {
  const ReportPlaceScreen({super.key, required this.fnbModel});

  final FNBModel fnbModel;

  @override
  State<ReportPlaceScreen> createState() => _ReportPlaceScreenState();
}

class _ReportPlaceScreenState extends State<ReportPlaceScreen> {
  FNBModel get fnbData => super.widget.fnbModel;

  final TextEditingController _reasonCtl = TextEditingController();

  String selectedReason = "";

  List<String> reportMedia = [];

  @override
  void dispose() {
    _reasonCtl.dispose();
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
            ReportPlaceReason(
              reasonCtl: _reasonCtl,
              selectedReason: selectedReason,
              onChange: (value) => setState(() => selectedReason = value),
            ),
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
            ReportPlaceSubmitButton(),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _reportPlaceAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("report.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }
}
