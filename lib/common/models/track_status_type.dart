import 'package:flutter/material.dart';

enum TrackStatusType {
  past,
  current,
  future,
}

class TrackStatus {
  final String label;
  final String time;
  final TrackStatusType status;
  final Widget? subtitle;

  TrackStatus({
    required this.label,
    required this.time,
    required this.status,
    this.subtitle,
  });
}
