import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/pos_controller.dart';
import '../../order/models/order_model.dart';

class SplitOrderController extends GetxController {
  static SplitOrderController get to => Get.find();

  final OrderModel mainOrder = PosController.to.myOrder;
  OrderModel order = OrderModel();
  bool? isSplitByAmount;

  //split by amount
  TextEditingController noOfGuestTEC = TextEditingController();
  TextEditingController totalAmountTEC = TextEditingController();
  int splitCheckCount = 0;
  updateSplitCheckCount(int value) {
    splitCheckCount = value;
    if (value > 0) {
      isSplitByAmount = true;
    } else {
      isSplitByAmount = null;
    }
    update();
  }

  //select items
  List<CartModel> selectedItems = [];
  List<List<CartModel>> listOfSpitChecksByItems = [];
  updateSelectedItems(CartModel item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    update();
  }

  addToListOfSelectedItems() {
    if (selectedItems.isNotEmpty) {
      listOfSpitChecksByItems.add(List.from(selectedItems));
      order.carts.removeWhere((item) => selectedItems.contains(item));
      selectedItems.clear();
      isSplitByAmount = false;
      update();
    } else {
      //show snackbar
    }
  }

  resetSplitChecks() {
    order.carts = List.from(mainOrder.carts);
    selectedItems.clear();
    listOfSpitChecksByItems.clear();
    splitCheckCount = 0;
    isSplitByAmount = null;
    update();
  }

  @override
  void onInit() {
    order = OrderModel(
      carts: List.from(mainOrder.carts),
      totalGst: mainOrder.totalGst,
      totalPst: mainOrder.totalPst,
      totalGratuity: mainOrder.totalGratuity,
      totalDiscount: mainOrder.totalDiscount,
      totalOrderAmount: mainOrder.totalOrderAmount,
      orderId: mainOrder.orderId,
      numberOfPeople: mainOrder.numberOfPeople,
    );
    noOfGuestTEC.text = PosController.to.myOrder.numberOfPeople.toString();
    totalAmountTEC.text =
        PosController.to.myOrder.totalOrderAmount.toStringAsFixed(2);
    super.onInit();
  }
}
