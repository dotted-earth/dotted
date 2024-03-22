import 'package:flutter/material.dart';

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
}
