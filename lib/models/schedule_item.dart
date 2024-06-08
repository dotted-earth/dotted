// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ScheduleItem {
  int id;
  int scheduleId;
  String name;
  String description;
  DateTime startTime;
  DateTime endTime;
  int duration;
  double? price;
  String scheduleItemType;
  int? locationId;

  ScheduleItem({
    required this.id,
    required this.scheduleId,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.duration,
    this.price,
    required this.scheduleItemType,
    this.locationId,
  });

  ScheduleItem copyWith({
    int? id,
    int? scheduleId,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    double? price,
    String? scheduleItemType,
    int? locationId,
  }) {
    return ScheduleItem(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      scheduleItemType: scheduleItemType ?? this.scheduleItemType,
      locationId: locationId ?? this.locationId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schedule_id': scheduleId,
      'name': name,
      'description': description,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'duration': duration,
      'price': price,
      'schedule_item_type': scheduleItemType,
      'location_id': locationId,
    };
  }

  factory ScheduleItem.fromMap(Map<String, dynamic> map) {
    return ScheduleItem(
      id: map['id'] as int,
      scheduleId: map['schedule_id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: DateTime.parse(map['end_time'] as String),
      duration: map['duration'] as int,
      price: map['price'] == double
          ? (map['price'])
          : map['price'] == int
              ? (map['price'] as int).toDouble()
              : null,
      scheduleItemType: map['schedule_item_type'] as String,
      locationId: map['location_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleItem.fromJson(String source) =>
      ScheduleItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScheduleItem(id: $id, scheduleId: $scheduleId, name: $name, description: $description, startTime: $startTime, endTime: $endTime, duration: $duration, price: $price, scheduleItemType: $scheduleItemType, locationId: $locationId)';
  }

  @override
  bool operator ==(covariant ScheduleItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.scheduleId == scheduleId &&
        other.name == name &&
        other.description == description &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.duration == duration &&
        other.price == price &&
        other.scheduleItemType == scheduleItemType &&
        other.locationId == locationId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        scheduleId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        duration.hashCode ^
        price.hashCode ^
        scheduleItemType.hashCode ^
        locationId.hashCode;
  }
}
