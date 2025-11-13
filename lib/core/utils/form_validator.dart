class AppFormValidator {
  static String? pin(String? value) {
    final val = value!.trim();

    if (val.isEmpty) return 'Pin is Required';

    if (val.length < 6) {
      // if (value.length < 6) {
      return 'Pin must 6 digit';
    }

    return null;
  }


  static String? validateAge(String? age) {
    // int parseAge = int.tryParse(age) ?? 0;

    if (age == null) {
      return 'Age is Required';
    }
    if (int.tryParse(age) == null) {
      return 'Invalid age';
    }
    if (int.tryParse(age) != null) {
      if (int.tryParse(age)! < 13) {
        return 'Age must be from 13 and above';
      }
    }

    return null;
  }

  //Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 10),
  //                         child: AppButton.outlined(
  //                           context: context,
  //                           text: 'Add New Card',
  //                           fontWeight: FontWeight.w400,
  //                           disabled: false,
  //                           onPressed: () async {
  //                           },
  //                         ),
  //                       )

  // static
  static String? validateAmount(String value, {double? minVal, String? title}) {
    try {
      if (value.isNotEmpty) {
        value = value.replaceAll(',', '').replaceAll(r'$', '');

        if (value.isEmpty) return null;

        final parsedValue = double.tryParse(value);
        if (parsedValue == null) return 'Input a valid ${title ?? 'amount'}';

        if (minVal != null && parsedValue < minVal) {
          return '${title ?? 'amount'} must be greater than ${minVal.toStringAsFixed(2)}';
        }

        if (minVal == null && parsedValue <= 0) {
          return '${title ?? 'amount'} must be greater than 0';
        }

        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static String? validateBVN(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Bank Verification Number(BVN) is Required';
    }
    if (value!.length < 11) {
      return 'That doesn\'t look like a valid BVN. Please enter a 11-digit number.';
    }
    return null;
  }

  static String? validateCard(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Card Details is Required';
    }
    if (value!.length < 16) {
      return 'Invalid Card details';
    }
    return null;
  }

  static String? validateCardPin(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Card Pin is Required';
    }
    if (value!.length < 4) {
      return 'Must be 4 digits';
    }
    return null;
  }

  static String? validateContent(String? value) {
    final val = value ?? '';
    if (val.isEmpty) return 'Content Required';

    return null;
  }

  static String? validateCVV(String? value) {
    if (value?.isEmpty ?? true) {
      return 'CVV is Required';
    }
    if (value!.length < 3) {
      return 'Invalid details';
    }
    return null;
  }

  static String? validateEmail(String? value, {String? title}) {
    final val = value!.trim();
    if (val.isEmpty) return 'Email address is required';

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!(regex.hasMatch(val))) return 'Please enter a valid ${title?? 'email address'}';
    return null;
  }

  static String? validateField(String? value, String feild) {
    if (value?.isEmpty ?? true) {
      return '$feild is required';
    } else {
      return null;
    }
  }


  static String? validateMaxAmount(
      String? value, {
        required double max,
        String? errorMessage,
        String? title,
      }) {
    if (value == null || value.trim().isEmpty) {
      return '${title??'Field'} is required';
    }

    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Please enter a valid number';
    }

    if (parsed > max) {
      return errorMessage ??
          '${title??'Field'} must not be less than $max';
    }

    return null; // valid
  }

  static String? validateMinAmount(
      String? value, {
        required double min,
        String? errorMessage,
        String? title,
      }) {
    if (value == null || value.trim().isEmpty) {
      return '${title??'Field'} is required';
    }

    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Please enter a valid number';
    }

    if (parsed < min) {
      return errorMessage ??
          '${title??'Field'} must not be less than $min';
    }

    return null; // valid
  }


  static String? validateRcNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'RC number is required';
    }

    // Matches RC followed by 6–10 digits (adjust if needed)
    final rcRegex = RegExp(r'^RC\d{6,10}$', caseSensitive: false);

    if (!rcRegex.hasMatch(value.trim())) {
      return 'That doesn’t look like a valid RC number. Please enter a valid RC number. eg RC1234567';
    }

    return null; // valid
  }

  static String? simpleValidatePassword(String? value) {
    final val = value!.trim();
    if (val.isEmpty) return 'Password is Required';
    if (val.length < 3) return 'Password must be at least 3 characters';
    return null;
  }
  static bool isReferralCodeValid(String? value) => value != null && value.trim().length == 6 && value.trim().contains(RegExp(r'[a-zA-Z]')) && value.trim().contains(RegExp(r'[0-9]'));
  static bool isSignupReferralCodeValid(String? value) => value != null && value.trim().length == 5 && value.trim().contains(RegExp(r'[a-zA-Z]')) && value.trim().contains(RegExp(r'[0-9]'));


  static String? validateSignupReferralCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final val = value.trim();

    // 1. Check for exact length
    if (val.length != 5) {
      return 'Invalid referral code';
    }

    // 2. Check for at least one letter
    final hasLetter = val.contains(RegExp(r'[a-zA-Z]'));
    if (!hasLetter) {
      return 'Invalid referral code';
    }

    // 3. Check for at least one number
    final hasNumber = val.contains(RegExp(r'[0-9]'));
    if (!hasNumber) {
      return 'Invalid referral code';
    }

    // All checks passed
    return null;
  }

  static String? validateReferralCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final val = value.trim();

    // 1. Check for exact length
    if (val.length != 6) {
      return 'Invalid referral code';
    }

    // 2. Check for at least one letter
    final hasLetter = val.contains(RegExp(r'[a-zA-Z]'));
    if (!hasLetter) {
      return 'Invalid referral code';
    }

    // 3. Check for at least one number
    final hasNumber = val.contains(RegExp(r'[0-9]'));
    if (!hasNumber) {
      return 'Invalid referral code';
    }

    // All checks passed
    return null;
  }

  static String? validateAlphaNumericFixedLength(String? value, {String? title}) {
    final fieldName = title ?? 'Value'; // Use a generic default if title is null

    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final val = value.trim();

    // 1. Check for exact length
    if (val.length != 6) {
      return '$fieldName must be exactly 6 characters long';
    }

    // 2. Check for at least one letter
    final hasLetter = val.contains(RegExp(r'[a-zA-Z]'));
    if (!hasLetter) {
      return '$fieldName must contain at least one letter';
    }

    // 3. Check for at least one number
    final hasNumber = val.contains(RegExp(r'[0-9]'));
    if (!hasNumber) {
      return '$fieldName must contain at least one number';
    }

    // All checks passed
    return null;
  }

  static String? validateName(String? value, {String? title}) {
    final val = value!.trim();
    if (val.isEmpty) return '${title ?? 'Name'} is Required';
    // if (!RegExp('^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}{-}\$').hasMatch(val)) {
    // if (!RegExp('^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}{-}\$').hasMatch(val)) {
    //   return 'Uhhh oh! provide a valid name';
    // }
    if (val.length < 3) return '${title ?? 'Name'} must be at least 3 characters';
    return null;
  }

  static String? validatePassword(String? value, [String? exp]) {
    // log(val);

    final val = value!.trim();

    if (val.isEmpty) return 'Password is required';

    if (!RegExp(exp ?? "^(?=.*[0-9])(?=.*[A-Za-z])(?=.{8,})").hasMatch(val)) {
      return 'Minimum of 8 characters. Must contain at least one special text (!@#\$%_^&*)';
    }

    return null;
  }

  static String? validatePhonenumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digits (spaces, dashes, etc.)
    final raw = value.replaceAll(RegExp(r'\D'), '');

    // Must be exactly 10 digits (you can adjust if needed)
    if (raw.length != 10) {
      return 'Phone number should be 10 digits long';
    }

    final RegExp phoneNumberRegex = RegExp(r'^\d{10}$');
    if (!phoneNumberRegex.hasMatch(raw)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }


  static String? validatePin(String? value) {
    // log(val);

    final val = value!.trim();

    if (val.isEmpty) return 'PIN is Required';

    if (val.length < 6) {
      return 'Password must be 6digits';
    }

    return null;
  }
}
