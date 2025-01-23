import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/auth/model/user_profile_model.dart';

class ProfileFaker {
  static UserModel me() {
    return UserModel(
      id: '1',
      username: 'JohnDoe99',
      email: 'johndoe@gmail.com',
      phone: '081234567899',
      isAdult: true,
      isEmailVerified: true,
      isPhoneVerified: true,
      isGoogle: false,
      createdAt: DateTime.now(),
      profile: UserProfileModel(
        id: '1',
        firstname: 'John Doe',
        lastname: 'Doe',
        gender: 'MALE',
        birthDate: DateTime.parse('20010516'),
      ),
    );
  }
}
