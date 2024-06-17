import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dotted/bloc/schedule/schedule_bloc.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/models/schedule_item_model.dart';
import 'package:dotted/models/schedule_item_type_enum.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:dotted/widgets/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key, required this.itinerary});
  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ItinerariesRepository(
          ItinerariesProvider(), UnsplashRepository(UnsplashProvider())),
      child: BlocProvider(
        create: (context) => ScheduleBloc(itinerary: itinerary),
        child: ScheduleTimelines(
          itinerary: itinerary,
        ),
      ),
    );
  }
}

class ScheduleTimelines extends StatefulWidget {
  const ScheduleTimelines({super.key, required this.itinerary});

  final ItineraryModel itinerary;

  @override
  State<ScheduleTimelines> createState() => _ScheduleTimelinesState();
}

class _ScheduleTimelinesState extends State<ScheduleTimelines> {
  @override
  void initState() {
    super.initState();
    context
        .read<ScheduleBloc>()
        .add(RequestScheduleEvent(itineraryId: widget.itinerary.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip to ${widget.itinerary.destination}"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading || state is ScheduleInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ScheduleFailure) {
              return Center(child: Text(state.error));
            }

            if (state.scheduleItems != null) {
              // create a map the date as keys and create a list of schedule items by date

              return DefaultTabController(
                initialIndex: 0,
                length: state.scheduleItems!.keys.length,
                child: Column(
                  children: [
                    const SizedBox(height: 256, child: GoogleMaps()),
                    TabBar(
                      tabs: state.scheduleItems!.keys.sorted((a, b) {
                        return a.compareTo(b);
                      }).map((date) {
                        final parsedDate = DateTime.parse(date);
                        return Tab(
                          child: Column(
                            children: [
                              Text(DateFormat.E().format(parsedDate)),
                              Text(DateFormat.Md().format(parsedDate)),
                            ],
                          ),
                        );
                      }).toList(),
                      onTap: (index) {
                        final keys = state.scheduleItems!.keys.toList();
                        final selectedKey = keys[index];
                        if (selectedKey == state.selectedDay) return;

                        context.read<ScheduleBloc>().add(
                            DayScheduleChangeEvent(selectedDay: keys[index]));
                      },
                      isScrollable: state.scheduleItems!.length > 5,
                      tabAlignment: state.scheduleItems!.length > 5
                          ? TabAlignment.start
                          : null,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: state.scheduleItems!.keys.map((key) {
                          final scheduleItems = state.scheduleItems![key];
                          return ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            children: scheduleItems!.mapIndexed((index, item) {
                              return TimelineTile(
                                indicatorStyle: IndicatorStyle(
                                  color: Colors.black87,
                                ),
                                endChild: SizedBox(
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 16, left: 16),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                item.scheduleItemType ==
                                                        ScheduleItemTypeEnum
                                                            .transportation
                                                    ? FontAwesome.car_on_solid
                                                    : item.scheduleItemType ==
                                                            ScheduleItemTypeEnum
                                                                .activity
                                                        ? FontAwesome
                                                            .person_walking_solid
                                                        : FontAwesome
                                                            .utensils_solid,
                                              ),
                                              const SizedBox(width: 16),
                                              Flexible(
                                                  child: Text(item
                                                      .pointOfInterest!.name)),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                              "${DateFormat.Hm().format(item.startTime!)} - ${DateFormat.Hm().format(item.endTime!)}"),
                                          Text(item
                                              .pointOfInterest!.description),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text("There are no schedule items for this itinerary"),
            );
          },
        ),
      ),
    );
  }
}
