import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/auth/controllers/signin_controller.dart';
import 'package:flutter_base/app/modules/auth/views/signIn/widgets/signin_email.dart';
import 'package:flutter_base/app/modules/auth/views/signIn/widgets/signin_password.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class SigninView extends GetView<SignInController> {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // header
            SizedBox(
              height: 100,
              child: SvgPicture.asset(
                width: 150,
                'assets/images/splash/yogo_logo.svg',
                colorFilter: ColorFilter.mode(
                  ConfigController.to.isLightTheme
                      ? Colors.black
                      : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
                child: Center(
              child: SizedBox(
                // color: Colors.amber,
                width: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: controller.formKey,
                      child: Obx(() {
                        return Visibility(
                          visible: controller.isEmailPage.value,
                          //  for password
                          replacement: const SingnInPassword(),
                          // for email
                          child: const SignInEmail(),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    PrimaryBtn(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          if (controller.isEmailPage.value) {
                            controller.isEmailPage.value = false;
                          } else {
                            // login process
                            controller.signInWithEmail();
                          }
                        }
                      },
                      text: "Next",
                      textColor: Colors.white,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
