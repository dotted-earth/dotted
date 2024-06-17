import 'package:collection/collection.dart';
import 'package:dotted/bloc/schedule/schedule_bloc.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:dotted/widgets/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final List<Color> _colors = [
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.purple.shade200,
    Colors.red.shade200
  ];

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
              final accommodation = state.accommodation!;

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
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.E().format(parsedDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                DateFormat.Md().format(parsedDate),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w800),
                              ),
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
                            children: [
                              TimelineTile(
                                  isFirst: true,
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
                                            Text(
                                              accommodation
                                                  .pointOfInterest!.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Starting from ${accommodation.pointOfInterest!.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    height: 50,
                                    width: 50,
                                    drawGap: true,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    indicator: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.amber),
                                      child: const Center(
                                        child: Icon(
                                          FontAwesome.flag_checkered_solid,
                                        ),
                                      ),
                                    ),
                                  )),
                              ...scheduleItems!.mapIndexed((index, item) {
                                final color =
                                    _colors[(index + 1) % _colors.length];
                                return TimelineTile(
                                  indicatorStyle: IndicatorStyle(
                                    height: 50,
                                    width: 50,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    indicator: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: color),
                                      child: Center(
                                          child: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(fontSize: 24),
                                      )),
                                    ),
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
                                            Text(
                                              item.pointOfInterest!.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Badge(
                                                  largeSize: 32,
                                                  backgroundColor: Colors.blue,
                                                  textColor:
                                                      Colors.blue.shade50,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  label: Text(
                                                    DateFormat("H:mm a").format(
                                                        item.startTime!),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text("-",
                                                    style: TextStyle(
                                                        fontSize: 24)),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Badge(
                                                  largeSize: 32,
                                                  backgroundColor: Colors.blue,
                                                  textColor:
                                                      Colors.blue.shade50,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  label: Text(
                                                    DateFormat("H:mm a")
                                                        .format(item.endTime!),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              item.pointOfInterest!.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              TimelineTile(
                                  isLast: true,
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
                                            Text(
                                              accommodation
                                                  .pointOfInterest!.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Finish at ${accommodation.pointOfInterest!.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    height: 50,
                                    width: 50,
                                    indicator: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.amber),
                                        child: const Center(
                                          child: Icon(
                                            FontAwesome.lines_leaning_solid,
                                          ),
                                        )),
                                  )),
                            ],
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
