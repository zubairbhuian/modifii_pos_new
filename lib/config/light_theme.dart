import 'package:flutter/material.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
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
  focusColor: Colors.grey.shade200,
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
  // primarySwatch
  primarySwatch: Colors.blue,
  // checkboxTheme
  checkboxTheme: CheckboxThemeData(
    checkColor: const MaterialStatePropertyAll(Colors.white),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return StaticColors.blueColor;
      }
      return Colors.grey;
    }),
  ),
  //  datePickerTheme
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    dividerColor: Colors.white,
    headerBackgroundColor: StaticColors.blueColor,
    headerForegroundColor: Colors.white,
    todayBackgroundColor:
        const MaterialStatePropertyAll(StaticColors.orangeColor),
    todayForegroundColor: const MaterialStatePropertyAll(Colors.white),
    rangeSelectionBackgroundColor: StaticColors.blueColor.withOpacity(0.2),
    rangeSelectionOverlayColor: const MaterialStatePropertyAll(Colors.green),
    // day Color
    dayForegroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return Colors.black;
    }),
    dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return StaticColors.blueColor;
      }
      return Colors.transparent;
    }),
    // week day Style
    weekdayStyle:
        const TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
    yearStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
    // custom
    cancelButtonStyle: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(StaticColors.redColor),
      surfaceTintColor:
          MaterialStatePropertyAll(StaticColors.redColor.withOpacity(.1)),
      overlayColor:
          MaterialStatePropertyAll(StaticColors.redColor.withOpacity(.2)),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(StaticColors.blueColor),
      surfaceTintColor:
          MaterialStatePropertyAll(StaticColors.blueColor.withOpacity(.1)),
      overlayColor:
          MaterialStatePropertyAll(StaticColors.blueColor.withOpacity(.2)),
    ),
    yearForegroundColor: const MaterialStatePropertyAll(Colors.black),
    surfaceTintColor: StaticColors.blueColor,
  ),

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
          color: Color(0xff1E2022)),
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
  radioTheme: const RadioThemeData(
    fillColor: MaterialStatePropertyAll(Color(0xfff65b1c)),
  ),
);
