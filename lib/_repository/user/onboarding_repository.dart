import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/common/utility/lelog.dart';

class OnboardingRepository {
  OnboardingRepository(this._dioClient);

  final DioClient _dioClient;

  Future<void> onboardingVerifyingUse({
    required String fullName,
    required DateTime birthDate,
  }) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post('/profile', data: {
        "fullName": fullName,
        "birthDate": birthDate.toIso8601String(),
      });
    });
    LeLog.rd(this, onboardingVerifyingUse, "User Profile Created");
  }
}
