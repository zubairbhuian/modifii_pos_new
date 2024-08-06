import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/popup_dialogs.dart';
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
  OrderModel selectedItems = OrderModel();
  List<OrderModel> listOfSpitChecksByItems = [];
  updateSelectedItems(CartModel item) {
    if (selectedItems.carts.contains(item)) {
      selectedItems.carts.remove(item);
    } else {
      selectedItems.carts.add(item);
    }
    calculateSelectedAmount(selectedItems.carts);

    selectedItems = OrderModel(
      carts: selectedItems.carts,
      totalGst: selectedGST,
      totalPst: selectedPST,
      totalGratuity: selectedGratuity,
      subTotal: selectedSubtotal,
      totalOrderAmount: selectedTotal,
    );
    update();
  }

  addToListOfSelectedItems() {
    if (selectedItems.carts.isNotEmpty) {
      listOfSpitChecksByItems.add(selectedItems);
      order.carts.removeWhere((item) => selectedItems.carts.contains(item));
      calculateMainAmount(items: order.carts);
      selectedItems = OrderModel();
      isSplitByAmount = false;
      update();
    } else {
      PopupDialog.showErrorMessage('Please select the items for split');
    }
  }

  num mainGST = 0;
  num mainPST = 0;
  num mainGratuity = 0;
  num mainSubtotal = 0;
  num mainTotal = 0;
  calculateMainAmount({List<CartModel>? items}) {
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
      num liquorAmount = items.fold(
        0.0,
        (subtotal, item) =>
            item.isLiquor ? subtotal + (item.price * item.quantity) : subtotal,
      );
      mainPST = liquorAmount * 0.10;
      if (order.numberOfPeople >= 6) {
        mainGratuity = mainSubtotal * 0.18;
      }
      mainTotal = mainSubtotal + mainGST + mainPST + mainGratuity;
    }
  }

  num selectedGST = 0;
  num selectedPST = 0;
  num selectedGratuity = 0;
  num selectedSubtotal = 0;
  num selectedTotal = 0;
  calculateSelectedAmount(List<CartModel> items) {
    selectedSubtotal = items.fold(
        0.0, (subtotal, item) => subtotal + (item.price * item.quantity));
    selectedGST = selectedSubtotal * 0.05;
    num liquorAmount = items.fold(
      0.0,
      (subtotal, item) =>
          item.isLiquor ? subtotal + (item.price * item.quantity) : subtotal,
    );
    selectedPST = liquorAmount * 0.10;
    if (order.numberOfPeople >= 6) {
      selectedGratuity = selectedSubtotal * 0.18;
    }
    selectedTotal =
        selectedSubtotal + selectedGST + selectedPST + selectedGratuity;
  }

  void divideItems() {
    List<CartModel> items =
        selectedItems.carts.isEmpty ? order.carts : selectedItems.carts;
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

    if (selectedItems.carts.isEmpty) {
      order.carts = dividedItems;
    } else {
      order.carts.removeWhere((item) => selectedItems.carts.contains(item));
      order.carts.addAll(dividedItems);
    }

    update();
  }

  resetSplitChecks() {
    order.carts = List.from(mainOrder.carts);
    calculateMainAmount();
    selectedItems = OrderModel();
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
      orderType: mainOrder.orderType,
      paymentStatus: mainOrder.paymentStatus,
    );
    totalAmountTEC.text =
        PosController.to.myOrder.totalOrderAmount.toStringAsFixed(2);
    calculateMainAmount();
    super.onInit();
  }
}
