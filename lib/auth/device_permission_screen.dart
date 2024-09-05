import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/utility/check_device.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:permission_handler/permission_handler.dart';

class DevicePermissionScreen extends StatefulWidget {
  const DevicePermissionScreen({super.key});

  @override
  State<DevicePermissionScreen> createState() => _DevicePermissionScreenState();
}

class _DevicePermissionScreenState extends State<DevicePermissionScreen> {
  void _getdevicePermission(BuildContext context) async {
    if (await _requestPermission(context)) {
      if (context.mounted) {
        Navigator.of(context).pushNamed(AppRoutes.homeNavigationScreen);
      }
    } else {}
  }

  Future<bool> _requestPermission(context) async {
    bool havePermission = false;

    if (CheckDevice.isAndroid()) {
      if (await CheckDevice.isAndroid13plus()) {
        if (await Permission.location.isPermanentlyDenied) {
          Permission.location.request();
        }
        if (await Permission.photos.isPermanentlyDenied) {
          Permission.photos.request();
        }
        if (await Permission.camera.isPermanentlyDenied) {
          Permission.camera.request();
        }
        if (await Permission.microphone.isPermanentlyDenied) {
          Permission.microphone.request();
        }
        final request = await [
          Permission.location,
          Permission.photos,
          Permission.camera,
          Permission.microphone,
        ].request();
        havePermission = request.values
            .every((status) => status == PermissionStatus.granted);
      } else {
        if (await Permission.location.isPermanentlyDenied) {
          Permission.location.request();
        }
        if (await Permission.storage.isPermanentlyDenied) {
          Permission.storage.request();
        }
        if (await Permission.camera.isPermanentlyDenied) {
          Permission.camera.request();
        }
        if (await Permission.microphone.isPermanentlyDenied) {
          Permission.microphone.request();
        }
        final request = await [
          Permission.location,
          Permission.storage,
          Permission.camera,
          Permission.microphone,
        ].request();
        havePermission = request.values
            .every((status) => status == PermissionStatus.granted);
      }
    }
    if (!havePermission) return await openAppSettings();
    return havePermission;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _imageTitleContentView(context),
          SizedBox(height: 4.h),
          _allowBtn(context),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _imageTitleContentView(BuildContext context) {
    return Column(
      children: [
        _permissionImage(context),
        SizedBox(height: 4.h),
        _permissionTitleContent(context),
      ],
    );
  }

  Widget _permissionImage(BuildContext context) {
    return SizedBox(
      height: 400.h,
      width: double.maxFinite,
      child: CustomImageView(
        imagePath: ImageConstant.permissionScreen,
        height: 360.h,
        width: double.maxFinite,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _permissionTitleContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text(
            context.tr("permission.permission_title"),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme(context).textTheme.displaySmall,
          ),
          SizedBox(height: 10.h),
          Opacity(
            opacity: 0.6,
            child: Text(
              context.tr("permission.permission_content"),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: theme(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _allowBtn(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("permission.allow_btn"),
      margin: EdgeInsets.only(
        left: 30.h,
        right: 30.h,
        bottom: 40.h,
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles(context).gradientYellowAToPrimaryL10Decoration,
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () => _getdevicePermission(context),
    );
  }
}
