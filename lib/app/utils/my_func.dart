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

  static Color getTableColorWithStatus(int? status) {
    switch (status) {
      case 1:
        return const Color(0xff118A01); // Available
      case 2:
        return const Color(0xffF8931D); // Booked
      case 3:
        return const Color.fromARGB(255, 255, 106, 52); // UServing
      case 4:
        return const Color(0xff006AFF); // Online Booking
      case 5:
        return const Color(0xff6864D2); // Combined
      default:
        return const Color(0xffEA295E); // Hold
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
}
