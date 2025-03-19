import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_attach_media.dart';
import 'package:kualiva/common/widget/custom_error_dialog.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_loading_dialog.dart';
import 'package:kualiva/report/argument/report_place_argument.dart';
import 'package:kualiva/report/bloc/report_place_bloc.dart';
import 'package:kualiva/report/feature/report_place_reason_feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPlaceScreen extends StatefulWidget {
  const ReportPlaceScreen({
    super.key,
    required this.reportPlaceArgument,
  });

  final ReportPlaceArgument reportPlaceArgument;

  @override
  State<ReportPlaceScreen> createState() => _ReportPlaceScreenState();
}

class _ReportPlaceScreenState extends State<ReportPlaceScreen> {
  PlaceCategoryEnum get placeCategoryEnum =>
      widget.reportPlaceArgument.placeCategoryEnum;
  String get placeId => widget.reportPlaceArgument.placeId;

  final _reasonCtl = TextEditingController();

  final _selectedReasonId = ValueNotifier<String>('');

  final _reportMedia = ValueNotifier<List<String>>([]);

  late ReportPlaceBloc _reportPlaceBloc;

  void reportMediaListener() {
    context
        .read<ReportPlaceBloc>()
        .add(ReportPlaceImageStored(imagePaths: _reportMedia.value));
  }

  @override
  void initState() {
    super.initState();
    _reportPlaceBloc = context.read<ReportPlaceBloc>();
    _reportMedia.addListener(reportMediaListener);
    _reportPlaceBloc.add(ReportPlaceFetched());
  }

  @override
  void dispose() {
    _reasonCtl.dispose();
    _reportMedia.removeListener(reportMediaListener);
    _reportMedia.dispose();
    _selectedReasonId.dispose();
    _reportPlaceBloc.add(ReportPlaceImageDisposed());
    super.dispose();
  }

  void _submit() {
    context.read<ReportPlaceBloc>().add(
          ReportPlaceCreated(
            placeCategoryEnum: placeCategoryEnum,
            placeId: placeId,
            reasonId: int.parse(_selectedReasonId.value),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportPlaceBloc, ReportPlaceState>(
      listenWhen: (previous, current) {
        if (previous is ReportPlaceFetchSuccess &&
            current is ReportPlaceLoading) {
          return true;
        }
        if (current is ReportPlaceCreatedSuccess) {
          return true;
        }
        if (current is ReportPlaceCreatedFailure) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        LeLog.sd(this, build, state.toString());
        if (state is ReportPlaceCreatedSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is ReportPlaceCreatedFailure) {
          Navigator.pop(context); // pop loading dialog
          customErrorDialog(context: context);
        }
        if (state is ReportPlaceLoading) {
          // TODO create global bloc for loading dialog etc
          // TODO first time page open get called
          customLoadingDialog(context: context);
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
              valueListenable: _selectedReasonId,
              builder: (context, reason, child) {
                return ReportPlaceReasonFeature(
                  reasonCtl: _reasonCtl,
                  selectedReason: reason,
                  onChange: (value) => _selectedReasonId.value = value,
                );
              },
            ),
            SizedBox(height: 10.h),
            ValueListenableBuilder(
              valueListenable: _reportMedia,
              builder: (context, media, child) {
                return CustomAttachMedia(
                  headerLabel: "report.attach_media",
                  listImages: media,
                  onPressedGallery: () {
                    ImageUtility()
                        .getMultipleMediaFromGallery(context, media)
                        .then((value) {
                      _reportMedia.value = value;
                    });
                    Navigator.pop(context);
                  },
                  onPressedCamera: () {
                    ImageUtility()
                        .getMediaFromCamera(context, media)
                        .then((value) {
                      _reportMedia.value = value;
                    });
                    Navigator.pop(context);
                  },
                  onCancelPressed: () => Navigator.pop(context),
                  onRemovePressed: (index) {
                    debugPrint('onRemovePressed');
                    _reportMedia.value.removeAt(index);
                    _reportMedia.value = [..._reportMedia.value];
                  },
                );
              },
            ),
            SizedBox(height: 25.h),
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
