part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.itinerary,
    this.error,
    this.accommodation,
    this.scheduleItems,
    this.selectedDay,
  });

  final ItineraryModel itinerary;
  final String? error;
  final ScheduleItemModel? accommodation;
  final Map<String, List<ScheduleItemModel>>? scheduleItems;
  final String? selectedDay;

  ScheduleState copyWith({
    ItineraryModel? itinerary,
    String? error,
    ScheduleItemModel? accommodation,
    Map<String, List<ScheduleItemModel>>? scheduleItems,
    String? selectedDay,
  }) {
    return ScheduleState(
        itinerary: itinerary ?? this.itinerary,
        error: error ?? this.error,
        accommodation: accommodation ?? this.accommodation,
        scheduleItems: scheduleItems ?? this.scheduleItems,
        selectedDay: selectedDay ?? this.selectedDay);
  }

  @override
  List<Object?> get props =>
      [itinerary, error, scheduleItems, accommodation, selectedDay];
}

class ScheduleInitial extends ScheduleState {
  const ScheduleInitial({required super.itinerary}) : super();
}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading({required super.itinerary});
}

class ScheduleFailure extends ScheduleState {
  final String error;
  const ScheduleFailure({required this.error, required super.itinerary})
      : super();
}

class ScheduleSuccess extends ScheduleState {
  final Map<String, List<ScheduleItemModel>> scheduleItems;

  const ScheduleSuccess({required this.scheduleItems, required super.itinerary})
      : super();
}
