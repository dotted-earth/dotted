import 'dart:convert';

import 'package:dotted/models/schedule_item.dart';

class Schedule {
  int id;
  int itineraryId;
  String name;
  String? description;
  DateTime startDate;
  DateTime endDate;
  int duration;
  List<ScheduleItem> scheduleItems;

  Schedule({
    required this.id,
    required this.itineraryId,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.scheduleItems,
  });

  Schedule copyWith({
    int? id,
    int? itineraryId,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    int? duration,
    List<ScheduleItem>? scheduleItems,
  }) {
    return Schedule(
      id: id ?? this.id,
      itineraryId: itineraryId ?? this.itineraryId,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      duration: duration ?? this.duration,
      scheduleItems: scheduleItems ?? this.scheduleItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'itinerary_id': itineraryId,
      'name': name,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'duration': duration,
      'schedule_items': scheduleItems,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
        id: map['id'] as int,
        itineraryId: map['itinerary_id'] as int,
        name: map['name'] as String,
        description: map['description'],
        startDate: DateTime.parse(map['start_date'] as String),
        endDate: DateTime.parse(map['end_date'] as String),
        duration: map['duration'] as int,
        scheduleItems: (map['schedule_items'] as List<dynamic>)
            .map((item) => ScheduleItem.fromMap(item))
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Schedule(id: $id, itineraryId: $itineraryId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, duration: $duration), scheduleItems: $scheduleItems';
  }

  @override
  bool operator ==(covariant Schedule other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.itineraryId == itineraryId &&
        other.name == name &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.duration == duration &&
        other.scheduleItems == scheduleItems;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        itineraryId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        duration.hashCode ^
        scheduleItems.hashCode;
  }
}
