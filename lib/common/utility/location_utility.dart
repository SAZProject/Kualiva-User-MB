import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_alert_dialog.dart';

void showAlertDialog({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String content,
  required String defaultActionText,
  required void Function()? onButtonPressed,
}) {
  return customAlertDialog(
    dismissable: false,
    context: context,
    icon: Icon(icon, size: 75.0, color: theme(context).colorScheme.primary),
    title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
    content: Text(content, maxLines: 4, overflow: TextOverflow.ellipsis),
    actionBtn: <Widget>[
      ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style,
        onPressed: onButtonPressed,
        child: SizedBox(
          width: 75.h,
          height: 30.h,
          child: Center(
            child: Text(defaultActionText, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    ],
  );
}

class LocationUtility {
  void checkPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "common.location_unavailable".tr(),
        content: "common.location_unavailable_content".tr(),
        defaultActionText: "common.alert_action_text".tr(),
        onButtonPressed: () async {
          Geolocator.openLocationSettings();
          Navigator.pop(context);
        },
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return showAlertDialog(
          context: context,
          icon: Icons.error_outline,
          title: "common.location_unavailable".tr(),
          content: "common.location_denied_content".tr(),
          defaultActionText: "common.alert_action_text".tr(),
          onButtonPressed: () async {
            Navigator.pop(context);
          },
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "common.location_unavailable".tr(),
        content: "common.location_denied_perm_content".tr(),
        defaultActionText: "common.alert_action_text".tr(),
        onButtonPressed: () async {
          Navigator.pop(context);
        },
      );
    }
  }

  Future<Position> _getCurrentLocation() async {
    late LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  Future<Placemark> _getPlacemarkFromCoord(
      double latitude, double longitude) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    Placemark place = placemarks[0];
    return place;
  }

  String _getAddress(Placemark place) {
    String locationAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return locationAddress;
  }
}
