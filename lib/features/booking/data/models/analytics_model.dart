import 'dart:convert';

import 'package:adminetic_booking/features/booking/domain/entities/analytics.dart';

class AnalyticsModel extends Analytics {
  AnalyticsModel({
    required super.pendingBookingCount,
    required super.approvedBookingCount,
    required super.terminatedBookingCount,
    required super.todaysBookingCount,
    required super.bookingCountPerMonthInterval,
    required super.bookingCountPerDayInterval,
    required super.topBookings,
  });

  AnalyticsModel copyWith({
    int? pendingBookingCount,
    int? approvedBookingCount,
    int? terminatedBookingCount,
    int? todaysBookingCount,
    Map<String, dynamic>? bookingCountPerMonthInterval,
    Map<String, dynamic>? bookingCountPerDayInterval,
    Map<String, dynamic>? topBookings,
  }) {
    return AnalyticsModel(
      pendingBookingCount: pendingBookingCount ?? this.pendingBookingCount,
      approvedBookingCount: approvedBookingCount ?? this.approvedBookingCount,
      terminatedBookingCount:
          terminatedBookingCount ?? this.terminatedBookingCount,
      todaysBookingCount: todaysBookingCount ?? this.todaysBookingCount,
      bookingCountPerMonthInterval:
          bookingCountPerMonthInterval ?? this.bookingCountPerMonthInterval,
      bookingCountPerDayInterval:
          bookingCountPerDayInterval ?? this.bookingCountPerDayInterval,
      topBookings: topBookings ?? this.topBookings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingBookingCount': pendingBookingCount,
      'approvedBookingCount': approvedBookingCount,
      'terminatedBookingCount': terminatedBookingCount,
      'todaysBookingCount': todaysBookingCount,
      'bookingCountPerMonthInterval': bookingCountPerMonthInterval,
      'bookingCountPerDayInterval': bookingCountPerDayInterval,
      'topBookings': topBookings,
    };
  }

  factory AnalyticsModel.fromMap(Map<String, dynamic> map) {
    return AnalyticsModel(
      pendingBookingCount: map['pendingBookingCount'] as int,
      approvedBookingCount: map['approvedBookingCount'] as int,
      terminatedBookingCount: map['terminatedBookingCount'] as int,
      todaysBookingCount: map['todaysBookingCount'] as int,
      bookingCountPerMonthInterval: Map<String, dynamic>.from(
          (map['bookingCountPerMonthInterval'] as Map<String, dynamic>)),
      bookingCountPerDayInterval: Map<String, dynamic>.from(
          (map['bookingCountPerDayInterval'] as Map<String, dynamic>)),
      topBookings: Map<String, dynamic>.from(
          (map['topBookings'] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnalyticsModel.fromJson(String source) =>
      AnalyticsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnalyticsModel(pendingBookingCount: $pendingBookingCount, approvedBookingCount: $approvedBookingCount, terminatedBookingCount: $terminatedBookingCount, todaysBookingCount: $todaysBookingCount, bookingCountPerMonthInterval: $bookingCountPerMonthInterval, bookingCountPerDayInterval: $bookingCountPerDayInterval, topBookings: $topBookings)';
  }
}
