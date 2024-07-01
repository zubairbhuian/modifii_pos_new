import 'package:flutter/material.dart';
import 'package:flutter_base/config/fonts.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  // ***** Color *****
  primaryColor: const Color(0xfff65b1c),
  primaryColorDark: const Color(0xff1C1917),
  primaryColorLight: const Color.fromARGB(255, 146, 255, 132),
  canvasColor: Colors.white,
  cardColor: const Color(0xffD7D3CC),
  disabledColor: const Color(0xffC4CACF),
  dividerColor: Colors.grey.shade300,
  dialogBackgroundColor: const Color(0xffF9FAFD),
  hintColor: const Color.fromARGB(255, 128, 129, 133),
  focusColor: Colors.grey.shade600,
  highlightColor: const Color(0x000000ff),
  indicatorColor: const Color(0x000000ff),
  shadowColor: const Color(0x000000ff),
  splashColor: const Color.fromARGB(69, 50, 124, 242),
  scaffoldBackgroundColor: const Color(0xffEAE8E3),
  secondaryHeaderColor: null,
  applyElevationOverlayColor: false,
  hoverColor: const Color(0x000000ff),
  unselectedWidgetColor: const Color(0xffEEEEEE),
  colorScheme: const ColorScheme.light(
    error: Colors.red,
    background: Color(0xff0c0c0c),
  ),

  // *****  Others Color *****
  // primarySwatch: MyFunc.createMaterialColor(const Color(0xff8A0051)),
  // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
  //     .copyWith(background: const Color(0xffFFFFFF)),

  // *****  brightness *****
  // brightness: Brightness.light,
  // ****** Font Family ******
  fontFamily: Fonts.primary,
  // ****** Card Theme ******
  cardTheme: CardTheme(
      color: const Color(0xffF9FAFD),
      shadowColor: Colors.black,
      surfaceTintColor: null,
      margin: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
      ),
      elevation: 1),
  // ****** Text Theme ******
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      //******  Label  ******
      labelLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff1E2022)),
      labelMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xff1E2022)),
      labelSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xff1E2022)),

      //******  Body  ******
      bodyLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xff666666)),
      bodyMedium: TextStyle(
          fontFamily: Fonts.primary, fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xff666666)),
      //******  Title  ******
      titleLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      titleMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      titleSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      //******  HeadLine  ******
      headlineLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      headlineMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      headlineSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      //******  Display  ******
      displayLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 60,
          fontWeight: FontWeight.w700,
          color: Color(0xff0C1C2C)),
      displayMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 55,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
      displaySmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Color(0xff0C1C2C)),
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(Colors.grey.shade400),
    trackColor: MaterialStateProperty.all(Colors.grey.shade200),
    crossAxisMargin: -12,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300,
    thickness: 2,
    space: 10,
  ),
);
