import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_itineraries_event.dart';
part 'upcoming_itineraries_state.dart';

class UpcomingItinerariesBloc
    extends Bloc<UpcomingItinerariesEvent, UpcomingItinerariesState> {
  late ItinerariesRepository _upcomingItinerariesRepository;

  UpcomingItinerariesBloc(ItinerariesRepository upcomingItinerariesRepository)
      : super(UpcomingItinerariesInitial()) {
    _upcomingItinerariesRepository = upcomingItinerariesRepository;
    on<UpcomingItinerariesRequested>(_upcomingItinerariesRequest);
    on<CreateItineraryRequested>(_createItineraryRequested);
    on<DeleteItineraryRequested>(_deleteItineraryRequested);
  }

  void _upcomingItinerariesRequest(UpcomingItinerariesRequested event,
      Emitter<UpcomingItinerariesState> emit) async {
    emit(UpcomingItinerariesLoading());

    try {
      final upcomingItineraries = await _upcomingItinerariesRepository
          .getUpcomingItineraries(supabase.auth.currentUser!.id);
      emit(UpcomingItinerariesSuccess(upcomingItineraries));
    } catch (err) {
      emit(UpcomingItinerariesFailure(err.toString()));
    }
  }

  void _createItineraryRequested(
      CreateItineraryRequested event, Emitter<UpcomingItinerariesState> emit) {
    final itinerary = event.itinerary;

    _upcomingItinerariesRepository.createItinerary(itinerary);
  }

  void _deleteItineraryRequested(DeleteItineraryRequested event,
      Emitter<UpcomingItinerariesState> emit) async {
    emit(UpcomingItinerariesLoading());

    try {
      await _upcomingItinerariesRepository.deleteItinerary(event.itineraryId);

      final upcomingItineraries = await _upcomingItinerariesRepository
          .getUpcomingItineraries(supabase.auth.currentUser!.id);
      emit(UpcomingItinerariesSuccess(upcomingItineraries));
    } catch (err) {
      emit(UpcomingItinerariesFailure(err.toString()));
    }
  }
}
