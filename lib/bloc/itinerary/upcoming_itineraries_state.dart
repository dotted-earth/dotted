part of 'upcoming_itineraries_bloc.dart';

sealed class UpcomingItinerariesState extends Equatable {
  const UpcomingItinerariesState();

  @override
  List<Object> get props => [];
}

final class UpcomingItinerariesInitial extends UpcomingItinerariesState {}

final class UpcomingItinerariesLoading extends UpcomingItinerariesState {}

final class UpcomingItinerariesFailure extends UpcomingItinerariesState {
  final String error;

  const UpcomingItinerariesFailure(this.error);
}

final class UpcomingItinerariesSuccess extends UpcomingItinerariesState {
  final List<ItineraryModel> upcomingItineraries;

  const UpcomingItinerariesSuccess(this.upcomingItineraries);
}
