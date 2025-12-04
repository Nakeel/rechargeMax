// This file is maintained for backward compatibility.
// All utilities have been moved to focused, single-responsibility files.
//
// MIGRATION PATH:
// - DateTimeFormatter: lib/core/utils/datetime_formatter.dart
// - PhoneNumberFormatter: lib/core/utils/phone_number_formatter.dart
// - ImageUtilities: lib/core/utils/image_utilities.dart
// - StringUtilities: lib/core/utils/string_utilities.dart
// - TimeUtilities: lib/core/utils/time_utilities.dart
// - MiscUtilities: lib/core/utils/misc_utilities.dart
//
// Re-exporting for backward compatibility:

export 'datetime_formatter.dart';
export 'phone_number_formatter.dart';
export 'image_utilities.dart';
export 'string_utilities.dart';
export 'time_utilities.dart';
export 'misc_utilities.dart';

// For backward compatibility, the TruncateDoubles extension is now
// defined in misc_utilities.dart. You can still access it via import.

