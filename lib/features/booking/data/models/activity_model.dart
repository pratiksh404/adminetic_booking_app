import 'dart:convert';

import 'package:adminetic_booking/features/booking/domain/entities/activity.dart';

class ActivityModel extends Activity {
  ActivityModel(
      {required super.name, required super.type, required super.thumbnail});

  factory ActivityModel.fromActivity(Activity status) {
    return ActivityModel(
      name: status.name,
      type: status.type,
      thumbnail: status.thumbnail,
    );
  }
  ActivityModel copyWith({
    String? name,
    String? type,
    String? thumbnail,
  }) {
    return ActivityModel(
      name: name ?? this.name,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'thumbnail': thumbnail,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      name: map['name'] as String,
      type: map['type'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Activity(name: $name, type: $type, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant Activity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ thumbnail.hashCode;
}
