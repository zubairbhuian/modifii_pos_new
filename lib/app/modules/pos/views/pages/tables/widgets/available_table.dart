import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';
import '../../../../../../utils/static_colors.dart';
import '../../../../../../widgets/custom_btn.dart';
import '../../../../../../widgets/my_custom_text.dart';
import '../../../../controllers/tables_controller.dart';

class AvailableTableOption extends StatelessWidget {
  const AvailableTableOption({
    super.key,
    required this.controller,
  });

  final TablesController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return MyCustomText(
              'Table ${controller.currentTableNumber}',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            );
          }),
          const SizedBox(height: 18),
          Row(
            children: [
              PrimaryBtn(
                onPressed: () {
                  //
                  // controller.selectedTableId = null;
                  // controller.selectedBarId = null;
                  // if (controller.barTableActiveIndex.value > 0) {
                  //   controller.selectedBarId =
                  //       controller.currentTableId.value.toString();
                  //   controller.updateSelectedBarId;
                  // } else if (controller.dineInTableActiveIndex.value > 0) {
                  //   Logger().e("di");
                  //   controller.selectedTableId =
                  //       controller.currentTableId.value.toString();
                  //   controller.updateSelectedTableId;
                  // } else if (controller.halTableActiveIndex.value > 0) {
                  //   Logger().e("hall");

                  //   // controller.selectedBarId =
                  //   //     controller.currentTableId.value.toString();
                  //   // controller.updateSelectedBarId;
                  //   // controller.selectedTableId =
                  //   //     controller.currentTableId.value.toString();
                  //   // controller.updateSelectedTableId;
                  // }

                  PosController.to.onchangePage(0);
                },
                width: 150,
                text: 'Start Order',
                textColor: Colors.white,
                color: StaticColors.orangeColor,
              ),
              const SizedBox(width: 30),
              Obx(() {
                return Visibility(
                  visible:
                      controller.currentTableStatus.value == 6 ? false : true,
                  replacement: PrimaryBtn(
                    onPressed: () {
                      controller.onChangeTableStatus(
                          tableId: controller.currentTableId.value, status: 1);
                    },
                    width: 150,
                    text: 'Release Table',
                    textColor: Colors.white,
                    color: StaticColors.greenColor,
                  ),
                  child: PrimaryBtn(
                    onPressed: () {
                      controller.onChangeTableStatus(
                          tableId: controller.currentTableId.value, status: 6);
                    },
                    width: 150,
                    text: 'Hold Table',
                    textColor: Colors.white,
                    color: StaticColors.pinkColor,
                  ),
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}
