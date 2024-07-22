// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adminetic_booking/features/booking/data/models/booking_quantity_model.dart';
import 'package:adminetic_booking/features/booking/data/models/booking_setup_model.dart';
import 'package:adminetic_booking/features/booking/data/models/booking_status_model.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:flutter/foundation.dart';

class BookingModel extends Booking {
  BookingModel({
    required int super.id,
    required String super.code,
    required String super.serial_no,
    required String super.name,
    required String super.email,
    required List<BookingQuantityModel> super.quantities,
    required BookingStatusModel super.status,
    required String super.start_date,
    required String super.end_date,
    required int super.duration,
    required String super.fee,
    required String super.dues,
    required BookingSetupModel super.setup,
    required DateTime super.created_at,
    required DateTime super.updated_at,
    required String super.api,
  });

  BookingModel copyWith({
    int? id,
    String? code,
    String? serial_no,
    String? name,
    String? email,
    List<BookingQuantityModel>? quantities,
    BookingStatusModel? status,
    String? start_date,
    String? end_date,
    int? duration,
    String? fee,
    String? dues,
    BookingSetupModel? setup,
    DateTime? created_at,
    DateTime? updated_at,
    String? api,
  }) {
    return BookingModel(
      id: id ?? this.id,
      code: code ?? this.code,
      serial_no: serial_no ?? this.serial_no,
      name: name ?? this.name,
      email: email ?? this.email,
      quantities: (quantities ?? this.quantities)
          .map((quantity) => BookingQuantityModel.fromBookingQuantity(quantity))
          .toList(),
      status: BookingStatusModel.fromBookingStatus((status ?? this.status)),
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      fee: fee ?? this.fee,
      dues: dues ?? this.dues,
      setup: BookingSetupModel.fromBookingSetup(setup ?? this.setup),
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      api: api ?? this.api,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'serial_no': serial_no,
      'name': name,
      'email': email,
      'quantities': quantities
          .map((x) => BookingQuantityModel.fromBookingQuantity(x).toMap())
          .toList(),
      'status': BookingStatusModel.fromBookingStatus(status).toMap(),
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'fee': fee,
      'dues': dues,
      'setup': BookingSetupModel.fromBookingSetup(setup).toMap(),
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
      'api': api,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as int,
      code: map['code'] as String,
      serial_no: map['serial_no'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      quantities: List<BookingQuantityModel>.from(
        (map['quantities'] as List<int>).map<BookingQuantityModel>(
          (x) => BookingQuantityModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: BookingStatusModel.fromMap(map['status'] as Map<String, dynamic>),
      start_date: map['start_date'] as String,
      end_date: map['end_date'] as String,
      duration: map['duration'] as int,
      fee: map['fee'] as String,
      dues: map['dues'] as String,
      setup: BookingSetupModel.fromMap(map['setup'] as Map<String, dynamic>),
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      api: map['api'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingModel(id: $id, code: $code, serial_no: $serial_no, name: $name, email: $email, quantities: $quantities, status: $status, start_date: $start_date, end_date: $end_date, duration: $duration, fee: $fee, dues: $dues, setup: $setup, created_at: $created_at, updated_at: $updated_at, api: $api)';
  }

  @override
  bool operator ==(covariant BookingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.serial_no == serial_no &&
        other.name == name &&
        other.email == email &&
        listEquals(other.quantities, quantities) &&
        other.status == status &&
        other.start_date == start_date &&
        other.end_date == end_date &&
        other.duration == duration &&
        other.fee == fee &&
        other.dues == dues &&
        other.setup == setup &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.api == api;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        serial_no.hashCode ^
        name.hashCode ^
        email.hashCode ^
        quantities.hashCode ^
        status.hashCode ^
        start_date.hashCode ^
        end_date.hashCode ^
        duration.hashCode ^
        fee.hashCode ^
        dues.hashCode ^
        setup.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        api.hashCode;
  }
}
