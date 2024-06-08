part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.itinerary,
    this.error,
    this.schedule,
  });

  final ItineraryModel itinerary;
  final String? error;
  final Schedule? schedule;

  ScheduleState copyWith(
      ItineraryModel? itinerary, String? error, Schedule? schedule) {
    return ScheduleState(
      itinerary: itinerary ?? this.itinerary,
      error: error ?? this.error,
      schedule: schedule ?? this.schedule,
    );
  }

  @override
  List<Object?> get props => [itinerary, error, schedule];
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
  final Schedule schedule;

  const ScheduleSuccess({required this.schedule, required super.itinerary})
      : super();
}
