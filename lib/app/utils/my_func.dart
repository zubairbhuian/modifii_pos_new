import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/app/utils/static_colors.dart';

class MyFunc {
  static Color productColor(String text) {
    if (text == "VEG") {
      return StaticColors.greenColor;
    } else if (text == "NON_VEG") {
      return const Color(0xffFD571A);
    } else {
      return StaticColors.purpleColor;
    }
  }

  static MaterialColor createMaterialColor(Color color) {
    List<int> strengths = <int>[
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900
    ];
    Map<int, Color> swatch = <int, Color>{};

    for (int i = 0; i < 10; i++) {
      final int strength = strengths[i];
      final double blend = 1 - (i / 10);
      swatch[strength] = Color.fromRGBO(
        color.red,
        color.green,
        color.blue,
        blend,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  static Color getTableColorWithStatus(String? status) {
    switch (status) {
      case "AVAILABLE":
        return const Color(0xff118A01); // Available
      case "BOOKING":
        return const Color(0xffF8931D); // Booked
      // case "WALK-IN":
      //   return const Color(0xffF8931D);
      case "COOKING":
        return const Color.fromARGB(255, 255, 106, 52); // COOKING
      case "SERVING":
        return const Color.fromARGB(255, 255, 106, 52); // Serving
      case "ONLINE_BOOKING":
        return const Color(0xff006AFF); // Online Booking
      case "COMBINED_TABLES":
        return const Color(0xff6864D2); // Combined
      case "HOLD_TABLES":
        return const Color(0xffEA295E); // Combined
      default:
        return const Color.fromARGB(255, 75, 22, 36); // Hold
    }
  }

  static String getStatusWithStatusCode(int? status) {
    switch (status) {
      case 1:
        return "Available"; // Available
      case 2:
        return "Booked"; // Booked
      case 3:
        return "UServing"; // UServing
      case 4:
        return "Online Booking"; // Online Booking
      case 5:
        return "Combined"; // Combined
      default:
        return "Hold"; // Hold
    }
  }

  static num yogotRound(num value) {
    num roundToNearest = 0.05;
    return (value / roundToNearest).ceil() * roundToNearest;
  }

  static int generateRandomNumericId() {
  Random random = Random();
  int min = 100000;
  int max = 999999;
  return min + random.nextInt(max - min);
}
}
