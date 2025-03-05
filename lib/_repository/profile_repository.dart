import 'package:hive/hive.dart';
import 'package:kualiva/_data/model/minio/image_upload_model.dart';
import 'package:kualiva/_repository/minio_repository.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/main_hive.dart';

class ProfileRepository {
  ProfileRepository(this._dioClient, this._minioRepository);

  final DioClient _dioClient;
  final MinioRepository _minioRepository;

  Future<UserModel> me() async {
    final userBox = Hive.box<UserModel>(MyHive.user.name);

    // TODO masih kacau kadang data lama masih dipanggil meskipun sudah logout sehingga user profile masih null
    // if (userBox.values.toList().isNotEmpty) {
    //   final user = userBox.values.toList().first;
    //   LeLog.rd(this, me, user.toString());
    //   return user;
    // }

    final res = await _dioClient.dio().then((dio) {
      return dio.get('/profiles/me');
    });

    final data = UserModel.fromMap(res.data);
    await userBox.clear();
    await userBox.add(data);
    LeLog.rd(this, me, data.toString());
    return data;
  }

  Future<void> updateProfile({
    required String fullName,
    required DateTime birthDate,
    required String gender,
    required String photofile,
  }) async {
    String minioUserProfileImagePaths = "";

    try {
      final ImageUploadModel invoiceImageUpload =
          await _minioRepository.uploadImage(imagePath: photofile);

      minioUserProfileImagePaths = invoiceImageUpload.images[0].pathUrl;

      Map<String, dynamic> body = Map.from({
        "fullName": fullName,
        "birthDate": birthDate.toIso8601String(),
        "gender": gender,
        "photoFile": minioUserProfileImagePaths,
      });

      final _ = await _dioClient.dio().then((dio) {
        return dio.patch('/profiles/me', data: body);
      });
    } catch (e) {
      if (minioUserProfileImagePaths.isNotEmpty) {
        _minioRepository.deleteImage(fileName: minioUserProfileImagePaths);
      }
      rethrow;
    }
  }
}
