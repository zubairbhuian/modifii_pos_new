import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:get/get.dart';

import '../../pos/controllers/orders_controller.dart';
import '../../pos/dine-in-orders/controllers/dine_in_order_controller.dart';
import '../../pos/dine-in/controllers/dine_in_controller.dart';
import '../controllers/clock_in_controller.dart';

class ClockInBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ClockInController>(
    //   () => ClockInController(),
    // );
    Get.put(ClockInController(), permanent: true);
    Get.lazyPut<PosController>(
      () => PosController(),
    );
    Get.put<DineInController>(DineInController(), permanent: true);
    Get.put<DineInOrderController>(DineInOrderController(), permanent: true);
    Get.put<OrdersController>(OrdersController(), permanent: true);
    Get.put<ClockInController>(ClockInController(), permanent: true);
  }
}
