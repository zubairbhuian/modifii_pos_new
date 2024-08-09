import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/my_func.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import '../../../../utils/static_colors.dart';
import '../views/order_details_view.dart';

class TableBody extends GetView<DineInController> {
  final bool isScrollable;
  const TableBody({this.isScrollable = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: isScrollable ? false : true,
        physics: isScrollable
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: controller.tableCategoryList.length,
        itemBuilder: (contex, index) {
          var tables = controller.tableCategoryList[index].tables;
          return SizedBox(
            child: Column(
              children: [
                // header
                _title(controller.tableCategoryList[index].name),
                StaggeredGrid.count(
                  crossAxisCount: 10,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(tables.length, (index) {
                    var table = tables[index];
                    return GestureDetector(
                      //onTap
                      onTap: () async {
                        BaseController.to.playTapSound();

                        // if table is avaiable
                        if (table.tableAvailability == "AVAILABLE") {
                          if (isScrollable) {
                            PosController.to.updateTableName(table);
                          } else {
                            PosController.to.onchangePage(0);
                            PosController.to.updateTableName(table);
                            Get.back();
                          }
                          // if table is BOOKING
                        } else if (table.tableAvailability == "BOOKING") {
                          if (table.currentOrder != null) {
                            PosController.to.myOrder = table.currentOrder!;
                            Get.to(() => const OrderDetailsView());
                          }
                          // PopupDialog.showLoadingDialog();
                          // bool hasData = await controller
                          //     .getOrderById(table.currentOrderId ?? "");
                          // PopupDialog.closeLoadingDialog();
                          // if (hasData) {
                          //   Get.to(() => const OrderDetailsView());
                          // }
                        }
                      },
                      // for onDoubleTap
                      onDoubleTap: () {
                        if (table.tableAvailability == "AVAILABLE") {
                          BaseController.to.playTapSound();
                          if (table.tableAvailability == "HOLD_TABLES") {
                            controller.onChangeTableStatus(
                                id: table.id, status: "AVAILABLE");
                          } else {
                            controller.onChangeTableStatus(
                                id: table.id, status: "HOLD_TABLES");
                          }
                        }
                      },
                      // onLongPressStart
                      onLongPressStart: (details) {
                        if (table.tableAvailability == "AVAILABLE") {
                          BaseController.to.playTapSound();
                          if (table.tableAvailability == "HOLD_TABLES") {
                            controller.onChangeTableStatus(
                                id: table.id, status: "AVAILABLE");
                          } else {
                            controller.onChangeTableStatus(
                                id: table.id, status: "HOLD_TABLES");
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: MyFunc.getTableColorWithStatus(
                              table.tableAvailability),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyCustomText(
                                    table.tableName,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                MyCustomText(
                                  '${table.tableCapacity}',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: MyCustomText(
                                'username',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: MyCustomText(
                                '\$34.99',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Container _title(String title) {
    return Container(
      height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      color: StaticColors.blackLightColor,
      child: MyCustomText(
        title.toUpperCase(),
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
