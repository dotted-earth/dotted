import 'dart:async';
import 'dart:io';

import 'package:dotted/bloc/schedule/schedule_bloc.dart';
import 'package:dotted/utils/constants/env.dart';
import 'package:dotted/utils/devices/devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  final List<Color> _colors = [
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.purple.shade200,
    Colors.red.shade200
  ];
  LatLng? _currentPosition;
  Map<PolylineId, Polyline> _polylines = {};
  Map<MarkerId, Marker> _markers = {};
  late StreamSubscription<LocationData>? _locationStream;

  static const CameraPosition _origin = CameraPosition(
    target: LatLng(0, 0),
    zoom: 1,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  initState() {
    super.initState();
    _addMarkers();
    _fetchPoints();
    context.read<ScheduleBloc>().on((event, emit) async {
      if (event is DayScheduleChangeEvent) {
        final accommodation = context.read<ScheduleBloc>().state.accommodation!;
        final accommodationMarkerId =
            MarkerId(accommodation.pointOfInterest!.name);

        _markers.removeWhere((key, value) {
          return key != accommodationMarkerId;
        });
        if (!mounted) return;
        setState(() {
          _markers = _markers;
          _polylines = {};
        });
        await _addMarkers();
        await _fetchPoints();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final location = await DevicesUtils.getLocation();
      if (location.latitude == null || location.longitude == null) return;
      await _fetchLocationUpdates();
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

  _addMarkers() async {
    final state = context.read<ScheduleBloc>().state;
    final accommodation = state.accommodation!;
    final scheduleItems = state.scheduleItems![state.selectedDay]!;
    Map<MarkerId, Marker> markers = {};

    final icon = await Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.hotel,
        size: 50,
        color: Colors.white,
      ),
    ).toBitmapDescriptor(
        logicalSize: const Size(100, 100), imageSize: const Size(100, 100));
    final MarkerId accommodationMarkerId =
        MarkerId(accommodation.pointOfInterest!.name);
    final Marker accommodationMarker = Marker(
      markerId: accommodationMarkerId,
      position: LatLng(
        accommodation.pointOfInterest!.location!.lat,
        accommodation.pointOfInterest!.location!.lon,
      ),
      icon: icon,
    );
    markers[accommodationMarkerId] = accommodationMarker;

    var i = 0;
    for (final item in scheduleItems) {
      final icon = await Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: _colors[(i + 1) % _colors.length],
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child:
                Text((i + 1).toString(), style: const TextStyle(fontSize: 32))),
      ).toBitmapDescriptor(
          logicalSize: const Size(100, 100), imageSize: const Size(100, 100));
      final poi = item.pointOfInterest!;
      final MarkerId markerId = MarkerId(poi.name);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(poi.location!.lat, poi.location!.lon),
        icon: icon,
      );
      markers[markerId] = marker;
      i++;
    }

    setState(() {
      _markers = markers;
    });

    await _centerOnAccommodation();
  }

  _centerOnAccommodation() async {
    final GoogleMapController controller = await _controller.future;
    final accommodation = context.read<ScheduleBloc>().state.accommodation!;

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            accommodation.pointOfInterest!.location!.lat,
            accommodation.pointOfInterest!.location!.lon,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> _fetchLocationUpdates() async {
    _locationStream = DevicesUtils.subscribeToLocationUpdates(
      (data) async {
        if (data.longitude == null || data.latitude == null) return;

        if (mounted) {
          setState(() {
            _currentPosition = LatLng(data.latitude!, data.longitude!);
          });
        }
      },
      null,
      null,
      null,
    );
  }

  Future<PolylineResult> getRoutes(
      PolylinePoints polylinePoints,
      PointLatLng source,
      PointLatLng dest,
      List<PolylineWayPoint> waypoints) async {
    return await polylinePoints.getRouteBetweenCoordinates(
      Env.googleMapsKey,
      source,
      dest,
      avoidTolls: true,
      avoidFerries: true,
      wayPoints: waypoints,
    );
  }

  Future<void> _fetchPoints() async {
    final state = context.read<ScheduleBloc>().state;
    final selectedDay = state.selectedDay!;
    final scheduleItems = state.scheduleItems![selectedDay]!;
    final accommodation = state.accommodation!;
    final accommodationPoint = PointLatLng(
        accommodation.pointOfInterest!.location!.lat,
        accommodation.pointOfInterest!.location!.lon);
    final lastScheduleItem = scheduleItems.last;
    final finalDestination = PointLatLng(
        lastScheduleItem.pointOfInterest!.location!.lat,
        lastScheduleItem.pointOfInterest!.location!.lon);
    final PolylinePoints polylinePoints = PolylinePoints();

    final List<PolylineWayPoint> waypoints = scheduleItems.map((item) {
      return PolylineWayPoint(
          location:
              "${item.pointOfInterest!.location!.lat},${item.pointOfInterest!.location!.lon}");
    }).toList();

    try {
      PolylineResult result = await getRoutes(
        polylinePoints,
        accommodationPoint,
        finalDestination,
        waypoints,
      );

      if (result.points.isNotEmpty) {
        final points = result.points.map((PointLatLng point) {
          return LatLng(point.latitude, point.longitude);
        }).toList();

        _generatePolylineFromPoints(points);
      }
    } catch (err) {
      PolylineResult result = await getRoutes(
          polylinePoints, accommodationPoint, finalDestination, []);

      if (result.points.isNotEmpty) {
        final points = result.points.map((PointLatLng point) {
          return LatLng(point.latitude, point.longitude);
        }).toList();

        _generatePolylineFromPoints(points);
      }
    }
  }

  Future<void> _generatePolylineFromPoints(
    List<LatLng> polylineCoordinates,
  ) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 2,
    );

    setState(() {
      _polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _origin,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polylines: Set<Polyline>.of(_polylines.values),
          markers: Set<Marker>.of(_markers.values),
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          buildingsEnabled: false,
          liteModeEnabled: Platform.isAndroid,
        );
      },
    );
  }
}
