import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/auth/controllers/signin_controller.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/utils/my_reg_exp.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class SigninView extends GetView<SignInController> {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
                          replacement: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back',
                                style: theme.textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 6),
                              Text.rich(
                                  TextSpan(
                                      text: controller.emailControlller.text,
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              controller.isEmailPage.value =
                                                  true;
                                            },
                                          text: " Change",
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                                  color:
                                                      StaticColors.blueColor),
                                        )
                                      ]),
                                  style: theme.textTheme.labelLarge),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: controller.passwordControlller,
                                label: const Text("Password"),
                                obscureText: controller.isPassHide.value,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.isPassHide.value =
                                        !controller.isPassHide.value;
                                  },
                                  child: Icon(
                                      controller.isPassHide.value == true
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                ),
                                validator: (value) {
                                  if (controller.isEmailPage.value == true) {
                                    return null;
                                  } else if (value == null || value.isEmpty) {
                                    return 'Enter a password';
                                  } else if (value.length <= 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 19),
                              ),
                            ],
                          ),
                          // for email
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign in',
                                style: theme.textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: controller.emailControlller,
                                label: const Text("Enter your email"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter an email address ';
                                  } else if (!RegExp(MyRegExp.email)
                                      .hasMatch(value)) {
                                    return "Enter an valid  email address or phone number.";
                                  }
                                  return null;
                                },
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 19),
                                  
                              ),
                            ],
                          ),
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
