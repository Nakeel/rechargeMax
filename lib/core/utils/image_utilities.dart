import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recharge_max/core/utils/app_logger.dart';

/// Utility class for handling image operations including Base64 encoding/decoding.
abstract class ImageUtilities {
  /// Converts Base64 string to Image widget with fallback to placeholder on error.
  static Image imageFromBase64String(String base64String, BuildContext context) {
    try {
      return Image.memory(
        base64Decode(base64String),
        colorBlendMode: BlendMode.color,
        color: Theme.of(context).primaryColor,
      );
    } catch (e) {
      return Image.asset('assets/images/v2Imgs/scanart.png');
    }
  }

  /// Converts Base64 string to Uint8List.
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  /// Converts Uint8List to Base64 string.
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  /// Loads an image asset from the app's assets folder.
  /// Returns the raw bytes of the image.
  ///
  /// Example:
  ///   final bytes = await ImageUtilities.imageFromAssets('images/logo.png');
  static Future<Uint8List?> imageFromAssets(String path) async {
    try {
      ByteData byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List();
    } catch (e) {
      AppLogger.info('Error at imageFromAssets: $e');
      return null;
    }
  }

  /// Converts a File to Base64 string.
  ///
  /// Example:
  ///   final base64 = ImageUtilities.convertImageToBase64(imageFile);
  static String convertImageToBase64(File file) {
    try {
      List<int> fileBytes = file.readAsBytesSync();
      return base64Encode(fileBytes);
    } catch (e) {
      AppLogger.info('Error converting image to Base64: $e');
      return '';
    }
  }

  /// Converts a list of Files to their Base64 string representations.
  ///
  /// Returns an empty list if any error occurs.
  static List<String> getImagesBase64(List<File> files) {
    try {
      return files.map((file) => convertImageToBase64(file)).toList();
    } catch (e) {
      AppLogger.info('Error converting images to Base64: $e');
      return [];
    }
  }
}
