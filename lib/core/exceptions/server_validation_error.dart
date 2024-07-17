// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServerValidationError implements Exception {
  final String message;
  final Map<String, String>? errors;
  ServerValidationError({
    this.message = 'Validation error',
    this.errors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errors': errors,
    };
  }

  factory ServerValidationError.fromMap(Map<String, dynamic> map) {
    return ServerValidationError(
      message: map['message'] as String,
      errors: map['errors'] != null
          ? (Map<String, String>.from((map['errors'] as Map<String, String>)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerValidationError.fromJson(String source) =>
      ServerValidationError.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
