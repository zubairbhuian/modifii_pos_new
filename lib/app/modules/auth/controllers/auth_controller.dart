import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
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
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "*",
    "0",
    "*",
  ];

  // **** Login *****

  void login() async {
    Map<String, dynamic> data = {"auth_pin": int.parse(password.value)};
    PopupDialog.showLoadingDialog();
    if (password.value.isNotEmpty) {
      var res =
          await BaseController.to.apiService.makePostRequest(URLS.login, data);
      // var res = await Dio().post(URLS.login, data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.offAllNamed(Routes.POS);
      } else {
        PopupDialog.showErrorMessage("password is not valid");
      }
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
