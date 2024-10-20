import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_alert_dialog.dart';
import 'package:like_it/data/model/ui_model/loc_dropdown_model.dart';
import 'package:like_it/data/model/util_model/distance_checking_result_model.dart';
import 'package:like_it/data/model/util_model/user_curr_loc_model.dart';

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
    icon: Icon(icon, size: 75.h, color: theme(context).colorScheme.primary),
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
  static Future<bool> checkPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "common.location_unavailable".tr(),
        content: "common.location_unavailable_content".tr(),
        defaultActionText: "common.alert_action_text".tr(),
        onButtonPressed: () async {
          await Geolocator.openLocationSettings();
          Navigator.pop(context);
        },
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlertDialog(
          context: context,
          icon: Icons.error_outline,
          title: "common.location_unavailable".tr(),
          content: "common.location_denied_content".tr(),
          defaultActionText: "common.alert_action_text".tr(),
          onButtonPressed: () async {
            Navigator.pop(context);
          },
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "common.location_unavailable".tr(),
        content: "common.location_denied_perm_content".tr(),
        defaultActionText: "common.alert_action_text".tr(),
        onButtonPressed: () async {
          await Geolocator.openLocationSettings();
          Navigator.pop(context);
        },
      );
      return false;
    }

    return true;
  }

  static Future<Position> getCurrentPosition() async {
    late LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  static Future<Placemark> getPlacemarkFromCoord(Position position) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];
    return place;
  }

  static String getCitySubDistrict(Placemark place) {
    String locationAddress = '${place.locality}, ${place.subLocality}';
    return locationAddress;
  }

  static String getAddress(Placemark place) {
    String locationAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return locationAddress;
  }

  static Future<UserCurrLocModel> getUserCurrLoc() async {
    try {
      Position currPos = await getCurrentPosition();
      Placemark getCurrPlacemark = await getPlacemarkFromCoord(currPos);
      String fullUserCurrLocAddress = getAddress(getCurrPlacemark);

      return UserCurrLocModel(
        userCurrLoc: fullUserCurrLocAddress,
        userCurrCity: getCurrPlacemark.locality ?? "-",
        userCurrSubDistrict: getCurrPlacemark.subLocality ?? "-",
        userFullPLacemark: getCurrPlacemark,
        // TODO Remove
        latitude: (kDebugMode) ? -6.213683336779805 : currPos.latitude,
        longitude: (kDebugMode) ? 106.80867612698492 : currPos.longitude,
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<DistanceCheckingResultModel> distanceChecking({
    required double userLatitude,
    required double userLongitude,
    required List<LocDropdownModel> locationsGeoPoint,
  }) async {
    List<double> distance = [];

    for (int i = 0; i < locationsGeoPoint.length; i++) {
      LocDropdownModel temp = locationsGeoPoint[i];

      // Dalam satuan meter
      double distanceBetweenPos = Geolocator.distanceBetween(
        userLatitude,
        userLongitude,
        double.parse(temp.latitude),
        double.parse(temp.longitude),
      );
      distance.add(distanceBetweenPos);
    }
    double min = distance.reduce(math.min);

    return DistanceCheckingResultModel(
      distanceBetween: min,
      closestPlace: locationsGeoPoint[distance.indexOf(min)],
    );
  }
}
