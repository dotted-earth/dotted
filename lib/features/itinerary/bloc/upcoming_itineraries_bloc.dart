import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:dotted/features/itinerary/repositories/itineraries_repository.dart';
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
  }

  _upcomingItinerariesRequest(UpcomingItinerariesRequested event,
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
}
