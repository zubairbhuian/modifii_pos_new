import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';

import '../../dine-in/controllers/dine_in_controller.dart';

class TopMenu extends GetView<PosController> {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const double btnSize = 90;
    const double txtMaxSize = 40;
    const double txtMinSize = 13;
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              PosController.to.onchangePage(0);
            },
            color: StaticColors.greenColor,
            textColor: Colors.white,
            text: 'ORDERS',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              // TablesController.to.updateIsShowOrderDetails(false);
              PosController.to.onchangePage(1);
            },
            color: StaticColors.yellowColor,
            textColor: Colors.white,
            text: 'DINE-IN\nORDERS',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              DineInController.to.getTableCategories();
              PosController.to.onchangePage(2);
            },
            padding: EdgeInsets.zero,
            color: StaticColors.purpleColor,
            textColor: Colors.white,
            text: 'DINE-IN',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              PosController.to.onchangePage(3);
            },
            padding: EdgeInsets.zero,
            color: StaticColors.blueColor,
            textColor: Colors.white,
            text: 'TAKEOUT',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          const Spacer(),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {},
            color: StaticColors.blueColor,
            textColor: Colors.white,
            text: 'Dine-in\nSummery',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              // controller.getCategory(type: 'drinks');
            },
            // isdisabled: true,
            color: StaticColors.blueColor,
            textColor: Colors.white,
            text: 'Dine-in \nCash Out',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              // controller.getCategory(type: 'drinks');
            },
            color: StaticColors.greenColor,
            textColor: Colors.white,
            text: 'Take out \nSummery',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              // controller.getCategory(type: 'drinks');
            },
            color: StaticColors.greenColor,
            textColor: Colors.white,
            text: 'Take out \nCash Out',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
        ],
      ),
    );
  }
}
