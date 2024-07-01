import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/views/pages/table_order/table_order_details.dart';
import 'package:flutter_base/app/modules/pos/views/pages/table_order/table_orders_list.dart';
import 'package:get/get.dart';

class TableOrderPage extends GetView<TablesController> {
  const TableOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TablesController>(builder: (c) {
      return Visibility(
        visible: !c.isShowOrderDetails,
        replacement: const TableOrderDetails(),
        child: const TableOrdersList(),
      );
    });
  }
}
