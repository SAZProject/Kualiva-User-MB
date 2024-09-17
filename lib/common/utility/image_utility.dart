import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_it/common/utility/lelog.dart';
import 'package:like_it/common/widget/custom_snack_bar.dart';

class ImageUtility {
  final ImagePicker picker = ImagePicker();

  Future<List<XFile>> getMediaFromGallery(
      BuildContext context, List<XFile> listImage) async {
    try {
      List<XFile>? getRawMedia = await picker.pickMultiImage();
      List<XFile> temp = [];
      if (listImage.isEmpty) {
        if (getRawMedia.isNotEmpty) {
          List<XFile>? getMedia = [];
          for (XFile selectedRawMedia in getRawMedia) {
            XFile? newCompressImg = await _compressImage(selectedRawMedia);
            if (newCompressImg != null) getMedia.add(newCompressImg);
          }
          temp = getMedia;
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
          temp = [...listImage, ...getMedia];
        } else {}
      }
      return temp;
    } catch (e) {
      LeLog.pe(this, getMediaFromGallery, e.toString());
      if (!context.mounted) return Future<List<XFile>>.value([]);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "${"common.error".tr()} $e", Colors.red);
      return Future<List<XFile>>.value([]);
    }
  }

  Future<List<XFile>> getMediaFromCamera(
      BuildContext context, List<XFile> listImage) async {
    try {
      XFile? getRawMedia = await picker.pickImage(source: ImageSource.camera);
      List<XFile> temp = [];
      if (listImage.isEmpty) {
        if (getRawMedia != null) {
          XFile? newCompressImg = await _compressImage(getRawMedia);
          if (newCompressImg != null) {
            temp = [newCompressImg];
          } else {
            temp = [getRawMedia];
          }
        } else {
          temp = [];
        }
      } else {
        if (getRawMedia != null) {
          XFile? newCompressImg = await _compressImage(getRawMedia);
          if (newCompressImg != null) {
            temp = [...listImage, newCompressImg];
          } else {
            temp = [...listImage, getRawMedia];
          }
        } else {}
      }
      return temp;
    } catch (e) {
      LeLog.pe(this, getMediaFromCamera, e.toString());
      if (!context.mounted) return Future<List<XFile>>.value([]);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "${"common.error".tr()} $e", Colors.red);
      return Future<List<XFile>>.value([]);
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
}
