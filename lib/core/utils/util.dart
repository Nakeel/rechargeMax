
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, PlatformException, rootBundle;
import 'package:intl/intl.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

abstract class Util {


  static Future<String> loadAsset(String filename) async {
    return await rootBundle.loadString('assets/$filename');
  }

  static Image imageFromBase64String(String base64String, BuildContext context) {
    try{
    return Image.memory(base64Decode(base64String), colorBlendMode: BlendMode.color, color: Theme.of(context).primaryColor,);
        }catch(e){
      return Image.asset('assets/images/v2Imgs/scanart.png',);
    }
  }

  // static  String getInitials(String name) {
  //  try{
  //    final parts = name.trim().split(' ');
  //    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
  //    return parts
  //        .take(2)
  //        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
  //        .join();
  //  }catch(e){
  //    return 'UA';
  //  }
  // }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  // Static method to get truncated content based on the percentage
  static String getTruncatedContent(String content, {double percent = 0.3}) {
    try {
      List<String> words = content.split(' ');
      int wordCount = (words.length * percent).ceil();
      return words.length > wordCount
          ? '${words.take(wordCount).join(' ')}...'
          : content;
    } catch (e) {
      print('Error at getting truncated content ${e.toString()}');
      return content;
    }
  }

  static  void copyToClipboard(BuildContext context, String text, {String? toastMessage}) async {
    await Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(toastMessage ?? 'Copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Map<String, String> getMonthAndYear(String mmYY) {
    // Split the MM/YY string by the '/'
    List<String> parts = mmYY.split('/');

    // Ensure the string is correctly formatted
    if (parts.length != 2) {
      throw const FormatException('Invalid date format. Please use MM/YY format.');
    }

    // Extract the month and year
    String month = parts[0];
    String year = parts[1];

    return {
      'month': month,
      'year': year,
    };
  }

  static bool areNamesSimilar(String nameA, String nameB) {
    // Split the names into lists of components
    List<String> nameAComponents = nameA.split(' ');
    List<String> nameBComponents = nameB.split(' ');

    // Convert the lists to sets
    Set<String> nameASet = nameAComponents.toSet();
    Set<String> nameBSet = nameBComponents.toSet();

    // Find the intersection of the sets
    Set<String> intersection = nameASet.intersection(nameBSet);

    // Check if the size of the intersection is at least 2
    return intersection.length >= 2;
  }


  static String generateRandomUid({int length = 10}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }


  static Duration calculateTimeRemaining(DateTime startTime, DateTime endTime) {
    Duration difference = endTime.difference(startTime);

    // Print debug information
    print('startTime Remaining $startTime');
    print('endDate Remaining $endTime');

    // If the difference is negative, return a zero-duration
    if (difference.isNegative) {
      return Duration.zero;
    }

    return difference;
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static String currentDateTime() {
    return new DateTime.now().toString();
  }

  static String convertDateFromServerToUI(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [dd, ', ', M, ' ', yyyy, '\n', hh, ':', nn, ' ', am]);
    // hh:mm a
  }

  static String convertDateFromServerToUITime(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [hh, ':', nn, ' ', am]);
    // hh:mm a
  }

  static String convertDateFromServerToUI3(DateTime strDate) {
    try {
      return formatDate(
          convertToLocale(strDate), [ yyyy, '-', mm, '-', dd]);
    }catch(e){
      print(e);
      return '';
    }
    // hh:mm a
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String convertDateToWhatsappStyle(DateTime strDate) {
    try {
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime yesterday = today.subtract(const Duration(days: 1));

      final DateTime localDate = convertToLocale(strDate);

      if (isSameDate(localDate, today)) {
        return formatDate(
            convertToLocale(strDate), [ hh, ':', nn, ' ', am]);
      } else if (isSameDate(localDate, yesterday)) {
        return "Yesterday";
      } else {
        return formatDate(
            convertToLocale(strDate), [ yyyy, '-', mm, '-', dd]);
      }
    } catch (e) {
      print(e);
      return '';
    }
  }



  static String convertDateFromServerToUI01(DateTime strDate) {
    try {
      return formatDate(
          convertToLocale(strDate), [ dd, '/', mm, '/', yyyy]);
    }catch(e){
      print(e);
      return '';
    }
    // hh:mm a
  }

  static Future<Uint8List?> imageFromAssets(String path) async {
    try {
      ByteData byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List();
    }catch(e){
      AppLogger.info('Error at imageFromAssets ${e}');
      return null;
    }
  }

  static bool validateEmail(String value) {
    final val = value.trim();
    if (val.isEmpty) return false;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (regex.hasMatch(val));
  }

  static String convertDateFromServerToUI4(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [ D, ', ', dd, ' ', M, ' ',yyyy, ', ', hh, ':', nn]);
    // hh:mm a
  }
  // 'Tue, 28 Jun 2020, 18:49',


  static String convertDateFromServerToUI15(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [ D, ', ', dd, ' ', M, ' ',yyyy, ]);
    // hh:mm a
  }
  // 'Tue, 28 Jun 2020',

  static String convertDateToTimeStamp(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [ yyyy, '-',MM, '-', dd, ' ', HH, ':', mm ,':', ss]);
    // hh:mm a
  }

  static bool hasTimePass(DateTime? strDate) {
    try {
      if(strDate==null){
        return false;
      }
      return DateTime.now().isAfter(strDate);
    }catch(e){
      print('Error getting current time $e');
      return false;
    }
  }

  //Format------05. Sept. 2018
  static String convertDateFromServerToUI5(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [ dd, '. ', M, '. ',yyyy]);
    // hh:mm a
  }

  //Format------  Aug 01, 2024
  static String convertDateFromServerToU5(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [M,' ', dd, ', ',  yyyy]);
    // hh:mm a
  }

  //Format------  2001-01-31
  static String convertDateFromServerToU15(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [yyyy,'-', mm, '-',  dd]);
    // hh:mm a
  }


  //Format------January 05, 2018
  static String convertDateFromServerToUI6(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [  MM,' ', dd,  ', ',yyyy]);
    // hh:mm a
  }


  //Format------January 05, 2018
  static String convertDateFromServerToMonth(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [  MM,]);
    // hh:mm a
  }

  static DateTime? parseMmDdYyyyWithIntl(String dateString) {
    try {
      // Define the expected date format
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      // Parse the string
      return formatter.parseStrict(dateString);
    } on FormatException catch (e) {
      print('Error parsing date with intl: ${e.message}');
      return null;
    } catch (e) {
      print('An unexpected error occurred during intl date parsing: $e');
      return null;
    }
  }

  static DateTime? parseMmDdYyyy(String dateString) {
    try {
      // Split the string by '/'
      List<String> parts = dateString.split('/');

      // Ensure there are exactly three parts (month, day, year)
      if (parts.length != 3) {
        print('Error: Invalid date string format. Expected MM/dd/yyyy.');
        return null;
      }

      // Parse each part to an integer
      int? month = int.tryParse(parts[0]);
      int? day = int.tryParse(parts[1]);
      int? year = int.tryParse(parts[2]);

      // Check if all parts were successfully parsed and are valid numbers
      if (month == null || day == null || year == null) {
        print('Error: Date parts are not valid numbers.');
        return null;
      }

      // Basic validation for month and day ranges
      if (month < 1 || month > 12 || day < 1 || day > 31) {
        print('Error: Month or day out of valid range.');
        return null;
      }

      // Create and return the DateTime object
      return DateTime(year, month, day);
    } catch (e) {
      // Catch any unexpected errors during parsing
      print('An unexpected error occurred during date parsing: $e');
      return null;
    }
  }

  static String getFileNameFromUrl(String url) {
   try{
     // Decode the URL to handle any special characters
     String decodedUrl = Uri.decodeComponent(url);

     // Get the last segment of the URL which is the file name
     String fileName = decodedUrl.split('/').last;

     // Replace '+' with a space
     String cleanedFileName = fileName.replaceAll('+', ' ');

     return cleanedFileName;
   }catch(e){
     return url;
   }
  }

  static String formatCurrency(num value) {
    return NumberFormat.currency(symbol: '', locale: 'en_NG', decimalDigits: 2).format(value);
  }

  static String convertDateFromServerToUI2(DateTime strDate) {
    return formatDate(convertToLocale(strDate), [dd, '-', mm, '-', yyyy]);
  }

  static String convertDateFromUIToServer(DateTime strDate) {
    return formatDate(convertToLocale(strDate), [yyyy, '-', mm, '-', dd]);
  }

  static bool checkIfTimeNotExpired(DateTime createdAt, DateTime dueAt) {
    try {
      final currentTime = DateTime.now();

      return currentTime.isAfter(createdAt) && currentTime.isBefore(dueAt);
    }catch(e){
      print(' $e');
      return false;
    }
  }

  static int getTimeLeft( DateTime dueAt) {
    try {
      final currentTime = DateTime.now();
      return dueAt
          .difference(currentTime)
          .inSeconds;
    }catch(e){
      return 0;
    }
  }
  static int getDaysLeft( DateTime dueAt) {
    try {
      final currentTime = DateTime.now();
      return dueAt
          .difference(currentTime)
          .inDays;
    }catch(e){
      return 0;
    }
  }

  static List<String> getImagesBase64(List<File> files){
    try{
      return files.map((file) {
       return convertImageToBase64(file);
      }).toList();
    }catch(e){
      return [];
    }
  }

  static String convertImageToBase64(File file){
    try{
      List<int> fileBytes = file.readAsBytesSync();
      String base64String = base64Encode(fileBytes);
      return base64String;
    }catch(e){
      return '';
    }
  }

  static String convertDateTimeFromServerToUI(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [dd, ', ', M, ' ', yyyy, ' \n', h, ':', n, ' ', am]);
  }


  static String convertToDateFromServerData(DateTime strDate) {
    return formatDate(
        convertToLocale(strDate), [ hh, ':', nn, ' ', am]);
  }

  static String getInitials(String userFullname) {
   try{
     List<String> names = userFullname.split(" ");
     names.removeWhere((e) => e=="");
     String initials = "";
     int numWords = 2;

     if(names.length.toString() !="1") {
       if (numWords < names.length) {
         numWords = names.length;
       }
       for (var i = 0; i < numWords; i++) {
         initials += '${names[i][0]}';
       }

     }else{
       List<String> firstName = names[0].split("");
       initials = firstName.length>1 ? firstName[0]+firstName[1] : firstName[0];
     }
     return initials.toUpperCase();
   }catch(e){
     return userFullname.split('').first;
   }
  }


  // convert it to local
  static DateTime convertToLocale(DateTime date){
   return date.toLocal();
  }

  static TextSpan getHighlightedText(String item, String query) {
    List<TextSpan> spans = [];
    if (query.isEmpty) {
      return TextSpan(text: item, style: const TextStyle(color: Colors.black));
    }

    int start = 0;
    query = query.toLowerCase();
    while (start < item.length) {
      int matchStart = item.toLowerCase().indexOf(query, start);

      if (matchStart == -1) {
        // No more matches, add the rest of the string
        spans.add(TextSpan(
            text: item.substring(start),
            style: const TextStyle(color: AppColors.colorBlack, fontSize: 14, fontWeight: FontWeight.w300)));
        break;
      }

      // Add the non-matching part before the match
      if (matchStart > start) {
        spans.add(TextSpan(
            text: item.substring(start, matchStart),
            style: const TextStyle(color: AppColors.colorBlack, fontSize: 14, fontWeight: FontWeight.w300)));
      }

      // Add the matched part in bold
      int matchEnd = matchStart + query.length;
      spans.add(TextSpan(
        text: item.substring(matchStart, matchEnd),
        style: const TextStyle(color: AppColors.colorBlack, fontSize: 14, fontWeight: FontWeight.w500),
      ));

      start = matchEnd;
    }

    return TextSpan(children: spans);
  }

  /// Adds "+234" to a phone number, removes the leading zero if present,
  /// and ensures "+234" is not added if it already exists.
  /// Returns null if the input is invalid (null, empty, or non-numeric after cleaning).
  static String? formatPhoneNumberWithCountryCode(String? input) {
    if (input == null || input.trim().isEmpty) {
      return null;
    }

    // Remove any non-numeric characters (e.g., spaces, dashes)
    String cleaned = input.replaceAll(RegExp(r'[^0-9+]'), '');

    // Check if already starts with "+234"
    if (cleaned.startsWith('+234')) {
      return cleaned; // Return as is if it already has "+234"
    }

    // Remove leading zero if present
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    // Add "+234" and return
    return '+234$cleaned';
  }

  /// Strips "+234" or the leading zero from a phone number.
  /// Returns null if the input is invalid (null, empty, or non-numeric after cleaning).
  static String? stripPhoneNumberPrefix(String? input) {
    if (input == null || input.trim().isEmpty) {
      return null;
    }

    // Remove any non-numeric characters (e.g., spaces, dashes)
    String cleaned = input.replaceAll(RegExp(r'[^0-9+]'), '');

    // Remove "+234" if present
    if (cleaned.startsWith('+234')) {
      return cleaned.substring(4);
    }

    // Remove leading zero if present
    if (cleaned.startsWith('0')) {
      return cleaned.substring(1);
    }

    // Return cleaned number if no prefix to strip
    return cleaned;
  }

}





extension TruncateDoubles on double {
  double truncateToDecimalPlaces(int fractionalDigits) => (this * pow(10,
      fractionalDigits)).truncate() / pow(10, fractionalDigits);
}
