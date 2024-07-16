import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/controllers/dine_in_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/views/table_order_details.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/views/table_orders_list.dart';
import 'package:get/get.dart';

class DineInOrderView extends GetView<DineInOrderController> {
  const DineInOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DineInOrderController>(builder: (c) {
      return Visibility(
        visible: true,
        replacement: const TableOrderDetails(),
        child: const TableOrdersList(),
      );
    });
  }
}
