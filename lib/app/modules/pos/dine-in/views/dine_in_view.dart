import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/views/widgets/top_menu.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';
import '../widgets/table_availability_header.dart';
import '../widgets/table_body.dart';

class DineInView extends GetView<DineInController> {
  const DineInView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopMenu(),
        SizedBox(height: 16),
        TableAvailabilityHeader(),
        SizedBox(height: 12.0),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TableBody(
                  isScrollable: false,
                ),
              ),
              SizedBox(width: 30),
              // Expanded(
              // flex: 2,
              //   child: Obx(() {
              //     if (controller.currentTableNumber.value == -1) {
              //       return const SizedBox.shrink();
              //     }
              //     return Visibility(
              //       visible:true,
              //       // Available table
              //       replacement: AvailableTableOption(controller: controller),
              //       // Booked table
              //       child: BookedTableOption(controller: controller),
              //     );
              //   }),
              // ),
              // cart area
            ],
          ),
        ),
      ],
    );
  }
}

//** buttons **
Widget _buttons(ThemeData theme) {
  const double btnSize = 130;
  const double txtMaxSize = 35;
  const double txtMinSize = 22;
  return Expanded(
    child: ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          // Obx(
          //   () => Visibility(
          //     visible: PosController.to.isShowPos.value,
          //     replacement: const SizedBox(width: 16),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 16.0, right: 10),
          //       child: PrimaryBtn(
          //         width: btnSize,
          //         height: btnSize,
          //         onPressed: () {
          //           PosController.to.onchangePage(0);
          //         },
          //         color: StaticColors.greenColor,
          //         textColor: Colors.white,
          //         text: 'POS',
          //         textMaxSize: txtMaxSize,
          //         textMinSize: txtMinSize,
          //       ),
          //     ),
          //   ),
          // ),
          PrimaryBtn(
            width: btnSize,
            height: btnSize,
            onPressed: () {
              PosController.to.onchangePage(0);
              // controller.getCategory(type: 'drinks');
            },
            color: StaticColors.greenColor,
            textColor: Colors.white,
            text: 'ORDERS',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ).marginOnly(left: 16),
          // PrimaryBtn(
          //   width: btnSize,
          //   height: btnSize,
          //   onPressed: () {
          //     PosController.to.onchangePage(0);
          //   },
          //   color: StaticColors.greenColor,
          //   textColor: Colors.white,
          //   text: 'POS',
          //   textMaxSize: txtMaxSize,
          //   textMinSize: txtMinSize,
          // ),
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
            isdisabled: true,
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
          const SizedBox(width: 16),
        ],
      ),
    ),
  );
}
