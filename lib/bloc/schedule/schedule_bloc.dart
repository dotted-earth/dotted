import 'package:dotted/models/schedule_item_model.dart';
import 'package:dotted/models/schedule_item_type_enum.dart';
import 'package:flutter/material.dart';
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
    on<DayScheduleChangeEvent>(_onDayScheduleChangeEvent);
  }

  _onItineraryByIdRequest(
      RequestScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading(itinerary: itinerary));
    final data =
        await itinerariesRepository.getItinerarySchedule(event.itineraryId);
    data.fold((error) {
      emit(ScheduleFailure(itinerary: itinerary, error: error));
    }, (scheduleItems) {
      final ScheduleItemModel accommodation = scheduleItems.removeAt(
          scheduleItems.indexWhere((item) =>
              item.scheduleItemType == ScheduleItemTypeEnum.accommodation));

      scheduleItems.removeWhere((item) =>
          item.scheduleItemType == ScheduleItemTypeEnum.accommodation);

      final scheduleItemsPerDay = scheduleItems
          .fold<Map<String, List<ScheduleItemModel>>>({}, (map, item) {
        final dateOnly = DateUtils.dateOnly(item.startTime!).toIso8601String();
        final mapHasDayOfScheduleItem = map[dateOnly];

        if (mapHasDayOfScheduleItem == null) {
          map[dateOnly] = [item];
        } else {
          for (final key in map.keys) {
            final date = DateTime.parse(key);
            final isSameDay = DateUtils.isSameDay(item.startTime, date);
            if (isSameDay) {
              map[key]!.add(item);
            }
          }
        }

        return map;
      });

      emit(state.copyWith(
        accommodation: accommodation,
        scheduleItems: scheduleItemsPerDay,
        selectedDay: scheduleItemsPerDay.keys.first,
        error: null,
      ));
    });
  }

  _onDayScheduleChangeEvent(
      DayScheduleChangeEvent event, Emitter<ScheduleState> emit) {
    emit(state.copyWith(selectedDay: event.selectedDay, error: null));
  }
}
