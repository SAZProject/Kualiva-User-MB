import 'package:kualiva/_data/feature/current_location/current_location_model.dart';
import 'package:kualiva/_data/feature/current_location/current_location_placemark_model.dart';

class LocationFaker {
  static Future<CurrentLocationModel> getUserCurrentLocation() async {
    return CurrentLocationModel(
        locationAddress: '',
        locality: 'Jakarta',
        subLocality: 'Jalan Gatot Subroto',
        placemark: CurrentLocationPlacemarkModel(
          name: '',
          street: '',
          isoCountryCode: '',
          country: '',
          postalCode: '',
          administrativeArea: '',
          subAdministrativeArea: '',
          locality: '',
          subLocality: '',
          thoroughfare: '',
          subThoroughfare: '',
        ),
        latitude: -6.213020,
        longitude: 106.809166);
  }
}
