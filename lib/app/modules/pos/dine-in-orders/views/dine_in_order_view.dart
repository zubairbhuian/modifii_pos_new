import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/controllers/dine_in_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/views/table_orders_list.dart';
import 'package:flutter_base/app/modules/pos/views/widgets/top_menu.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class DineInOrderView extends GetView<DineInOrderController> {
  const DineInOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<DineInOrderController>(builder: (c) {
      return Column(
        children: [
          const TopMenu(),
          const SizedBox(height: 16),
          const Expanded(
              child: SingleChildScrollView(
            child: TableOrdersList(),
          )),
          // pagination
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: theme.scaffoldBackgroundColor,
            // decoration:
            //     BoxDecoration(color: theme.disabledColor.withOpacity(.3)),
            child: GetBuilder<DineInOrderController>(builder: (controller) {
              if (controller.pagination != null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:
                      List.generate(controller.pagination!.totalPages, (index) {
                    var data = controller.pagination;
                    return PrimaryBtn(
                            onPressed: () async {
                              PopupDialog.showLoadingDialog();
                              await controller.getOrder(page: "${index + 1}");
                              PopupDialog.closeLoadingDialog();
                            },
                            width: 40,
                            height: 40,
                            color: data?.currentPage == index + 1
                                ? theme.primaryColor
                                : theme.disabledColor,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            text: "${index + 1}")
                        .marginOnly(
                            right:
                                controller.pagination!.totalPages == index + 1
                                    ? 0
                                    : 2);
                  }),
                );
              }
              return const SizedBox();
            }),
          )
        ],
      );
    });
  }
}
