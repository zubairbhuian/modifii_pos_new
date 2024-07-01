import 'package:get/get.dart';

import '../controllers/employee_controller.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(
      () => EmployeeController(),
    );
  }
}
