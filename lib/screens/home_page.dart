import 'package:dotted/widgets/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:dotted/screens/itineraries_page.dart';
import 'package:dotted/screens/profile_page.dart';
import 'package:dotted/screens/settings_page.dart';
import 'package:dotted/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Itineraries', Icons.airplane_ticket, ItinerariesPage()),
    Destination(1, 'Profile', Icons.person, ProfilePage()),
    Destination(2, 'Settings', Icons.settings, SettingsPage()),
    Destination(3, "Maps", Icons.map_outlined, MapSample())
  ];
  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<Widget> destinationViews;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
      (int index) => GlobalKey(),
    ).toList();
    destinationViews = allDestinations.map<Widget>(
      (Destination destination) {
        return DestinationView(
          destination: destination,
          navigatorKey: navigatorKeys[destination.index],
        );
      },
    ).toList();
  }

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        final NavigatorState navigator =
            navigatorKeys[selectedIndex].currentState!;
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map(
              (Destination destination) {
                final int index = destination.index;
                final Widget view = destinationViews[index];
                if (index == selectedIndex) {
                  return Offstage(offstage: false, child: view);
                } else {
                  return Offstage(child: view);
                }
              },
            ).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: selectedIndex,
          destinations: allDestinations,
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.page);
  final int index;
  final String title;
  final IconData icon;
  final Widget page;
}

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return widget.destination.page;
  }
}