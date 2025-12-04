import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// A reusable currency formatter that supports decimals.
///
/// * `locale` – e.g. 'en_US', 'en_NG'
/// * `symbol` – e.g. '$', '₦', '€'
/// * `decimalDigits` – set to 0 for whole‑value currencies
class CurrencyTextInputFormatter extends TextInputFormatter {
  CurrencyTextInputFormatter({
    this.locale = 'en_US',
    this.decimalDigits = 2,
  }) : _format = NumberFormat.currency(
    locale: locale,
    decimalDigits: decimalDigits,
  );

  final String locale;
  final int decimalDigits;
  final NumberFormat _format;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove every character except digits
    final rawDigits =
    newValue.text.replaceAll(RegExp('[^0-9]'), '');

    if (rawDigits.isEmpty) {
      // Keep empty → let the field clear
      return newValue.copyWith(text: '');
    }

    // Always treat the raw string as the *minor* currency unit:
    //   1234 (cents) → 12.34 (dollars)
    final num parsed = int.parse(rawDigits) /
        (pow(10, decimalDigits));

    final formatted = _format.format(parsed);

    // Place cursor at the end of the new string
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}


class AmountInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat;

  /// Creates an [AmountInputFormatter] with the given [locale] and [symbol].
  /// For example, locale "en_US" and symbol "\$" for US dollars.
  AmountInputFormatter({String locale = 'en_NG', String? symbol})
      : _currencyFormat = NumberFormat.currency(locale: locale, symbol: symbol ?? '');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If new value is empty, just return it
    if (newValue.text.trim().isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Remove all non-digit and non-decimal characters
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // --- NEW LOGIC START ---
    // Handle cases where the input is effectively zero or meant to be cleared
    // This allows deleting "0.00" to an empty string
    if (numericString.isEmpty || numericString == '.' || double.tryParse(numericString) == null) {
      // If it's empty, or just a decimal, or unparseable, return empty
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final double parsedValue = double.parse(numericString);

    // If the parsed value is exactly 0.0 and the user is trying to delete,
    // or if the original value was 0.0 and the new value is still 0.0,
    // treat it as an attempt to clear.
    // We add a small epsilon to handle floating point inaccuracies for near-zero values.
    const double epsilon = 0.00001; // A small value to check against zero

    // Check if the old value was effectively zero and the new value is still effectively zero
    // after parsing. This catches the 0.00 -> 0.0 -> 0. -> "" deletion flow.
    double? oldParsedValue;
    try {
      // Attempt to parse old value's numeric string, if not empty
      String oldNumericString = oldValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
      if (oldNumericString.isNotEmpty && double.tryParse(oldNumericString) != null) {
        oldParsedValue = double.parse(oldNumericString);
      }
    } catch (e) {
      // Ignore parsing errors for oldValue
    }

    final bool wasOldValueZero = oldParsedValue != null && oldParsedValue.abs() < epsilon;
    final bool isNewValueZero = parsedValue.abs() < epsilon;

    // If the new value is effectively zero, and either the old value was also zero
    // or the new selection indicates a deletion (i.e., new text is shorter or cursor moved back)
    // then allow it to become empty.
    if (isNewValueZero) {
      // More robust check: if the new value is 0 and it's not the initial input (i.e., it's a deletion)
      // or if it's explicitly "0", "0.", "0.0" etc., then allow it to clear.
      if (newValue.text == _currencyFormat.format(0.0) || // If it's already a formatted zero
          newValue.text.replaceAll(RegExp(r'[^0-9]'), '') == '0' || // contains only '0' after stripping
          newValue.text.replaceAll(RegExp(r'[^0-9.]'), '') == '0.' || // contains '0.' after stripping
          newValue.text.replaceAll(RegExp(r'[^0-9.]'), '') == '0.0') { // contains '0.0' after stripping
        return const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    }

    // --- NEW LOGIC END ---


    // Only allow one decimal point
    if ('.'.allMatches(numericString).length > 1) {
      int firstDecimal = numericString.indexOf('.');
      numericString = numericString.substring(0, firstDecimal + 1) +
          numericString.substring(firstDecimal + 1).replaceAll('.', '');
    }

    // Reparse after potential decimal correction
    final double value = double.parse(numericString);
    final String formatted = _currencyFormat.format(value);

    // Calculate caret position
    int digitsBeforeCursor = 0;
    for (int i = 0; i < newValue.selection.extentOffset && i < newValue.text.length; i++) {
      if (RegExp(r'[0-9.]').hasMatch(newValue.text[i])) {
        digitsBeforeCursor++;
      }
    }

    int caretPosition = 0;
    int digitCount = 0;
    while (caretPosition < formatted.length && digitCount < digitsBeforeCursor) {
      if (RegExp(r'[0-9.]').hasMatch(formatted[caretPosition])) {
        digitCount++;
      }
      caretPosition++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: caretPosition),
    );
  }

  double? unformatToDouble(String formattedString, {String locale = 'en_NG', String? symbol}) {
    try {
      // Create the same NumberFormat instance you used for formatting.
      final format = NumberFormat.currency(
          locale: locale, symbol: symbol ?? '');
      // Use parse to convert the formatted string into a number.
      return format.parse(formattedString) as double;
    } catch (e) {
      return null;
    }
  }
}

class AmountInputWithDecimalFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat;

  AmountInputWithDecimalFormatter({String locale = 'en_NG', String? symbol})
      : _currencyFormat = NumberFormat.currency(
    locale: locale,
    symbol: symbol ?? '',
    decimalDigits: 0, // 👈 no decimals
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.trim().isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Remove everything except digits
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericString.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final int value = int.parse(numericString);
    final String formatted = _currencyFormat.format(value);

    // Calculate caret position
    int digitsBeforeCursor = 0;
    for (int i = 0; i < newValue.selection.extentOffset && i < newValue.text.length; i++) {
      if (RegExp(r'[0-9]').hasMatch(newValue.text[i])) {
        digitsBeforeCursor++;
      }
    }

    int caretPosition = 0;
    int digitCount = 0;
    while (caretPosition < formatted.length && digitCount < digitsBeforeCursor) {
      if (RegExp(r'[0-9]').hasMatch(formatted[caretPosition])) {
        digitCount++;
      }
      caretPosition++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: caretPosition),
    );
  }

  double? unformatToDouble(String formattedString,
      {String locale = 'en_NG', String? symbol}) {
    try {
      final format = NumberFormat.currency(
        locale: locale,
        symbol: symbol ?? '',
        decimalDigits: 0,
      );
      return format.parse(formattedString).toDouble();
    } catch (e) {
      return null;
    }
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  static String unformat(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }


  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Only keep digits
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Build formatted string
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      // Add space after 3rd and 6th digit (if more digits follow)
      if ((i == 2 || i == 5) && i != digits.length - 1) {
        buffer.write(' ');
      }
    }

    final formatted = buffer.toString();

    // Calculate new cursor position
    int cursorPosition = newValue.selection.baseOffset;

    int nonDigitBeforeCursor =
        newValue.text.substring(0, cursorPosition).replaceAll(RegExp(r'\d'), '').length;

    int newCursorPosition = cursorPosition - nonDigitBeforeCursor;

    // Adjust for added spaces
    if (newCursorPosition > 3) newCursorPosition++;
    if (newCursorPosition > 7) newCursorPosition++;

    if (newCursorPosition > formatted.length) {
      newCursorPosition = formatted.length;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}


class AlphabetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Allow only alphabetic characters (A-Z, a-z)
    final newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}