import 'package:hive/hive.dart';
import 'package:kualiva/_data/feature/current_location/current_location_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/location_util.dart';
import 'package:kualiva/main_hive.dart';

class LocationRepository {
  CurrentLocationModel? oldLocation() {
    final currentLocationBox =
        Hive.box<CurrentLocationModel>(MyHive.currentLocation.name);

    if (currentLocationBox.values.toList().isNotEmpty) {
      final oldCurrentLocation = currentLocationBox.values.toList().first;
      LeLog.rd(this, oldLocation, oldCurrentLocation.toString());
      return oldCurrentLocation;
    }

    return null;
  }

  Future<CurrentLocationModel> newLocation() async {
    final CurrentLocationModel newCurrentLocation =
        await LocationUtil.getUserCurrentLocation();

    return newCurrentLocation;
  }

  Future<bool> isDistanceTooFarOrFirstTime({
    required CurrentLocationModel? oldLocation,
    required CurrentLocationModel newLocation,
  }) async {
    final currentLocationBox =
        Hive.box<CurrentLocationModel>(MyHive.currentLocation.name);

    /// First time get current location
    if (oldLocation == null) {
      currentLocationBox.clear();
      currentLocationBox.add(newLocation);
      return true;
    }

    final distance = LocationUtil.calculateDistance(
      oldLatitude: oldLocation.latitude,
      oldLongitude: oldLocation.longitude,
      newLatitude: newLocation.latitude,
      newLongitude: newLocation.longitude,
    );

    /// 22.5 meters
    if (distance >= 22.5) {
      currentLocationBox.clear();
      currentLocationBox.add(newLocation);
      return true;
    }

    return false;
  }
}
