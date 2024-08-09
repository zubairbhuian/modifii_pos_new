import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/config/fonts.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  // ***** Color *****
  primaryColor: const Color(0xfff65b1c),
  primaryColorDark: const Color(0xff0c0c0c),
  primaryColorLight: const Color(0xff118A00),
  canvasColor: const Color(0xff191919),
  cardColor: const Color(0xff2F2D31),
  disabledColor: const Color(0xffC4CACF),
  dividerColor: const Color(0xff5B636B),
  dialogBackgroundColor: const Color(0xffF9FAFD),
  hintColor: const Color(0xffA0A3A9),
  focusColor: Colors.grey.shade700,
  highlightColor: const Color(0x000000ff),
  indicatorColor: const Color(0x000000ff),
  shadowColor: const Color(0x000000ff),
  splashColor: Colors.blueGrey.shade600,
  // scaffoldBackgroundColor: const Color(0xff0c0c0c),
  scaffoldBackgroundColor: Colors.black,
  secondaryHeaderColor: null,
  hoverColor: const Color(0x000000ff),
  unselectedWidgetColor: const Color(0xffEEEEEE),
  colorScheme: const ColorScheme.dark(
    error: Color(0xffE7474B),
    background: Color(0xffEDF2F7),
  ),

  // *****  Others Color *****
  // primarySwatch: MyFunc.createMaterialColor(const Color(0xff8A0051)),
  // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
  //     .copyWith(background: const Color(0xffFFFFFF)),
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

  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff0274ff);
      }
      return const Color.fromARGB(255, 0, 0, 0);
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color.fromARGB(255, 66, 66, 66);
      }
      return Colors.white;
    }),
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return const Color.fromARGB(50, 223, 223, 223).withOpacity(.1);
      }
      return Colors.transparent;
    }),
  ),
  //  datePickerTheme
  datePickerTheme: DatePickerThemeData(
    backgroundColor: const Color(0xff2F2D31),
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
  // *****  brightness *****
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
          color: Color(0xffEDF2F7)),
      labelMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xffEDF2F7)),
      labelSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xffEDF2F7)),

      //******  Body  ******
      bodyLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xffEDF2F7)),
      bodyMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xffEDF2F7)),
      bodySmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xffEDF2F7)),
      //******  Title  ******
      titleLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xffEDF2F7)),
      titleMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xffEDF2F7)),
      titleSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xffEDF2F7)),
      //******  HeadLine  ******
      headlineLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: Color(0xffEDF2F7)),
      headlineMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Color(0xffEDF2F7)),
      headlineSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color(0xffEDF2F7)),
      //******  Display  ******
      displayLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 60,
          fontWeight: FontWeight.w700,
          color: Color(0xffEDF2F7)),
      displayMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 55,
          fontWeight: FontWeight.w700,
          color: Color(0xffEDF2F7)),
      displaySmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Color(0xffEDF2F7)),
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(Colors.grey.shade800),
    trackColor: MaterialStateProperty.all(Colors.grey.shade500),
    crossAxisMargin: -12,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300,
    thickness: 2,
    space: 10,
  ),
  radioTheme: const RadioThemeData(
    fillColor: MaterialStatePropertyAll(
      Color(0xfff65b1c),
    ),
  ),
);
