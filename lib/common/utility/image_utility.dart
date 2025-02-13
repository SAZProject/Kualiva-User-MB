import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kualiva/common/widget/custom_snack_bar.dart';

extension ImageTypeExtension on String {
  ImageType get imagetype {
    if (startsWith("http") || startsWith("https")) {
      return ImageType.network;
    } else if (endsWith(".svg")) {
      return ImageType.svg;
    } else if (startsWith("file://")) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

class ImageUtility {
  final ImagePicker picker = ImagePicker();

  Future<List<String>> getSingleMediaFromGallery(
      BuildContext context, List<String> listImage) async {
    try {
      XFile? getRawMedia = await picker.pickImage(source: ImageSource.gallery);
      List<String> temp = [];
      if (getRawMedia != null) {
        XFile? newCompressImg = await _compressImage(getRawMedia);
        if (newCompressImg != null) {
          temp.add(newCompressImg.path);
        } else {
          temp.add(getRawMedia.path);
        }
      } else {
        temp = [];
      }
      return temp;
    } catch (e) {
      if (!context.mounted) return Future<List<String>>.value([]);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "${"common.error".tr()} $e", Colors.red);
      return Future<List<String>>.value([]);
    }
  }

  Future<List<String>> getMultipleMediaFromGallery(
      BuildContext context, List<String> listImage,
      {int? limit}) async {
    try {
      List<XFile>? getRawMedia = await picker.pickMultiImage(limit: limit);
      List<String> temp = [];
      if (listImage.isEmpty) {
        if (getRawMedia.isNotEmpty) {
          List<XFile>? getMedia = [];
          for (XFile selectedRawMedia in getRawMedia) {
            XFile? newCompressImg = await _compressImage(selectedRawMedia);
            if (newCompressImg != null) getMedia.add(newCompressImg);
          }
          for (var media in getMedia) {
            temp.add(media.path);
          }
        } else {
          temp = [];
        }
      } else {
        if (getRawMedia.isNotEmpty) {
          List<XFile>? getMedia = [];
          for (XFile selectedRawMedia in getRawMedia) {
            XFile? newCompressImg = await _compressImage(selectedRawMedia);
            if (newCompressImg != null) getMedia.add(newCompressImg);
          }
          temp = [
            ...listImage,
            ...List.generate(
              getMedia.length,
              (index) => getMedia[index].path,
            )
          ];
        } else {
          return listImage;
        }
      }
      return temp;
    } catch (e) {
      if (!context.mounted) return Future<List<String>>.value([]);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "${"common.error".tr()} $e", Colors.red);
      return Future<List<String>>.value([]);
    }
  }

  Future<List<String>> getMediaFromCamera(
      BuildContext context, List<String> listImage) async {
    try {
      XFile? getRawMedia = await picker.pickImage(source: ImageSource.camera);
      List<String> temp = [];
      if (listImage.isEmpty) {
        if (getRawMedia != null) {
          XFile? newCompressImg = await _compressImage(getRawMedia);
          if (newCompressImg != null) {
            temp = [newCompressImg.path];
          } else {
            temp = [getRawMedia.path];
          }
        } else {
          temp = [];
        }
      } else {
        if (getRawMedia != null) {
          XFile? newCompressImg = await _compressImage(getRawMedia);
          if (newCompressImg != null) {
            temp = [...listImage, newCompressImg.path];
          } else {
            temp = [...listImage, getRawMedia.path];
          }
        } else {
          return listImage;
        }
      }
      return temp;
    } catch (e) {
      if (!context.mounted) return Future<List<String>>.value([]);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "${"common.error".tr()} $e", Colors.red);
      return Future<List<String>>.value([]);
    }
  }

  Future<XFile?> _compressImage(XFile file) async {
    final filePath = File(file.path).absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  ImageProvider<Object>? getImageType(String imagePath) {
    switch (imagePath.imagetype) {
      case ImageType.network:
        return NetworkImage(imagePath);
      case ImageType.file:
      case ImageType.png:
      default:
        return FileImage(File(imagePath));
    }
  }
}
