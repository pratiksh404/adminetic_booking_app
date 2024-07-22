// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adminetic_booking/features/booking/domain/entities/booking_status.dart';

class BookingStatusModel extends BookingStatus {
  BookingStatusModel({
    required int super.value,
    required String super.label,
    required String super.icon,
    required String super.color,
  });

  factory BookingStatusModel.fromBookingStatus(BookingStatus status) {
    return BookingStatusModel(
      value: status.value,
      label: status.label,
      icon: status.icon,
      color: status.color,
    );
  }

  BookingStatusModel copyWith({
    int? value,
    String? label,
    String? icon,
    String? color,
  }) {
    return BookingStatusModel(
      value: value ?? this.value,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'label': label,
      'icon': icon,
      'color': color,
    };
  }

  factory BookingStatusModel.fromMap(Map<String, dynamic> map) {
    return BookingStatusModel(
      value: map['value'] as int,
      label: map['label'] as String,
      icon: map['icon'] as String,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingStatusModel.fromJson(String source) =>
      BookingStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingStatusModel(value: $value, label: $label, icon: $icon, color: $color)';
  }

  @override
  bool operator ==(covariant BookingStatusModel other) {
    if (identical(this, other)) return true;

    return other.value == value &&
        other.label == label &&
        other.icon == icon &&
        other.color == color;
  }

  @override
  int get hashCode {
    return value.hashCode ^ label.hashCode ^ icon.hashCode ^ color.hashCode;
  }
}
