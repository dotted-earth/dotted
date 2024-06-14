part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class RequestScheduleEvent extends ScheduleEvent {
  final int itineraryId;

  const RequestScheduleEvent({
    required this.itineraryId,
  });
}

class DayScheduleChangeEvent extends ScheduleEvent {
  final String selectedDay;

  const DayScheduleChangeEvent({
    required this.selectedDay,
  });
}
