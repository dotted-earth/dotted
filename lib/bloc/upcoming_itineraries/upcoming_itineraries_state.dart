part of 'upcoming_itineraries_bloc.dart';

@immutable
class UpcomingItinerariesState extends Equatable {
  final bool isLoading;
  final List<ItineraryModel> upcomingItineraries;

  const UpcomingItinerariesState(
      {required this.upcomingItineraries, required this.isLoading});

  UpcomingItinerariesState copyWith(
      List<ItineraryModel>? upcomingItineraries, bool? isLoading) {
    return UpcomingItinerariesState(
      upcomingItineraries: upcomingItineraries ?? this.upcomingItineraries,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [upcomingItineraries, isLoading];
}

class UpcomingItinerariesInitial extends UpcomingItinerariesState {
  const UpcomingItinerariesInitial(
      {required super.upcomingItineraries, required super.isLoading})
      : super();
}

class UpcomingItinerariesLoading extends UpcomingItinerariesState {
  const UpcomingItinerariesLoading(
      {required super.upcomingItineraries, required super.isLoading})
      : super();
}

class UpcomingItinerariesFailure extends UpcomingItinerariesState {
  final String error;

  const UpcomingItinerariesFailure(
      {required super.upcomingItineraries,
      required super.isLoading,
      required this.error})
      : super();
}

final class UpcomingItinerariesSuccess extends UpcomingItinerariesState {
  const UpcomingItinerariesSuccess(
      {required super.upcomingItineraries, required super.isLoading})
      : super();
}
