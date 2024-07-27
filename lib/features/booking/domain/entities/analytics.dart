// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Analytics {
  final int pendingBookingCount;
  final int approvedBookingCount;
  final int terminatedBookingCount;
  final int todaysBookingCount;
  final Map<String, dynamic> bookingCountPerMonthInterval;
  final Map<String, dynamic> bookingCountPerDayInterval;
  final Map<String, dynamic> topBookings;

  Analytics({
    required this.pendingBookingCount,
    required this.approvedBookingCount,
    required this.terminatedBookingCount,
    required this.todaysBookingCount,
    required this.bookingCountPerMonthInterval,
    required this.bookingCountPerDayInterval,
    required this.topBookings,
  });
}
