import 'package:dotted/database.dart';
import 'package:dotted/screens/upcoming_itineraries_page.dart';
import 'package:dotted/utils/constants/database.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class ItinerariesPage extends StatefulWidget {
  const ItinerariesPage({super.key});

  @override
  State<ItinerariesPage> createState() => _ItinerariesPageState();
}

class _ItinerariesPageState extends State<ItinerariesPage> {
  GlobalKey upcomingItinerariesKey = GlobalKey();
  final Map<String, dynamic> textFieldsValue = {};

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
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a destination";
                }
                return null;
              },
              onFieldSubmitted: (value) async {
                if (value.isEmpty) return;
                final modal1 = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (context) {
                      var _dates = [];

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.maxFinite,
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: TextEditingController(text: value),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                prefixIcon: const Icon(
                                  Icons.map,
                                ),
                                enabled: false,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.luggage_outlined,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Travelers")
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add),
                                        splashRadius: 1,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text("1"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.remove),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CalendarDatePicker2(
                              config: CalendarDatePicker2Config(
                                calendarType: CalendarDatePicker2Type.range,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 2),
                              ),
                              value: [],
                              onValueChanged: (dates) {
                                if (dates.length < 2) return;
                                _dates = dates;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton.filled(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });

                if (modal1 == null) return;

                final modal2 = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.maxFinite,
                        height: 600,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      );
                    });
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
