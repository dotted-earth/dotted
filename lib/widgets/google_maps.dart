import 'dart:async';

import 'package:dotted/utils/constants/env.dart';
import 'package:dotted/utils/devices/devices.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final location = await DevicesUtils.getLocation();
      if (location.latitude == null || location.longitude == null) return;

      setState(() {
        _currentPosition = LatLng(location.latitude!, location.longitude!);
      });
      await fetchLocationUpdates();
      final polylines = await fetchPolylinePoints();
      await generatePolylineFromPoints(polylines);
    });
  }

  @override
  dispose() async {
    super.dispose();
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
    if (_locationStream != null) {
      _locationStream!.cancel();
    }
  }

  static const _googlePlex = LatLng(37.422131, -122.084801);

  late StreamSubscription<LocationData>? _locationStream;

  static const CameraPosition _origin = CameraPosition(
    target: LatLng(0, 0),
    zoom: 1,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _currentPosition;
  Map<PolylineId, Polyline> polylines = {};

  Future<void> fetchLocationUpdates() async {
    final GoogleMapController controller = await _controller.future;

    _locationStream = DevicesUtils.subscribeToLocationUpdates((data) async {
      if (data.longitude == null || data.latitude == null) return;

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(data.latitude!, data.longitude!), zoom: 15),
        ),
      );

      setState(() {
        _currentPosition = LatLng(data.latitude!, data.longitude!);
      });
    }, null, null, null);
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    if (_currentPosition == null) return [];
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
        Env.googleMapsKey,
        PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        PointLatLng(_googlePlex.latitude, _googlePlex.longitude));

    if (result.points.isEmpty) return [];

    return result.points
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }

  Future<void> generatePolylineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _origin,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      polylines: Set<Polyline>.of(polylines.values),
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
    );
  }
}
