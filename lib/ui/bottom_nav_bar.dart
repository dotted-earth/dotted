import 'package:flutter/material.dart';
import 'package:dotted/pages/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
  });
  final int selectedIndex;
  final List<Destination> destinations;
  final ValueChanged<int> onDestinationSelected;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 0,
      indicatorColor: Colors.green.shade300,
      indicatorShape: const CircleBorder(
        eccentricity: 0,
      ),
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (index) => {widget.onDestinationSelected(index)},
      animationDuration: const Duration(
        milliseconds: 500,
      ),
      destinations: widget.destinations.map<NavigationDestination>(
        (Destination destination) {
          return NavigationDestination(
            icon: Icon(destination.icon),
            label: destination.title,
          );
        },
      ).toList(),
    );
  }
}
