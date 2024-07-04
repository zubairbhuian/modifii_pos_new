import 'package:get/get.dart';

import 'package:flutter_base/app/modules/auth/controllers/signin_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
