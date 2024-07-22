// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:adminetic_booking/features/booking/domain/entities/booking_quantity.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking_setup.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking_status.dart';

class Booking {
  final int id;
  final String code;
  final String serial_no;
  final String name;
  final String email;
  final List<BookingQuantity> quantities;
  final BookingStatus status;
  final String start_date;
  final String end_date;
  final int duration;
  final String fee;
  final String dues;
  final BookingSetup setup;
  final DateTime created_at;
  final DateTime updated_at;
  final String api;
  Booking({
    required this.id,
    required this.code,
    required this.serial_no,
    required this.name,
    required this.email,
    required this.quantities,
    required this.status,
    required this.start_date,
    required this.end_date,
    required this.duration,
    required this.fee,
    required this.dues,
    required this.setup,
    required this.created_at,
    required this.updated_at,
    required this.api,
  });
}
