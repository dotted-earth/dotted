import 'package:dotted/database.dart';
import 'package:dotted/screens/upcoming_itineraries_page.dart';
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
  Destination? _destination;

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
              displayStringForOption: (option) =>
                  '${option.city}, ${option.country}',
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
                          final Destination option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                              _destination = option;
                            },
                            child: ListTile(
                              title: Text('${option.city}, ${option.country}'),
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
                if (text.length < 2) return List<Destination>.empty();
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
                  validator: (value) {
                    print(value);
                    if (value == null || value.isEmpty) {
                      return "Please enter a destination";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) async {
                    if (value.isEmpty) return;

                    final draftItinerary = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        builder: (context) =>
                            ItineraryForm(destination: _destination!));

                    if (draftItinerary == null) return;
                  },
                );
              },
            ),

            const SizedBox(
              height: 16,
            ),
            Text(
              "Upcoming Trips",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            UpcomingItinerariesPage(key: upcomingItinerariesKey),
            const SizedBox(
              height: 20,
            ),
            // const SizedBox(
            //   height: 300,
            //   width: double.maxFinite,
            //   child: GoogleMaps(),
            // )
          ],
        ),
      ),
    );
  }
}
