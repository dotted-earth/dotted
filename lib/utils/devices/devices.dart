import 'package:flutter/material.dart';
import "package:location/location.dart";

final location = new Location();

class DevicesUtils {
  DevicesUtils._();

  static EdgeInsets _getDeviceViewPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding;
  }

  static double getDeviceToolbarHeight() {
    return kToolbarHeight;
  }

  static double getDeviceBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getStatusBarHeight(BuildContext context) {
    return _getDeviceViewPadding(context).top;
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static Future<LocationData> getLocation() async {
    return await location.getLocation();
  }

  static Future<void> subscribeToLocationUpdates(
      bool inBackground,
      Function(LocationData) onData,
      Function? onError,
      void Function()? onDone,
      bool? cancelOnError) async {
    location.enableBackgroundMode(enable: inBackground);

    location.onLocationChanged.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
