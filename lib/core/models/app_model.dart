import 'dart:convert';

import 'package:adminetic_booking/core/entities/app.dart';

class AppModel extends App {
  AppModel({
    required super.baseUrl,
    required super.authBaseUrl,
    required super.name,
    required super.phone,
    required super.email,
    required super.logo,
  });

  AppModel copyWith({
    String? baseUrl,
    String? authBaseUrl,
    String? name,
    String? phone,
    String? email,
    String? logo,
  }) {
    return AppModel(
      baseUrl: baseUrl ?? this.baseUrl,
      authBaseUrl: authBaseUrl ?? this.authBaseUrl,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseUrl': baseUrl,
      'authBaseUrl': authBaseUrl,
      'name': name,
      'phone': phone,
      'email': email,
      'logo': logo,
    };
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      baseUrl: map['baseUrl'] as String,
      authBaseUrl: map['authBaseUrl'] as String,
      name: map['name'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      logo: map['logo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppModel.fromJson(String source) =>
      AppModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppModel(baseUrl: $baseUrl, authBaseUrl: $authBaseUrl, name: $name, phone: $phone, email: $email, logo: $logo)';
  }

  @override
  bool operator ==(covariant AppModel other) {
    if (identical(this, other)) return true;

    return other.baseUrl == baseUrl &&
        other.authBaseUrl == authBaseUrl &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.logo == logo;
  }

  @override
  int get hashCode {
    return baseUrl.hashCode ^
        authBaseUrl.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        logo.hashCode;
  }
}
