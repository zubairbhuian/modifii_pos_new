import 'package:flutter/material.dart';
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
          fontWeight: FontWeight.w600,
          color: Color(0xffEDF2F7)),
      titleMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xffEDF2F7)),
      titleSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xffEDF2F7)),
      //******  HeadLine  ******
      headlineLarge: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: Color(0xffEDF2F7)),
      headlineMedium: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xffEDF2F7)),
      headlineSmall: TextStyle(
          fontFamily: Fonts.primary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
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
);
