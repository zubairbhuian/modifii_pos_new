import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pos_controller.dart';

class SplitOrderController extends GetxController {
  static SplitOrderController get to => Get.find();

  TextEditingController noOfGuestTEC = TextEditingController();
  TextEditingController totalAmountTEC = TextEditingController();

  int splitCheckCount = 0;
  updateSplitCheckCount(int value) {
    splitCheckCount = value;
    update();
  }

  @override
  void onInit() {
    noOfGuestTEC.text = PosController.to.myOrder.numberOfPeople.toString();
    totalAmountTEC.text =
        PosController.to.myOrder.totalOrderAmount.toStringAsFixed(2);
    super.onInit();
  }
}
