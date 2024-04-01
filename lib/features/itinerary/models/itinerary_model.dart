import 'dart:convert';
import 'package:dotted/common/models/media_modal.dart';
import 'package:dotted/features/itinerary/models/itinerary_status_enum.dart';

class ItineraryModel {
  int? id;
  DateTime? createdAt;
  String userId;
  DateTime startDate;
  DateTime endDate;
  int lengthOfStay;
  String destination;
  int budget;
  ItineraryStatusEnum itineraryStatus;
  MedialModel? media;

  ItineraryModel({
    this.id,
    this.createdAt,
    this.media,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.lengthOfStay,
    required this.destination,
    required this.budget,
    required this.itineraryStatus,
  });

  ItineraryModel copyWith({
    int? id,
    DateTime? createdAt,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    int? lengthOfStay,
    String? destination,
    int? budget,
    ItineraryStatusEnum? itineraryStatus,
    MedialModel? image,
  }) {
    return ItineraryModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lengthOfStay: lengthOfStay ?? this.lengthOfStay,
      destination: destination ?? this.destination,
      budget: budget ?? this.budget,
      itineraryStatus: itineraryStatus ?? this.itineraryStatus,
      media: media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'user_id': userId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'length_of_stay': lengthOfStay,
      'destination': destination,
      'budget': budget,
      'itinerary_status': itineraryStatus.name,
      'media': media?.toMap(),
    };
  }

  factory ItineraryModel.fromMap(Map<String, dynamic> map) {
    return ItineraryModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      userId: map['user_id'] as String,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: DateTime.parse(map['end_date'] as String),
      lengthOfStay: map['length_of_stay'] as int,
      destination: map['destination'] as String,
      budget: map['budget'] as int,
      itineraryStatus: ItineraryStatusEnum.values
          .firstWhere((element) => element.name == map['itinerary_status']),
      media: map['media'] is Map ? MedialModel.fromMap(map['media']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItineraryModel.fromJson(String source) =>
      ItineraryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItineraryModel(id: $id, createdAt: $createdAt, userId: $userId, startDate: $startDate, endDate: $endDate, lengthOfStay: $lengthOfStay, destination: $destination, budget: $budget, itineraryStatus: $itineraryStatus, media: $media)';
  }

  @override
  bool operator ==(covariant ItineraryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.userId == userId &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.lengthOfStay == lengthOfStay &&
        other.destination == destination &&
        other.budget == budget &&
        other.itineraryStatus == itineraryStatus &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        userId.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        lengthOfStay.hashCode ^
        destination.hashCode ^
        budget.hashCode ^
        itineraryStatus.hashCode ^
        media.hashCode;
  }
}
