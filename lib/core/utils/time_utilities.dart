/// Utility class for time and duration calculations.
abstract class TimeUtilities {
  /// Calculates the duration between two DateTime objects.
  /// Returns Duration.zero if the end time is before the start time.
  ///
  /// Example:
  ///   final start = DateTime.now();
  ///   final end = start.add(Duration(hours: 2));
  ///   final remaining = TimeUtilities.calculateTimeRemaining(start, end);
  static Duration calculateTimeRemaining(DateTime startTime, DateTime endTime) {
    Duration difference = endTime.difference(startTime);

    if (difference.isNegative) {
      return Duration.zero;
    }

    return difference;
  }

  /// Checks if the current time has passed the given deadline.
  ///
  /// Returns false if [strDate] is null.
  ///
  /// Example:
  ///   final pastDate = DateTime.now().subtract(Duration(hours: 1));
  ///   TimeUtilities.hasTimePass(pastDate) → true
  static bool hasTimePass(DateTime? strDate) {
    try {
      if (strDate == null) {
        return false;
      }
      return DateTime.now().isAfter(strDate);
    } catch (e) {
      print('Error checking if time has passed: $e');
      return false;
    }
  }

  /// Gets the remaining time in seconds until the due date.
  /// Returns 0 if the due date has passed or an error occurs.
  ///
  /// Example:
  ///   final future = DateTime.now().add(Duration(hours: 1));
  ///   final seconds = TimeUtilities.getTimeLeft(future); // ~3600
  static int getTimeLeft(DateTime dueAt) {
    try {
      final currentTime = DateTime.now();
      return dueAt.difference(currentTime).inSeconds;
    } catch (e) {
      return 0;
    }
  }

  /// Gets the remaining days until the due date.
  /// Returns 0 if the due date has passed or an error occurs.
  ///
  /// Example:
  ///   final future = DateTime.now().add(Duration(days: 5));
  ///   final days = TimeUtilities.getDaysLeft(future); // 5
  static int getDaysLeft(DateTime dueAt) {
    try {
      final currentTime = DateTime.now();
      return dueAt.difference(currentTime).inDays;
    } catch (e) {
      return 0;
    }
  }

  /// Checks if the current time is between [createdAt] and [dueAt].
  /// Returns false if an error occurs.
  ///
  /// Example:
  ///   final start = DateTime.now().subtract(Duration(hours: 1));
  ///   final end = DateTime.now().add(Duration(hours: 1));
  ///   TimeUtilities.checkIfTimeNotExpired(start, end) → true
  static bool checkIfTimeNotExpired(DateTime createdAt, DateTime dueAt) {
    try {
      final currentTime = DateTime.now();
      return currentTime.isAfter(createdAt) && currentTime.isBefore(dueAt);
    } catch (e) {
      print('Error checking time expiration: $e');
      return false;
    }
  }
}
