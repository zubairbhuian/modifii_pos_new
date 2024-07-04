import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/auth/controllers/signin_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class SingnInPassword extends GetView<SignInController> {
  const SingnInPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 6),
          Text.rich(
              TextSpan(text: controller.emailControlller.text, children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.isEmailPage.value = true;
                    },
                  text: " Change",
                  style: theme.textTheme.labelLarge
                      ?.copyWith(color: StaticColors.blueColor),
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
                controller.isPassHide.value = !controller.isPassHide.value;
              },
              child: Icon(controller.isPassHide.value == true
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
          ),
        ],
      );
    });
  }
}
