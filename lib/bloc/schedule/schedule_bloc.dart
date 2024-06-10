import 'package:dotted/models/schedule_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/repositories/itineraries_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ItineraryModel itinerary;
  final ItinerariesRepository itinerariesRepository = ItinerariesRepository(
      ItinerariesProvider(), UnsplashRepository(UnsplashProvider()));

  ScheduleBloc({
    required this.itinerary,
  }) : super(ScheduleInitial(
          itinerary: itinerary,
        )) {
    on<RequestScheduleEvent>(_onItineraryByIdRequest);
  }

  _onItineraryByIdRequest(
      RequestScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading(itinerary: itinerary));
    final data =
        await itinerariesRepository.getItinerarySchedule(event.itineraryId);
    data.fold((error) {
      emit(ScheduleFailure(itinerary: itinerary, error: error));
    }, (scheduleItems) {
      emit(ScheduleSuccess(itinerary: itinerary, scheduleItems: scheduleItems));
    });
  }
}
