// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adminetic_booking/features/booking/domain/entities/booking_quantity.dart';

class BookingQuantityModel extends BookingQuantity {
  BookingQuantityModel({
    required String super.qty,
    required String super.name,
  });

  factory BookingQuantityModel.fromBookingQuantity(BookingQuantity quantity) {
    return BookingQuantityModel(
      qty: quantity.qty,
      name: quantity.name,
    );
  }

  BookingQuantityModel copyWith({
    String? qty,
    String? name,
  }) {
    return BookingQuantityModel(
      qty: qty ?? this.qty,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qty': qty,
      'name': name,
    };
  }

  factory BookingQuantityModel.fromMap(Map<String, dynamic> map) {
    return BookingQuantityModel(
      qty: map['qty'] is int ? map['qty'].toString() : map['qty'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingQuantityModel.fromJson(String source) =>
      BookingQuantityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookingQuantityModel(quantity: $qty, name: $name)';

  @override
  bool operator ==(covariant BookingQuantityModel other) {
    if (identical(this, other)) return true;

    return other.qty == qty && other.name == name;
  }

  @override
  int get hashCode => qty.hashCode ^ name.hashCode;
}
