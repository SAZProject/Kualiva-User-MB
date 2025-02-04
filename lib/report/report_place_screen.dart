import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_attach_media.dart';
import 'package:kualiva/common/widget/custom_error_dialog.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/report/bloc/report_place_bloc.dart';
import 'package:kualiva/report/feature/report_place_reason_feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPlaceScreen extends StatefulWidget {
  const ReportPlaceScreen({
    super.key,
    required this.placeId,
  });

  final String placeId;

  @override
  State<ReportPlaceScreen> createState() => _ReportPlaceScreenState();
}

class _ReportPlaceScreenState extends State<ReportPlaceScreen> {
  final _reasonCtl = TextEditingController();

  String get placeId => widget.placeId;

  final _selectedReason = ValueNotifier<String>('');

  final reportMedia = ValueNotifier<List<String>>([]);

  void reportMediaListener() {
    debugPrint(reportMedia.value.toString());
    for (int i = 0; i < reportMedia.value.length; i++) {
      context
          .read<ReportPlaceBloc>()
          .add(ReportPlaceFileUploaded(imagePath: reportMedia.value[i]));
    }
  }

  @override
  void initState() {
    super.initState();
    reportMedia.addListener(reportMediaListener);
    context.read<ReportPlaceBloc>().add(ReportPlaceFetched());
  }

  @override
  void dispose() {
    _reasonCtl.dispose();
    reportMedia.removeListener(reportMediaListener);
    reportMedia.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<ReportPlaceBloc>().add(
          ReportPlaceCreated(
            placeId: placeId,
            reasonId: int.parse(_selectedReason.value),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportPlaceBloc, ReportPlaceState>(
      listener: (context, state) {
        if (state is ReportPlaceCreatedSuccess) {
          Navigator.pop(context);
        }
        if (state is ReportPlaceCreatedFailure) {
          Navigator.pop(context); // pop loading dialog
          customErrorDialog(context: context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _reportPlaceAppBar(context),
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
            ValueListenableBuilder(
              valueListenable: _selectedReason,
              builder: (context, reason, child) {
                return ReportPlaceReasonFeature(
                  reasonCtl: _reasonCtl,
                  selectedReason: reason,
                  onChange: (value) => _selectedReason.value = value,
                );
              },
            ),
            SizedBox(height: 10.h),
            ValueListenableBuilder(
              valueListenable: reportMedia,
              builder: (context, media, child) {
                return CustomAttachMedia(
                  headerLabel: "report.attach_media",
                  listImages: media,
                  onPressedGallery: () {
                    ImageUtility()
                        .getMediaFromGallery(context, media)
                        .then((value) {
                      reportMedia.value = value;
                    });
                    Navigator.pop(context);
                  },
                  onPressedCamera: () {
                    ImageUtility()
                        .getMediaFromCamera(context, media)
                        .then((value) {
                      reportMedia.value = value;
                    });
                    Navigator.pop(context);
                  },
                  onCancelPressed: () => Navigator.pop(context),
                  onRemovePressed: (index) {
                    debugPrint('onRemovePressed');
                    // reportMedia.value.remove(reportMedia.value[index]);
                    reportMedia.value.removeAt(index);
                    reportMedia.value = [...reportMedia.value];

                    // setState(() {
                    //   reportMedia.value.removeAt(index);
                    // });
                  },
                );
              },
            ),
            SizedBox(height: 25.h),
            // ReportPlaceSubmitButton(),
            SizedBox(
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
                textStyle:
                    CustomTextStyles(context).titleMediumOnPrimaryContainer,
                onPressed: _submit,
              ),
            ),
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
