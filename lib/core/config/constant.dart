import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AppUtilities {
  static String showStatus(int? status) {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Approved";
      case 2:
        return "Cancelled";
      default:
        return "N/A";
    }
  }
}