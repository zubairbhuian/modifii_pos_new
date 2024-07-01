import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  //splash screen
  RxBool isShowSplashScreen = true.obs;
  void hideSplashScreen() {
    Timer(const Duration(milliseconds: 2500), () {
      isShowSplashScreen.value = false;
    });
  }

  //Hide Password pad on inactivity
  Timer? inactivityTimer;
  void startInactivityTimer() {
    inactivityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick > 5) {
        toggleStartup(true);
      }
    });
  }

  //startup logo screen
  RxBool isStartup = true.obs;
  void toggleStartup(bool value) {
    isStartup.value = value;
    if (!value) {
      inactivityTimer?.cancel();
      startInactivityTimer();
    } else {
      inactivityTimer?.cancel();
      password.value = "";
    }
  }

  RxString password = "".obs;
  RxInt passwordLength = 6.obs;
  List<String> numberList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "*",
    "0",
    "*",
  ];

  // **** Login *****

  void login() async {
    Map<String, dynamic> data = {"auth_pin": password.value};
    try {
      kLogger.i('auth: $data');
      PopupDialog.showLoadingDialog();
      var res = await Dio().post(URLS.login, data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.offAllNamed(Routes.POS);
      } else {
        PopupDialog.showErrorMessage("password is not valid");
      }
      kLogger.e(res.data);
    } catch (e) {
      kLogger.e('Error from %%%% login %%%% => $e');
      PopupDialog.closeLoadingDialog();
    }
  }

  removePassword() {
    if (password.value.isNotEmpty) {
      password.value = password.value.substring(0, password.value.length - 1);
    }
  }

  addPassword(String characterToAdd) {
    if (password.value.length < 6) {
      password.value += characterToAdd;
      // kLogger.e(password.value);
    }
  }

  @override
  void onInit() {
    hideSplashScreen();
    super.onInit();
  }
}
