import 'package:dotted/bloc/schedule/schedule_bloc.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/models/schedule_item.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key, required this.itinerary});
  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ItinerariesRepository(
          ItinerariesProvider(), UnsplashRepository(UnsplashProvider())),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Trip to ${itinerary.destination}"),
          automaticallyImplyLeading: true,
        ),
        body: BlocProvider(
          create: (context) => ScheduleBloc(itinerary: itinerary),
          child: ScheduleTimelines(
            itineraryId: itinerary.id!,
          ),
        ),
      ),
    );
  }
}

class ScheduleTimelines extends StatefulWidget {
  const ScheduleTimelines({super.key, required this.itineraryId});

  final int itineraryId;

  @override
  State<ScheduleTimelines> createState() => _ScheduleTimelinesState();
}

class _ScheduleTimelinesState extends State<ScheduleTimelines> {
  @override
  void initState() {
    super.initState();
    context
        .read<ScheduleBloc>()
        .add(RequestScheduleEvent(itineraryId: widget.itineraryId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ScheduleLoading || state is ScheduleInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ScheduleFailure) {
            return Center(child: Text(state.error));
          }

          if (state.schedule != null) {
            final schedule = state.schedule!;

            // create a map the date as keys and create a list of schedule items by date
            final scheduleItemsPerDay = schedule.scheduleItems
                .fold<Map<String, List<ScheduleItem>>>({}, (map, item) {
              final dateOnly =
                  DateUtils.dateOnly(item.startTime).toIso8601String();
              final mapHasDayOfScheduleItem = map[dateOnly];

              if (mapHasDayOfScheduleItem == null) {
                map[dateOnly] = [item];
              } else {
                map.keys.forEach((key) {
                  final date = DateTime.parse(key);
                  final isSameDay = DateUtils.isSameDay(item.startTime, date);
                  if (isSameDay) {
                    map[key]!.add(item);
                  }
                });
              }

              return map;
            });

            // TODO: show maps here with all relevant point of interests and routes

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final date = scheduleItemsPerDay.keys.toList()[index];
                final dateOnly = DateUtils.dateOnly(DateTime.parse(date));
                final scheduleItems = scheduleItemsPerDay[date]!;
                return Column(
                  children: [
                    Text(
                      "${dateOnly.month}/${dateOnly.day}/${dateOnly.year}",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ...scheduleItems.map((item) {
                      return TimelineTile(
                        endChild: SizedBox(
                          height: 200,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name),
                              SizedBox(height: 16),
                              Text(item.description),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16,
                );
              },
              itemCount: scheduleItemsPerDay.keys.length,
            );
          }

          return const Center(
            child: Text("There are no schedule items for this itinerary"),
          );
        },
      ),
    );
  }
}
