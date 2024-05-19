import 'dart:async';

import 'package:dotted/utils/devices/devices.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_config/flutter_config.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final location = await DevicesUtils.getLocation();
      if (location.latitude == null || location.longitude == null) return;

      setState(() {
        _currentPosition = Marker(
          markerId: MarkerId('currentPosition'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          flat: true,
          draggable: false,
          position: LatLng(location.latitude!, location.longitude!),
        );
      });
      await fetchLocationUpdates();
      final polylines = await fetchPolylinePoints();
      await generatePolylineFromPoints(polylines);
    });
  }

  static const _googlePlex = LatLng(37.422131, -122.084801);

  static const CameraPosition _origin = CameraPosition(
    target: LatLng(0, 0),
    zoom: 1,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Marker _currentPosition = Marker(markerId: MarkerId("currentPosition"));
  Map<PolylineId, Polyline> polylines = {};

  Future<void> fetchLocationUpdates() async {
    final GoogleMapController controller = await _controller.future;

    DevicesUtils.subscribeToLocationUpdates((data) async {
      if (data.longitude == null || data.latitude == null) return;

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(data.latitude!, data.longitude!), zoom: 15),
        ),
      );
      setState(() {
        _currentPosition = Marker(
          markerId: MarkerId("currentPosition"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          flat: true,
          draggable: false,
          position: LatLng(data.latitude!, data.longitude!),
        );
      });
    }, null, null, null);
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();
    final position = _currentPosition.position;

    final result = await polylinePoints.getRouteBetweenCoordinates(
        FlutterConfig.get('GOOGLE_PLACES_KEY'),
        PointLatLng(position.latitude, position.longitude),
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
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _origin,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.from([_currentPosition]),
        polylines: Set<Polyline>.of(polylines.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchLocationUpdates,
        label: const Text('Get Location'),
        icon: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
