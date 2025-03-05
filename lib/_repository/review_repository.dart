import 'package:kualiva/_data/model/minio/image_upload_model.dart';
import 'package:kualiva/_repository/minio_repository.dart';

// import 'package:hive/hive.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';

// import 'package:kualiva/main_hive.dart';
import 'package:kualiva/review/model/review_place_model.dart';

// AuthorId
// cm3d0h52q0000qtfl1aoq65b8

class ReviewRepository {
  ReviewRepository(this._dioClient, this._minioRepository);

  final DioClient _dioClient;
  final MinioRepository _minioRepository;

  String? placeUniqueId;
  PlaceCategoryEnum? placeCategory;
  String? invoice;
  String? invoiceFile;

  void tempCreateOrUpdate(
    String placeUniqueId,
    PlaceCategoryEnum placeCategory,
    String invoice,
    String invoiceFile,
  ) {
    this.placeUniqueId = placeUniqueId;
    this.placeCategory = placeCategory;
    this.invoice = invoice;
    this.invoiceFile = invoiceFile;
    LeLog.rd(this, tempCreateOrUpdate,
        "$placeUniqueId | $placeCategory | $invoice | $invoiceFile");
  }

  /// Add Reviews by Place
  Future<String> createOrUpdate({
    int? reviewId,
    required bool isCreated,
    required String description,
    required double rating,
    required List<String> photoFiles,
  }) async {
    String minioInvoiceImagePaths = "";
    final List<String> minioReviewImagePaths = [];

    try {
      if (invoiceFile != null) {
        LeLog.d(this, invoiceFile.toString());
        final ImageUploadModel invoiceImageUpload =
            await _minioRepository.uploadImage(imagePath: invoiceFile!);

        minioInvoiceImagePaths = invoiceImageUpload.images[0].pathUrl;
      }

      final ImageUploadModel reviewImageUpload =
          await _minioRepository.uploadImages(imagePathList: photoFiles);

      minioReviewImagePaths.addAll(
          reviewImageUpload.images.map((image) => image.pathUrl).toList());

      Map<String, dynamic> body = Map.from({
        "placeUniqueId": placeUniqueId,
        "placeCategory": placeCategory!.name,
        "invoice": invoice,
        "description": description,
        "invoiceFile": minioInvoiceImagePaths,
        "rating": rating,
        "photoFiles": minioReviewImagePaths,
      });
      if (isCreated == true) {
        final _ = await _dioClient.dio().then((dio) {
          return dio.post('/reviews', data: body);
        });
      } else {
        final _ = await _dioClient.dio().then((dio) {
          return dio.patch('/reviews/${reviewId!}', data: body);
        });
      }
      final temp = placeUniqueId ?? '';
      placeUniqueId = placeCategory = invoice = invoiceFile = null;

      return temp;
    } catch (e) {
      if (minioInvoiceImagePaths.isNotEmpty) {
        _minioRepository.deleteImage(fileName: minioInvoiceImagePaths);
      }
      if (minioReviewImagePaths.isNotEmpty) {
        _minioRepository.deleteImages(fileNameList: minioReviewImagePaths);
      }
      rethrow;
    }
  }

  /// get other Reviews by Place / Merchant
  Future<List<ReviewPlaceModel>> otherReviewGetByPlace({
    required String placeId,
  }) async {
    // final reviewPlaceBox =
    //     Hive.box<ReviewPlaceModel>(MyHive.reviewPlaceModel.name);

    // if (reviewPlaceBox.values.toList().isNotEmpty) {
    //   final reviewPlaceList = reviewPlaceBox.values.toList();
    //   LeLog.rd(this, getByPlace, reviewPlaceList.toString());
    //   return reviewPlaceList;
    // }

    final res = await _dioClient.dio().then((dio) {
      return dio.get('/reviews/$placeId/place');
    });

    final data = (res.data as List<dynamic>)
        .map((e) => ReviewPlaceModel.fromMap(e))
        .toList();
    // reviewPlaceBox.addAll(data);
    LeLog.rd(this, otherReviewGetByPlace, data.toString());
    return data;
  }

  /// get my Reviews by Place / Merchant
  Future<ReviewPlaceModel> myReviewGetByPlace({
    required String placeId,
  }) async {
    // final reviewPlaceBox =
    //     Hive.box<ReviewPlaceModel>(MyHive.reviewPlaceModel.name);

    // if (reviewPlaceBox.values.toList().isNotEmpty) {
    //   final reviewPlaceList = reviewPlaceBox.values.toList();
    //   LeLog.rd(this, getByPlace, reviewPlaceList.toString());
    //   return reviewPlaceList;
    // }

    final res = await _dioClient.dio().then((dio) {
      return dio.get('/reviews/$placeId/place/me');
    });

    final data = ReviewPlaceModel.fromMap(res.data);
    LeLog.rd(this, myReviewGetByPlace, data.toString());
    return data;
  }

  /// Review Place Search Text
  Future<void> getBySearchText({required String text}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.get(
        '/',
        queryParameters: Map.from(
          {'text': text},
        ),
      );
    });
    return;
  }

  /// Review Add Like
  Future<void> addLike({required int reviewId}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post('/reviews/$reviewId/like/add');
    });
    return;
  }

  /// Review Remove Like
  Future<void> removeLike({required int reviewId}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.delete('/reviews/$reviewId/like/remove');
    });
    return;
  }
}
