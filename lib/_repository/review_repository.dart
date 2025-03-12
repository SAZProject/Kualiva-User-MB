import 'package:kualiva/_data/model/minio/image_upload_model.dart';
import 'package:kualiva/_repository/minio_repository.dart';

import 'package:hive/hive.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/review/enum/review_order_enum.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';

import 'package:kualiva/main_hive.dart';
import 'package:kualiva/review/model/review_filter_model.dart';
import 'package:kualiva/review/model/review_place_model.dart';

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
    /// TODO Schema ini tidak detect ketika melakukan delete secara local dan kirim ke Minio.
    /// Model harusnya menyimpan cth: photoFiles sudah di masukin base url minio dan photoFilesOriginal hanya path nya saja

    final List<String> photoFilesFromMobile = [];
    final List<String> photoFilesFromServer = [];

    String? minioInvoiceImagePaths = invoiceFile;
    final List<String> minioReviewImagePaths = [];

    LeLog.rd(this, createOrUpdate, photoFiles.toString());

    for (String photo in photoFiles) {
      if (photo.contains('http') || photo.contains('https')) {
        final minioPathList = photo.split('/').reversed.toList();
        final minioPath = '/${minioPathList[1]}/${minioPathList[0]}';
        photoFilesFromServer.add(minioPath);
      } else {
        photoFilesFromMobile.add(photo);
      }
    }
    LeLog.rd(this, createOrUpdate, invoiceFile.toString());
    try {
      if (invoiceFile != null &&
          (!invoiceFile!.contains('http') || !invoiceFile!.contains('https'))) {
        LeLog.d(this, invoiceFile.toString());
        final ImageUploadModel invoiceImageUpload =
            await _minioRepository.uploadImage(imagePath: invoiceFile!);

        minioInvoiceImagePaths = invoiceImageUpload.images[0].pathUrl;
      }

      if (photoFilesFromMobile.isNotEmpty) {
        final ImageUploadModel reviewImageUpload = await _minioRepository
            .uploadImages(imagePathList: photoFilesFromMobile);

        minioReviewImagePaths.addAll(
            reviewImageUpload.images.map((image) => image.pathUrl).toList());
      }

      minioReviewImagePaths.addAll(photoFilesFromServer);

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
      if (minioInvoiceImagePaths != null && minioInvoiceImagePaths.isNotEmpty) {
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
    required bool isRefreshed,
    required String placeId,
    String? description,
    bool? withMedia,
    int? rating,
    ReviewSelectedUserEnum? selectedUser,
    ReviewOrderEnum? order,
  }) async {
    // final reviewPlaceBox = Hive.box<ReviewPlaceModel>(MyHive.reviewPlace.name);

    // if (reviewPlaceBox.values.toList().isNotEmpty) {
    //   final reviewPlaceList = reviewPlaceBox.values.toList();
    //   LeLog.rd(this, otherReviewGetByPlace, reviewPlaceList.toString());
    //   return reviewPlaceList;
    // }

    final query = Map<String, dynamic>.from({});
    if (description != null) query['description'] = description;
    if (withMedia != null) query['withMedia'] = withMedia;
    if (rating != null) query['rating'] = rating;
    if (selectedUser != null) query['selectedUser'] = selectedUser.value;
    if (order != null) query['order'] = order.value;

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/reviews/$placeId/place',
        queryParameters: query,
      );
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

  Future<ReviewFilterModel?> getFilter() async {
    final reviewFilterBox =
        Hive.box<ReviewFilterModel>(MyHive.reviewFilter.name);

    if (reviewFilterBox.values.toList().isNotEmpty) {
      final reviewFilter = reviewFilterBox.values.first;
      LeLog.rd(this, getFilter, reviewFilter.toString());
      return reviewFilter;
    }

    return null;
  }

  Future<int> deleteFilter() async {
    final reviewFilterBox =
        Hive.box<ReviewFilterModel>(MyHive.reviewFilter.name);
    return reviewFilterBox.clear();
  }

  Future<ReviewFilterModel> addFilter({
    String? description,
    ReviewSelectedUserEnum? selectedUser,
    bool? withMedia,
    int? rating,
    ReviewOrderEnum? order,
  }) async {
    final reviewFilterBox =
        Hive.box<ReviewFilterModel>(MyHive.reviewFilter.name);

    final reviewFilter = ReviewFilterModel(
      description: description,
      selectedUser: selectedUser,
      withMedia: withMedia,
      rating: rating,
      order: order,
    );

    await deleteFilter();

    await reviewFilterBox.add(reviewFilter);
    return reviewFilterBox.values.first;
  }
}
