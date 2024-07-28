import 'package:flutter_base/app/modules/clockIn/controllers/clock_in_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/controllers/dine_in_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:get/get.dart';

import '../controllers/pos_controller.dart';

class PosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosController>(() => PosController(),);
    Get.put<DineInController>(DineInController(), permanent: true);
    Get.put<DineInOrderController>(DineInOrderController(), permanent: true);
    Get.put<OrdersController>(OrdersController(), permanent: true);
    Get.put<ClockInController>(ClockInController(), permanent: true);
  }
}
