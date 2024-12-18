import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/check_device.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:permission_handler/permission_handler.dart';

class DevicePermissionScreen extends StatefulWidget {
  const DevicePermissionScreen({super.key});

  @override
  State<DevicePermissionScreen> createState() => _DevicePermissionScreenState();
}

class _DevicePermissionScreenState extends State<DevicePermissionScreen> {
  void _getdevicePermission(BuildContext context) {
    _requestPermission(context).then(
      (value) {
        if (value) {
          if (!context.mounted) return;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.signInScreen, (route) => false);
        }
      },
    );
  }

  Future<bool> _requestPermission(context) async {
    bool havePermission = false;

    if (CheckDevice.isAndroid()) {
      if (await Permission.location.isPermanentlyDenied) {
        Permission.location.request();
      }
      if (await Permission.camera.isPermanentlyDenied) {
        Permission.camera.request();
      }
      if (await Permission.microphone.isPermanentlyDenied) {
        Permission.microphone.request();
      }
      List<Permission> defaultPerm = [
        Permission.location,
        Permission.camera,
        Permission.microphone,
      ];
      if (await CheckDevice.isAndroid13plus()) {
        if (await Permission.photos.isPermanentlyDenied) {
          Permission.photos.request();
        }
        final request = await [
          ...defaultPerm,
          Permission.photos,
        ].request();
        havePermission = request.values
            .every((status) => status == PermissionStatus.granted);
      } else {
        if (await Permission.storage.isPermanentlyDenied) {
          Permission.storage.request();
        }
        final request = await [
          ...defaultPerm,
          Permission.storage,
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _imageTitleContentView(context),
            SizedBox(height: 4.h),
            _allowButton(context),
            SizedBox(height: 4.h),
          ],
        ),
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
    return Padding(
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

  Widget _allowButton(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("permission.allow_btn"),
      margin: EdgeInsets.only(
        left: 30.h,
        right: 30.h,
        bottom: 40.h,
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () => _getdevicePermission(context),
    );
  }
}
