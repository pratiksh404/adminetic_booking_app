// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adminetic_booking/features/booking/domain/entities/booking_setup.dart';

class BookingSetupModel extends BookingSetup {
  BookingSetupModel({
    required int super.feeStatus,
    required String super.calculationType,
  });

  factory BookingSetupModel.fromBookingSetup(BookingSetup setup) {
    return BookingSetupModel(
      feeStatus: setup.feeStatus,
      calculationType: setup.calculationType,
    );
  }

  BookingSetupModel copyWith({
    int? feeStatus,
    String? calculationType,
  }) {
    return BookingSetupModel(
      feeStatus: feeStatus ?? this.feeStatus,
      calculationType: calculationType ?? this.calculationType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'feeStatus': feeStatus,
      'calculationType': calculationType,
    };
  }

  factory BookingSetupModel.fromMap(Map<String, dynamic> map) {
    return BookingSetupModel(
      feeStatus: map['feeStatus'] as int,
      calculationType: map['calculationType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingSetupModel.fromJson(String source) =>
      BookingSetupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BookingSetupModel(feeStatus: $feeStatus, calculationType: $calculationType)';

  @override
  bool operator ==(covariant BookingSetupModel other) {
    if (identical(this, other)) return true;

    return other.feeStatus == feeStatus &&
        other.calculationType == calculationType;
  }

  @override
  int get hashCode => feeStatus.hashCode ^ calculationType.hashCode;
}
