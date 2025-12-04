import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

/// Utility class for formatting and manipulating DateTime objects.
/// Handles various date/time formatting patterns and conversions.
abstract class DateTimeFormatter {
  /// Converts DateTime to local timezone.
  static DateTime convertToLocale(DateTime date) {
    return date.toLocal();
  }

  /// Formats as: "dd, M yyyy\nhh:mm am/pm"
  /// Example: "05, Sept 2024\n02:30 PM"
  static String convertDateFromServerToUI(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [dd, ', ', M, ' ', yyyy, '\n', hh, ':', nn, ' ', am],
    );
  }

  /// Formats as: "hh:mm am/pm"
  /// Example: "02:30 PM"
  static String convertDateFromServerToUITime(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [hh, ':', nn, ' ', am],
    );
  }

  /// Formats as: "yyyy-mm-dd"
  /// Example: "2024-09-05"
  static String convertDateFromServerToUI3(DateTime strDate) {
    try {
      return formatDate(
        convertToLocale(strDate),
        [yyyy, '-', mm, '-', dd],
      );
    } catch (e) {
      print(e);
      return '';
    }
  }

  /// Formats as: "dd/mm/yyyy"
  /// Example: "05/09/2024"
  static String convertDateFromServerToUI01(DateTime strDate) {
    try {
      return formatDate(
        convertToLocale(strDate),
        [dd, '/', mm, '/', yyyy],
      );
    } catch (e) {
      print(e);
      return '';
    }
  }

  /// Formats as: "D, dd M yyyy, hh:mm"
  /// Example: "Tue, 05 Sep 2024, 02:30"
  static String convertDateFromServerToUI4(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [D, ', ', dd, ' ', M, ' ', yyyy, ', ', hh, ':', nn],
    );
  }

  /// Formats as: "D, dd M yyyy"
  /// Example: "Tue, 05 Sep 2024"
  static String convertDateFromServerToUI15(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [D, ', ', dd, ' ', M, ' ', yyyy],
    );
  }

  /// Formats as: "dd. M. yyyy"
  /// Example: "05. Sep. 2024"
  static String convertDateFromServerToUI5(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [dd, '. ', M, '. ', yyyy],
    );
  }

  /// Formats as: "M dd, yyyy"
  /// Example: "Sep 05, 2024"
  static String convertDateFromServerToU5(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [M, ' ', dd, ', ', yyyy],
    );
  }

  /// Formats as: "yyyy-mm-dd"
  /// Example: "2024-09-05"
  static String convertDateFromServerToU15(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [yyyy, '-', mm, '-', dd],
    );
  }

  /// Formats as: "MM dd, yyyy"
  /// Example: "September 05, 2024"
  static String convertDateFromServerToUI6(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [MM, ' ', dd, ', ', yyyy],
    );
  }

  /// Formats as: "MM" (month name only)
  /// Example: "September"
  static String convertDateFromServerToMonth(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [MM],
    );
  }

  /// Formats as: "dd-mm-yyyy"
  /// Example: "05-09-2024"
  static String convertDateFromServerToUI2(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [dd, '-', mm, '-', yyyy],
    );
  }

  /// Converts from UI format back to server format: "yyyy-mm-dd"
  static String convertDateFromUIToServer(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [yyyy, '-', mm, '-', dd],
    );
  }

  /// Formats as timestamp: "yyyy-MM-dd HH:mm:ss"
  /// Example: "2024-09-05 14:30:45"
  static String convertDateToTimeStamp(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [yyyy, '-', MM, '-', dd, ' ', HH, ':', mm, ':', ss],
    );
  }

  /// Formats as WhatsApp style:
  /// - Today: "hh:mm am/pm"
  /// - Yesterday: "Yesterday"
  /// - Older: "yyyy-mm-dd"
  static String convertDateToWhatsappStyle(DateTime strDate) {
    try {
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime yesterday = today.subtract(const Duration(days: 1));

      final DateTime localDate = convertToLocale(strDate);

      if (isSameDate(localDate, today)) {
        return formatDate(localDate, [hh, ':', nn, ' ', am]);
      } else if (isSameDate(localDate, yesterday)) {
        return "Yesterday";
      } else {
        return formatDate(localDate, [yyyy, '-', mm, '-', dd]);
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  /// Formats as: "dd, M yyyy \n h:n am/pm"
  /// Example: "05, Sep 2024 \n 2:30 PM"
  static String convertDateTimeFromServerToUI(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [dd, ', ', M, ' ', yyyy, ' \n', h, ':', n, ' ', am],
    );
  }

  /// Formats as: "hh:mm am/pm" (time only)
  /// Example: "02:30 PM"
  static String convertToDateFromServerData(DateTime strDate) {
    return formatDate(
      convertToLocale(strDate),
      [hh, ':', nn, ' ', am],
    );
  }

  /// Checks if two dates are the same day.
  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Checks if the given date is today.
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Parses "MM/dd/yyyy" format string to DateTime using intl.
  static DateTime? parseMmDdYyyyWithIntl(String dateString) {
    try {
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      return formatter.parseStrict(dateString);
    } on FormatException catch (e) {
      print('Error parsing date with intl: ${e.message}');
      return null;
    } catch (e) {
      print('An unexpected error occurred during intl date parsing: $e');
      return null;
    }
  }

  /// Parses "MM/dd/yyyy" format string to DateTime.
  static DateTime? parseMmDdYyyy(String dateString) {
    try {
      List<String> parts = dateString.split('/');

      if (parts.length != 3) {
        print('Error: Invalid date string format. Expected MM/dd/yyyy.');
        return null;
      }

      int? month = int.tryParse(parts[0]);
      int? day = int.tryParse(parts[1]);
      int? year = int.tryParse(parts[2]);

      if (month == null || day == null || year == null) {
        print('Error: Date parts are not valid numbers.');
        return null;
      }

      if (month < 1 || month > 12 || day < 1 || day > 31) {
        print('Error: Month or day out of valid range.');
        return null;
      }

      return DateTime(year, month, day);
    } catch (e) {
      print('An unexpected error occurred during date parsing: $e');
      return null;
    }
  }

  /// Extracts month and year from "MM/YY" format.
  /// Returns a map with 'month' and 'year' keys.
  static Map<String, String> getMonthAndYear(String mmYY) {
    List<String> parts = mmYY.split('/');

    if (parts.length != 2) {
      throw const FormatException('Invalid date format. Please use MM/YY format.');
    }

    return {
      'month': parts[0],
      'year': parts[1],
    };
  }
}
