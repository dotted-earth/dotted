part of 'upcoming_itineraries_bloc.dart';

sealed class UpcomingItinerariesEvent extends Equatable {
  const UpcomingItinerariesEvent();

  @override
  List<Object> get props => [];
}

final class UpcomingItinerariesRequested extends UpcomingItinerariesEvent {}
