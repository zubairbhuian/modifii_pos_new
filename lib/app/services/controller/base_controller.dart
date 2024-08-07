import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../base/api_service.dart';
import '../base/preferences.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();

  final ApiService apiService;

  BaseController({required this.apiService});

  bool get isFirstTime => Preferences.isFirstTime;

  set isFirstTime(bool isFirstTime) => Preferences.isFirstTime = isFirstTime;

  bool get isLoggedIn => Preferences.accessToken.isNotEmpty;

  set token(String token) => Preferences.accessToken = token;

  void logout() {
    // Preferences.clear();
  }

  void playTapSound() {
    AudioPlayer().play(AssetSource('audio/tap_sound_1.mp3'));
  }
}
