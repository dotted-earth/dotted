import 'package:dotted/features/itinerary/presentation/screens/past_itineraries_page.dart';
import 'package:dotted/features/itinerary/presentation/screens/upcoming_itineraries_page.dart';
import 'package:dotted/features/itinerary/presentation/widgets/itinerary_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItinerariesPage extends StatefulWidget {
  const ItinerariesPage({super.key});

  @override
  State<ItinerariesPage> createState() => _ItinerariesPageState();
}

class _ItinerariesPageState extends State<ItinerariesPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Itineraries"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Upcoming",
            ),
            Tab(
              text: "Past",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                UpcomingItinerariesPage(),
                PastItinerariesPage(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
                      ItineraryForm()
                    ],
                  ),
                );
              });
        },
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
