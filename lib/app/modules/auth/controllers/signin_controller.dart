import 'package:flutter/material.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/services/base/base_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailControlller =
      TextEditingController(text: "mehedi@gmail.com");
  TextEditingController passwordControlller =
      TextEditingController(text: "123456789");

  RxBool isEmailPage = true.obs;
  RxBool isPassHide = true.obs;

  // **** Login *****
  void signInWithEmail() async {
    Map<String, dynamic> data = {
      "email": emailControlller.text,
      "password": passwordControlller.text,
    };
    PopupDialog.showLoadingDialog();
    BaseModel res =
        await BaseController.to.apiService.makePostRequest(URLS.login, data);
    PopupDialog.closeLoadingDialog();
    if (res.statusCode == 200 || res.statusCode == 201) {
      Get.offAllNamed(Routes.CLOCK_IN);
    } else {
      // if (res.statusCode == 404 || res.statusCode == 406)
      PopupDialog.showErrorMessage(res.data["message"]);
    }
  }
}
