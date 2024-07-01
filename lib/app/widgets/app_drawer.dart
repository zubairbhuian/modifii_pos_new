import 'package:flutter/material.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/const.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            PrimaryBtnWithChild(
              width: double.infinity,
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 36,
              ),
            ),
            const SizedBox(height: 8),
            // category
            PrimaryBtn(
              width: double.infinity,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.SUB_CATEGORY);
              },
              color: StaticColors.blueColor,
              text: "Subcagetory",
              textColor: Colors.white,
            ).marginOnly(bottom: 16),
            // product
            PrimaryBtn(
              width: double.infinity,
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.PRODUCT);
              },
              color: StaticColors.blueColor,
              text: "Products",
              textColor: Colors.white,
            ).marginOnly(bottom: 16),
            //  employee
            PrimaryBtn(
              width: double.infinity,
              onPressed: () {
                Get.back();
                // Get.toNamed(Routes.SUB_CATEGORY);
              },
              color: StaticColors.greenColor,
              text: "employee",
              textColor: Colors.white,
            ).marginOnly(bottom: 16),
          ],
        ),
      ),
    );
  }
}
