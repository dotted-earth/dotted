import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/screens/upcoming_itineraries_page.dart';
import 'package:dotted/widgets/itinerary_form.dart';
import 'package:flutter/material.dart';

class ItinerariesPage extends StatefulWidget {
  const ItinerariesPage({super.key});

  @override
  State<ItinerariesPage> createState() => _ItinerariesPageState();
}

class _ItinerariesPageState extends State<ItinerariesPage> {
  GlobalKey upcomingItinerariesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Itineraries"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Text("Upcoming Trips",
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            UpcomingItinerariesPage(key: upcomingItinerariesKey),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Past Trips",
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text("Drafts", style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await showModalBottomSheet(
              context: context,
              builder: (context) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  height: 800,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                            padding: const EdgeInsets.all(24),
                          )
                        ],
                      ),
                      const ItineraryForm()
                    ],
                  ),
                );
              });

          if (data is ItineraryModel) {
            setState(() {
              upcomingItinerariesKey = GlobalKey();
            });
          }
        },
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
