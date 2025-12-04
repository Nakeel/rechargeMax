import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';

/// Utility class for string manipulation and text processing.
abstract class StringUtilities {
  /// Truncates content by word count based on percentage.
  ///
  /// Example:
  ///   StringUtilities.getTruncatedContent("Hello world test", percent: 0.5)
  ///   → "Hello world..."
  static String getTruncatedContent(String content, {double percent = 0.3}) {
    try {
      List<String> words = content.split(' ');
      int wordCount = (words.length * percent).ceil();
      return words.length > wordCount
          ? '${words.take(wordCount).join(' ')}...'
          : content;
    } catch (e) {
      print('Error at getting truncated content: ${e.toString()}');
      return content;
    }
  }

  /// Extracts initials from a full name.
  ///
  /// Examples:
  ///   "John Doe" → "JD"
  ///   "John" → "JO"
  ///   "J" → "J"
  static String getInitials(String userFullname) {
    try {
      List<String> names = userFullname.split(" ");
      names.removeWhere((e) => e == "");

      if (names.isEmpty) {
        return userFullname.split('').first.toUpperCase();
      }

      String initials = "";
      int numWords = 2;

      if (names.length != 1) {
        if (numWords > names.length) {
          numWords = names.length;
        }
        for (var i = 0; i < numWords; i++) {
          if (names[i].isNotEmpty) {
            initials += names[i][0];
          }
        }
      } else {
        List<String> firstName = names[0].split("");
        initials = firstName.length > 1
            ? firstName[0] + firstName[1]
            : firstName[0];
      }

      return initials.toUpperCase();
    } catch (e) {
      return userFullname.isEmpty ? '' : userFullname.split('').first.toUpperCase();
    }
  }

  /// Checks if two names are similar by comparing name components.
  /// Names are considered similar if they share at least 2 components.
  ///
  /// Example:
  ///   "John Michael Doe" and "Michael John" → true (shares "John" and "Michael")
  ///   "John Doe" and "Jane Doe" → true (shares "Doe")
  ///   "John Smith" and "Jane Brown" → false (no shared components)
  static bool areNamesSimilar(String nameA, String nameB) {
    List<String> nameAComponents = nameA.split(' ');
    List<String> nameBComponents = nameB.split(' ');

    Set<String> nameASet = nameAComponents.toSet();
    Set<String> nameBSet = nameBComponents.toSet();

    Set<String> intersection = nameASet.intersection(nameBSet);

    return intersection.length >= 2;
  }

  /// Returns a TextSpan with query terms highlighted in bold.
  ///
  /// Used for search result highlighting where matching text is bold
  /// and non-matching text is regular weight.
  ///
  /// Example:
  ///   "Hello World" with query "World" → "Hello " (normal) + "World" (bold)
  static TextSpan getHighlightedText(String item, String query) {
    List<TextSpan> spans = [];

    if (query.isEmpty) {
      return TextSpan(
        text: item,
        style: const TextStyle(color: Colors.black),
      );
    }

    int start = 0;
    query = query.toLowerCase();

    while (start < item.length) {
      int matchStart = item.toLowerCase().indexOf(query, start);

      if (matchStart == -1) {
        // No more matches, add the rest of the string
        spans.add(TextSpan(
          text: item.substring(start),
          style: const TextStyle(
            color: AppColors.colorBlack,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ));
        break;
      }

      // Add non-matching part before the match
      if (matchStart > start) {
        spans.add(TextSpan(
          text: item.substring(start, matchStart),
          style: const TextStyle(
            color: AppColors.colorBlack,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ));
      }

      // Add matched part in bold
      int matchEnd = matchStart + query.length;
      spans.add(TextSpan(
        text: item.substring(matchStart, matchEnd),
        style: const TextStyle(
          color: AppColors.colorBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ));

      start = matchEnd;
    }

    return TextSpan(children: spans);
  }

  /// Extracts filename from a URL, handling URL decoding and special characters.
  ///
  /// Example:
  ///   "https://example.com/path/to/my+file.pdf" → "my file.pdf"
  ///   "https://example.com/image.png" → "image.png"
  static String getFileNameFromUrl(String url) {
    try {
      String decodedUrl = Uri.decodeComponent(url);
      String fileName = decodedUrl.split('/').last;
      return fileName.replaceAll('+', ' ');
    } catch (e) {
      return url;
    }
  }
}
