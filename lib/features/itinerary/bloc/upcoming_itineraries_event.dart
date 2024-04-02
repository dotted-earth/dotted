part of 'upcoming_itineraries_bloc.dart';

sealed class UpcomingItinerariesEvent extends Equatable {
  const UpcomingItinerariesEvent();

  @override
  List<Object> get props => [];
}

final class UpcomingItinerariesRequested extends UpcomingItinerariesEvent {}

final class CreateItineraryRequested extends UpcomingItinerariesEvent {
  final ItineraryModel itinerary;

  const CreateItineraryRequested(this.itinerary);
}

final class DeleteItineraryRequested extends UpcomingItinerariesEvent {
  final int itineraryId;

  const DeleteItineraryRequested(this.itineraryId);
}
