import 'package:hive/hive.dart';
import 'package:kualiva/common/feature/current_location/current_location_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/location_util.dart';
import 'package:kualiva/main_hive.dart';

class LocationRepository {
  CurrentLocationModel? oldLocation() {
    final boxName = MyBox.currentLocation.name;
    final currentLocationBox = Hive.box<CurrentLocationModel>(boxName);
    LeLog.rd(this, oldLocation, currentLocationBox.get(boxName).toString());
    return currentLocationBox.get(boxName);
  }

  Future<CurrentLocationModel> newLocation() async {
    final CurrentLocationModel newCurrentLocation =
        await LocationUtil.getUserCurrentLocation();

    return newCurrentLocation;
  }

  Future<(bool, double)> isDistanceTooFarOrFirstTime({
    required CurrentLocationModel? oldLocation,
    required CurrentLocationModel newLocation,
  }) async {
    final boxName = MyBox.currentLocation.name;
    final currentLocationBox = Hive.box<CurrentLocationModel>(boxName);

    /// First time get current location
    if (oldLocation == null) {
      await currentLocationBox.clear();
      LeLog.rd(this, isDistanceTooFarOrFirstTime, newLocation.toString());
      await currentLocationBox.put(boxName, newLocation);
      return (true, 0.0);
    }

    final distance = LocationUtil.calculateDistance(
      oldLatitude: oldLocation.latitude,
      oldLongitude: oldLocation.longitude,
      newLatitude: newLocation.latitude,
      newLongitude: newLocation.longitude,
    );

    /// 22.5 meters
    if (distance >= 22.5) {
      await currentLocationBox.clear();
      await currentLocationBox.put(boxName, newLocation);
      return (true, distance);
    }

    return (false, distance);
  }
}
