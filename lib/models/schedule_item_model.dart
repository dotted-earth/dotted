import 'dart:convert';

import 'package:dotted/models/point_of_interest_model.dart';
import 'package:dotted/models/schedule_item_type_enum.dart';

class ScheduleItemModel {
  int id;
  DateTime createdAt;
  ScheduleItemTypeEnum scheduleItemType;
  int itineraryId;
  DateTime? startTime;
  DateTime? endTime;
  int duration;
  int pointOfInterestId;
  double? price;
  PointOfInterestModel? pointOfInterest;

  ScheduleItemModel({
    required this.id,
    required this.createdAt,
    required this.itineraryId,
    required this.duration,
    required this.pointOfInterestId,
    required this.scheduleItemType,
    this.startTime,
    this.endTime,
    this.price,
    this.pointOfInterest,
  });

  ScheduleItemModel copyWith({
    int? id,
    DateTime? createdAt,
    int? itineraryId,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    int? pointOfInterestId,
    double? price,
    ScheduleItemTypeEnum? scheduleItemType,
    PointOfInterestModel? pointOfInterest,
  }) {
    return ScheduleItemModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      itineraryId: itineraryId ?? this.itineraryId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      pointOfInterestId: pointOfInterestId ?? this.pointOfInterestId,
      price: price ?? this.price,
      scheduleItemType: scheduleItemType ?? this.scheduleItemType,
      pointOfInterest: pointOfInterest ?? this.pointOfInterest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'itinerary_id': itineraryId,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'duration': duration,
      'point_of_interest_id': pointOfInterestId,
      'price': price,
      'schedule_item_type': scheduleItemType.name,
      'point_of_interest': pointOfInterest?.toMap(),
    };
  }

  factory ScheduleItemModel.fromMap(Map<String, dynamic> map) {
    return ScheduleItemModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      itineraryId: map['itinerary_id'] as int,
      startTime: map['start_time'] != null
          ? DateTime.parse(map['start_time'] as String)
          : null,
      endTime: map['end_time'] != null
          ? DateTime.parse(map['end_time'] as String)
          : null,
      duration: map['duration'] as int,
      pointOfInterestId: map['point_of_interest_id'] as int,
      price: map['price'] is double
          ? map['price'] as double
          : map['price'] is int
              ? (map['price'] as int).toDouble()
              : null,
      scheduleItemType: ScheduleItemTypeEnum.values
          .firstWhere((element) => element.name == map['schedule_item_type']),
      pointOfInterest: map['point_of_interest'] != null
          ? PointOfInterestModel.fromMap(
              map['point_of_interest'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleItemModel.fromJson(String source) =>
      ScheduleItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScheduleItemModel(id: $id, createdAt: $createdAt, itineraryId: $itineraryId, startTime: $startTime, endTime: $endTime, duration: $duration, pointOfInterestId: $pointOfInterestId, price: $price, scheduleItemType: $scheduleItemType, pointOfInterest: $pointOfInterest)';
  }

  @override
  bool operator ==(covariant ScheduleItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.itineraryId == itineraryId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.duration == duration &&
        other.pointOfInterestId == pointOfInterestId &&
        other.price == price &&
        other.scheduleItemType == scheduleItemType &&
        other.pointOfInterest == pointOfInterest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        itineraryId.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        duration.hashCode ^
        pointOfInterestId.hashCode ^
        price.hashCode ^
        scheduleItemType.hashCode ^
        pointOfInterest.hashCode;
  }
}
