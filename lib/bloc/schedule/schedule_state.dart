part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.itinerary,
    this.error,
    this.scheduleItems,
  });

  final ItineraryModel itinerary;
  final String? error;
  final List<ScheduleItemModel>? scheduleItems;

  ScheduleState copyWith(ItineraryModel? itinerary, String? error,
      List<ScheduleItemModel>? scheduleItems) {
    return ScheduleState(
      itinerary: itinerary ?? this.itinerary,
      error: error ?? this.error,
      scheduleItems: scheduleItems ?? this.scheduleItems,
    );
  }

  @override
  List<Object?> get props => [itinerary, error, scheduleItems];
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
  final List<ScheduleItemModel> scheduleItems;

  const ScheduleSuccess({required this.scheduleItems, required super.itinerary})
      : super();
}
