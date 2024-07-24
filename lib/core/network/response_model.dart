// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ResponseModel {
  final bool status;
  final String message;
  final dynamic data;
  final Map<String, String>? errors;
  ResponseModel({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  ResponseModel copyWith({
    bool? status,
    String? message,
    dynamic data,
    Map<String, String>? errors,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data,
      'errors': errors,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      data: map['data'] as dynamic,
      errors: map['errors'] != null
          ? Map<String, String>.from((map['errors'] as Map<String, String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseModel(status: $status, message: $message, data: $data, errors: $errors)';
  }

  @override
  bool operator ==(covariant ResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.data == data &&
        mapEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return status.hashCode ^ message.hashCode ^ data.hashCode ^ errors.hashCode;
  }
}
