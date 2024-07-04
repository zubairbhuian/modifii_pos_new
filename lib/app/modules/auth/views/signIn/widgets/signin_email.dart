import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/auth/controllers/signin_controller.dart';
import 'package:flutter_base/app/utils/my_reg_exp.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class SignInEmail extends GetView<SignInController> {
  const SignInEmail({
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
            'Sign in',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Obx(() {
            return CustomTextField(
              controller: controller.emailControlller,
              label: const Text("Enter your email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter an email address ';
                } else if (!RegExp(MyRegExp.email).hasMatch(value)) {
                  return "Enter an valid  email address or phone number.";
                }
                return null;
              },
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
            );
          }),
        ],
      );
    });
  }
}
