// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dotted/features/itinerary/models/itinerary_status_enum.dart';

class ItineraryModel {
  int id;
  String userId;
  DateTime createdAt;
  DateTime startDate;
  DateTime endDate;
  int lengthOfStay;
  String destination;
  int budget;
  ItineraryStatusEnum itineraryStatus;
  ItineraryModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.lengthOfStay,
    required this.destination,
    required this.budget,
    required this.itineraryStatus,
  });

  ItineraryModel copyWith({
    int? id,
    String? userId,
    DateTime? createdAt,
    DateTime? startDate,
    DateTime? endDate,
    int? lengthOfStay,
    String? destination,
    int? budget,
    ItineraryStatusEnum? itineraryStatus,
  }) {
    return ItineraryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lengthOfStay: lengthOfStay ?? this.lengthOfStay,
      destination: destination ?? this.destination,
      budget: budget ?? this.budget,
      itineraryStatus: itineraryStatus ?? this.itineraryStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'length_of_stay': lengthOfStay,
      'destination': destination,
      'budget': budget,
      'itinerary_status': itineraryStatus.name,
    };
  }

  factory ItineraryModel.fromMap(Map<String, dynamic> map) {
    return ItineraryModel(
        id: map['id'] as int,
        userId: map['user_id'] as String,
        createdAt: DateTime.parse(map['created_at'] as String),
        startDate: DateTime.parse(map['start_date'] as String),
        endDate: DateTime.parse(map['end_date'] as String),
        lengthOfStay: map['length_of_stay'] as int,
        destination: map['destination'] as String,
        budget: map['budget'] as int,
        itineraryStatus: ItineraryStatusEnum.values
            .firstWhere((element) => element.name == map['itinerary_status']));
  }

  String toJson() => json.encode(toMap());

  factory ItineraryModel.fromJson(String source) =>
      ItineraryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItineraryModel(id: $id, userId: $userId, createdAt: $createdAt, startDate: $startDate, endDate: $endDate, lengthOfStay: $lengthOfStay, destination: $destination, budget: $budget, itineraryStatus: $itineraryStatus)';
  }

  @override
  bool operator ==(covariant ItineraryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.lengthOfStay == lengthOfStay &&
        other.destination == destination &&
        other.budget == budget &&
        other.itineraryStatus == itineraryStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        createdAt.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        lengthOfStay.hashCode ^
        destination.hashCode ^
        budget.hashCode ^
        itineraryStatus.hashCode;
  }
}
