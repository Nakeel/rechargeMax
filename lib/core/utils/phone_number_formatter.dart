/// Utility class for formatting and validating phone numbers.
abstract class PhoneNumberFormatter {
  /// Adds "+234" to a phone number, removes the leading zero if present,
  /// and ensures "+234" is not added if it already exists.
  /// Returns null if the input is invalid (null, empty, or non-numeric after cleaning).
  ///
  /// Examples:
  ///   "08012345678" → "+2348012345678"
  ///   "+2348012345678" → "+2348012345678"
  ///   "invalid" → null
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
  ///
  /// Examples:
  ///   "+2348012345678" → "8012345678"
  ///   "08012345678" → "8012345678"
  ///   "+234" → null
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
