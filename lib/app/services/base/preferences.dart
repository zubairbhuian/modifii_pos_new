// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  static const String KEY_IS_FIRST_TIME = 'is_first_time';
  static const String ACCESS_TOKEN = 'access_token';
  static const String CLOCK_IN_ID = 'Clock_in_id';
  static const String IS_USER_SIGNIN = 'is_user_signin';
  static const String KEY_IS_ACTIVER_EXPERT = 'is_active_Expert';
  static const String KEY_IS_LIGHT = 'is_light';
  static const String CURRENTER_PRINTER = 'currenterPrinter';

  ///  ====== init pref ============
  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// is user signin
  static bool get isUserSignin => preferences.getBool(IS_USER_SIGNIN) ?? false;
  static set isUserSignin(bool value) =>
      preferences.setBool(IS_USER_SIGNIN, value);

  /// isFirstTime
  static bool get isFirstTime => preferences.getBool(KEY_IS_FIRST_TIME) ?? true;
  static set isFirstTime(bool value) =>
      preferences.setBool(KEY_IS_FIRST_TIME, value);

  /// ACCESS_TOKEN
  static String get accessToken => preferences.getString(ACCESS_TOKEN) ?? '';
  static set accessToken(String value) => preferences.setString(ACCESS_TOKEN, value);

  /// currenterPrinter
  static String get currenterPrinter => preferences.getString(CURRENTER_PRINTER) ?? '';
  static set currenterPrinter(String value) => preferences.setString(CURRENTER_PRINTER, value);

  /// CLOCK_IN_ID
  static String get clockInId => preferences.getString(CLOCK_IN_ID) ?? '';
  static set clockInId(String value) => preferences.setString(CLOCK_IN_ID, value);
  /// is light theme
  static bool get isLight =>
      preferences.getBool(KEY_IS_LIGHT) ?? ThemeMode.system == ThemeMode.light;
  static set isLight(bool value) => preferences.setBool(KEY_IS_LIGHT, value);

  // ***** Clear the SharedPreferences *****
  static void clear() {
    preferences.clear();
  }
}
