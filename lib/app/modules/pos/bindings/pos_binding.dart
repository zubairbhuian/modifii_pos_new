import 'package:flutter_base/app/modules/clockIn/controllers/clock_in_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:get/get.dart';

import '../controllers/pos_controller.dart';

class PosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosController>(() => PosController());
    Get.put<TablesController>(TablesController(), permanent: true);
    Get.put<OrdersController>(OrdersController(), permanent: true);
    Get.put<ClockInController>(ClockInController(), permanent: true);
  }
}
