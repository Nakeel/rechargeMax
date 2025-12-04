import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, rootBundle;
import 'package:intl/intl.dart';

/// Utility class for miscellaneous operations that don't fit other categories.
abstract class MiscUtilities {
  /// Loads a text asset file from the app's assets folder.
  ///
  /// Example:
  ///   final jsonString = await MiscUtilities.loadAsset('data/config.json');
  static Future<String> loadAsset(String filename) async {
    return await rootBundle.loadString('assets/$filename');
  }

  /// Copies text to the system clipboard and shows a snackbar confirmation.
  ///
  /// Example:
  ///   MiscUtilities.copyToClipboard(context, "example@email.com",
  ///     toastMessage: "Email copied!");
  static Future<void> copyToClipboard(
    BuildContext context,
    String text, {
    String? toastMessage,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(toastMessage ?? 'Copied to clipboard'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error copying to clipboard: $e');
    }
  }

  /// Generates a random string of specified length using alphanumeric characters.
  ///
  /// Default length is 10.
  ///
  /// Example:
  ///   final uid = MiscUtilities.generateRandomUid(length: 16);
  ///   // → "abc1def2ghi3jkl4"
  static String generateRandomUid({int length = 10}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// Gets current time in milliseconds since epoch.
  ///
  /// Example:
  ///   final timestamp = MiscUtilities.currentTimeMillis();
  ///   // → 1630703400000
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Gets current DateTime as ISO 8601 string.
  ///
  /// Example:
  ///   final now = MiscUtilities.currentDateTime();
  ///   // → "2024-09-05 14:30:00.000"
  static String currentDateTime() {
    return DateTime.now().toString();
  }

  /// Formats currency value as Nigerian Naira (₦) with 2 decimal places.
  ///
  /// Example:
  ///   MiscUtilities.formatCurrency(1000.5) → "1,000.50"
  static String formatCurrency(num value) {
    return NumberFormat.currency(
      symbol: '',
      locale: 'en_NG',
      decimalDigits: 2,
    ).format(value);
  }
}

/// Extension on double for truncating decimal places.
extension TruncateDoubles on double {
  /// Truncates (not rounds) to specified decimal places.
  ///
  /// Example:
  ///   3.14159.truncateToDecimalPlaces(2) → 3.14
  double truncateToDecimalPlaces(int fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}
