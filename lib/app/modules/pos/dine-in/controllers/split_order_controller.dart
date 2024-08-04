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
      calculateAllAmount(items: order.carts);
      selectedItems.clear();
      isSplitByAmount = false;
      update();
    } else {
      //show snackbar
    }
  }

  num mainGST = 0;
  num mainPST = 0;
  num mainGratuity = 0;
  num mainSubtotal = 0;
  num mainTotal = 0;
  calculateAllAmount({List<CartModel>? items}) {
    if (items == null) {
      mainGST = order.totalGst;
      mainPST = order.totalPst;
      mainGratuity = order.totalGratuity;
      mainTotal = order.totalOrderAmount;
      mainSubtotal = order.carts.fold(
          0.0, (subtotal, item) => subtotal + (item.price * item.quantity));
    } else {
      mainSubtotal = items.fold(
          0.0, (subtotal, item) => subtotal + (item.price * item.quantity));
      mainGST = mainSubtotal * 0.05;
      mainPST = mainSubtotal * 0.10;
      if (order.numberOfPeople >= 6) {
        mainGratuity = mainSubtotal * 0.18;
      }
      mainTotal = mainSubtotal + mainGST + mainPST + mainGratuity;
    }
  }

  void divideItems() {
    List<CartModel> items = selectedItems.isEmpty ? order.carts : selectedItems;
    List<CartModel> dividedItems = [];

    for (var item in items) {
      if (item.quantity > 1) {
        for (int i = 0; i < item.quantity; i++) {
          dividedItems
              .add(CartModel(name: item.name, price: item.price, quantity: 1));
        }
      } else {
        dividedItems.add(item);
      }
    }

    if (selectedItems.isEmpty) {
      order.carts = dividedItems;
    } else {
      order.carts.removeWhere((item) => selectedItems.contains(item));
      order.carts.addAll(dividedItems);
    }

    update();
  }

  resetSplitChecks() {
    order.carts = List.from(mainOrder.carts);
    calculateAllAmount();
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
    calculateAllAmount();
    super.onInit();
  }
}
