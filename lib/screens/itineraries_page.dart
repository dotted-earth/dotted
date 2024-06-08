import 'package:dotted/database.dart';
import 'package:dotted/widgets/nearby_activities.dart';
import 'package:dotted/widgets/upcoming_itineraries.dart';
import 'package:dotted/utils/constants/database.dart';
import 'package:dotted/widgets/itinerary_form.dart';
import 'package:flutter/material.dart';

class ItinerariesPage extends StatefulWidget {
  const ItinerariesPage({super.key});

  @override
  State<ItinerariesPage> createState() => _ItinerariesPageState();
}

class _ItinerariesPageState extends State<ItinerariesPage> {
  GlobalKey upcomingItinerariesKey = GlobalKey();
  WorldCity? _destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 12, right: 12),
        child: ListView(
          children: [
            const Text(
              "Where would you like to go?",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 16,
            ),
            RawAutocomplete(
              displayStringForOption: (option) {
                final cityName =
                    Set.of([option.city, option.state, option.country])
                        .where((item) => item.isNotEmpty)
                        .toList();
                return cityName.join(', ');
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final WorldCity option = options.elementAt(index);
                          final cityName = Set.of(
                                  [option.city, option.state, option.country])
                              .where((item) => item.isNotEmpty)
                              .toList();
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                              _destination = option;
                            },
                            child: ListTile(
                              title: Text(cityName.join(", ")),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              optionsBuilder: (textEditingValue) async {
                final text = textEditingValue.text;
                if (text.length < 2) return List<WorldCity>.empty();
                return await database.getDestinations(text);
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onFieldSubmitted: (value) async {
                    if (value.isEmpty) return;

                    final draftItinerary = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        builder: (context) =>
                            ItineraryForm(destination: _destination!));

                    if (draftItinerary == null) return;
                    setState(() {
                      upcomingItinerariesKey = GlobalKey();
                    });
                    textEditingController.clear();
                  },
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            UpcomingItineraries(key: upcomingItinerariesKey),
            const SizedBox(
              height: 20,
            ),
            // const SizedBox(
            //   height: 300,
            //   width: double.maxFinite,
            //   child: GoogleMaps(),
            // ),
            // NearbyActivities()
          ],
        ),
      ),
    );
  }
}
