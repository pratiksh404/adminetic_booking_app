// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adminetic_booking/features/booking/domain/entities/booking_quantity.dart';

class BookingQuantityModel extends BookingQuantity {
  BookingQuantityModel({
    required int super.quantity,
    required String super.name,
  });

  factory BookingQuantityModel.fromBookingQuantity(BookingQuantity quantity) {
    return BookingQuantityModel(
      quantity: quantity.quantity,
      name: quantity.name,
    );
  }

  BookingQuantityModel copyWith({
    int? quantity,
    String? name,
  }) {
    return BookingQuantityModel(
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'name': name,
    };
  }

  factory BookingQuantityModel.fromMap(Map<String, dynamic> map) {
    return BookingQuantityModel(
      quantity: map['quantity'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingQuantityModel.fromJson(String source) =>
      BookingQuantityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookingQuantityModel(quantity: $quantity, name: $name)';

  @override
  bool operator ==(covariant BookingQuantityModel other) {
    if (identical(this, other)) return true;

    return other.quantity == quantity && other.name == name;
  }

  @override
  int get hashCode => quantity.hashCode ^ name.hashCode;
}
