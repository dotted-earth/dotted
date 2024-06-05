import 'package:dotted/utils/devices/devices.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class NearbyActivities extends StatefulWidget {
  const NearbyActivities({super.key});

  @override
  State<NearbyActivities> createState() => _NearbyActivitiesState();
}

class _NearbyActivitiesState extends State<NearbyActivities> {
  LocationData? _location;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    if (mounted) {
      final location = await DevicesUtils.getLocation();

      if (location == null) {
        return;
      }

      setState(() {
        _location = location;
      });

      // final something = await ViatorProvider().getDestinations('taiwan');
      // final viatorDestinations =
      //     ViatorDestinationModel.fromMap(jsonDecode(something.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("What's Nearby", style: Theme.of(context).textTheme.titleLarge),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
