// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/models/order_model.dart';
import 'package:flutter_base/app/modules/pos/models/order_place_model.dart';
import 'package:flutter_base/app/utils/my_formatter.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../utils/static_colors.dart';
import '../../../widgets/popup_dialogs.dart';
import '../../../utils/logger.dart';
import '../models/dine_in_order_model.dart';
import '../models/table_model.dart';

class TablesController extends GetxController {
  static TablesController get to => Get.find();
  bool isShowOrderDetails = false;
  void updateIsShowOrderDetails(bool value) {
    isShowOrderDetails = value;
    update();
  }

  RxInt selectedTableIndex = 0.obs;
  void updateSelectedTableIndex(int value) {
    selectedTableIndex.value = value;
  }

  RxList<TableModel> tablesList = <TableModel>[].obs;

  void getTables() async {
    try {
      var res = await Dio().get(URLS.tableList);
      // Logger().e(res);
      if (res.statusCode == 200) {
        tablesList.assignAll(
          (res.data as List).map((e) => TableModel.fromJson(e)).toList(),
        );

        availableTablesIdNumber = getAvailableList(tablesList);
      }
    } catch (e) {
      kLogger.e('Error from %%%% get tables %%%% => $e');
    }
  }

  RxList<TableModel> barsList = <TableModel>[].obs;

  void getBars() async {
    try {
      var res = await Dio().get(URLS.barList);
      if (res.statusCode == 200) {
        barsList.assignAll(
          (res.data as List).map((e) => TableModel.fromJson(e)).toList(),
        );

        availableBarsIdNumber = getAvailableList(barsList);
      }
    } catch (e) {
      kLogger.e('Error from %%%% get bars %%%% => $e');
    }
  }

  // get all bar list
  RxList<TableModel> allBarsList = <TableModel>[].obs;

  void getAllBars() async {
    try {
      var res = await Dio().get(URLS.allBarList);
      if (res.statusCode == 200) {
        allBarsList.assignAll(
          (res.data as List).map((e) => TableModel.fromJson(e)).toList(),
        );

        // availableBarsIdNumber = getAvailableList(barsList);
      }
    } catch (e) {
      kLogger.e('Error from %%%% get bars %%%% => $e');
    }
  }

  RxList<TableModel> hallsList = <TableModel>[].obs;
  void getHalls() async {
    try {
      var res = await Dio().get(URLS.hallList);
      if (res.statusCode == 200) {
        hallsList.assignAll(
          (res.data as List).map((e) => TableModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      kLogger.e('Error from %%%% get halls %%%% => $e');
    }
  }

  List<Map<String, String>> availableTablesIdNumber = [];
  TableModel? selectedTable;
  OrderData? orderOfBookedTable;
  void updateSelectedTable(TableModel value) async {
    selectedTable = value;

    if (value.status == 2) {
      if (value.id != null) {
        getOrderDetailsOfTable(value.id!);
      }
    }
    update();
  }

  void getOrderDetailsOfTable(int tableId) async {
    try {
      var res = await Dio().get(URLS.orderOfBookedTable(tableId));
      if (res.statusCode == 200) {
        orderOfBookedTable = OrderData.fromJson(res.data['order']);
        // kLogger.i(res.data);
        if (orderOfBookedTable != null) {
          setOrderCartData();
        } else {
          PopupDialog.showErrorMessage("Failed to get order details!");
        }
      }
    } catch (e) {
      kLogger.e('Error from %%%% get order of table %%%% => $e');
    }
  }

  void setOrderCartData() {
    PosController.to.cartList.clear();
    double gst = orderOfBookedTable?.totalTaxAmount?.toDouble() ?? 0;
    double pst = orderOfBookedTable?.pstAmount?.toDouble() ?? 0;
    double gratuity = orderOfBookedTable?.gratuityAmount?.toDouble() ?? 0;
    double total = orderOfBookedTable?.orderAmount?.toDouble() ?? 0;

    PosController.to.cartGSTAmount.value = gst;
    PosController.to.cartPSTAmount.value = pst;
    PosController.to.cartGratuityAmount.value = gratuity;
    PosController.to.cartTotalAmount.value = total;
    PosController.to.cartSubTotalPrice.value = total - (gst + pst + gratuity);
    selectedGuestNumbers = orderOfBookedTable?.numberOfPeople.toString();

    if (orderOfBookedTable?.details != null) {
      for (int i = 0; i < orderOfBookedTable!.details!.length; i++) {
        var item = orderOfBookedTable?.details?[i];
        PosController.to.cartList.add(Cart(
          id: item?.productDetails?.id.toString() ?? '',
          type: item?.productType.toString() ?? '',
          name: item?.productDetails?.name.toString() ?? '',
          price: item?.price ?? 0,
          description: item?.productDetails?.description.toString() ?? '',
          quantity: item?.quantity ?? 0,
          serveFirst: item?.serveFirst ?? '',
          togo: item?.toGo ?? '',
          dontMake: item?.dontMake ?? '',
          rush: item?.rush ?? '',
          heat: item?.heat ?? '',
          kitchenNote: item?.kitchenNote ?? '',
          isLiquor: item?.isLiquor ?? 0,
        ));
      }
    }
    update();
    PosController.to.update();
  }

  List<Map<String, String>> availableBarsIdNumber = [];
  TableModel? selectedBar;
  void updateSelectedBar(TableModel value) {
    selectedBar = value;
    update();
  }

  bool isTableOrBarSelected() {
    if (selectedBar != null || selectedTable != null) {
      return true;
    } else {
      return false;
    }
  }

  List<Map<String, String>> getAvailableList(List list) {
    var values = list
        .where((e) => e.status == 1) //available
        .map((e) => {'${e.id}': '${e.number}'})
        .toList();
    update();
    return values;
  }

  List<String> guestNumbers = List.generate(25, (index) => "${index + 1}");
  String? selectedGuestNumbers;
  void updatedSelectedGuestNumbers(String? value) {
    selectedGuestNumbers = value;
    PosController.to.getTotalPrice();
    update();
  }

  clearSelections() {
    selectedTable = null;
    selectedBar = null;
    selectedGuestNumbers = null;
    update();
  }

  Color getColor(int status) {
    switch (status) {
      case 1:
        return OrderColors.available;
      case 2:
        return OrderColors.booked;
      case 3:
        return OrderColors.serving;
      case 4:
        return OrderColors.onlineBooking;
      case 5:
        return OrderColors.combined;
      case 6:
        return OrderColors.hold;
      default:
        return Colors.transparent;
    }
  }

  //******* ORDER ITEMS RECIEPTS ******* */
  //list of total receipts
  List<List<OrderItemModel>> orderReceiptsList = [];
  //initial receipt items
  List<OrderItemModel> orderItemsList = [];
  //copy list of orderItemsList
  List<OrderItemModel> orderItemsListTemporary = [];

  void getOrderItems() {
    for (int i = 1; i <= 8; i++) {
      int randomInt = Random().nextInt(4) + 1;
      double randomDouble = Random().nextDouble() * 199;
      orderItemsList.add(
        OrderItemModel(
          name: 'Item Name',
          quantity: randomInt,
          price: randomDouble,
        ),
      );
    }

    orderReceiptsList.add(orderItemsList);
    update();
    orderItemsListTemporary = List.from(orderItemsList);
  }

  final List<String> branches = [
    'Branch 1',
    'Branch 2',
    'Branch 3',
  ];
  String? selectedBranch;
  void updateSelectedBranch(String? value) {
    selectedBranch = value;
    update();
  }

  List<OrderItemModel> orderItemsListSplit = [];
  void toggleOrderItemsListSplit(OrderItemModel item) {
    if (!orderItemsListSplit.contains(item)) {
      orderItemsListSplit.add(item);
      orderItemsListTemporary.remove(item);
    } else {
      orderItemsListSplit.remove(item);
      orderItemsListTemporary.add(item);
    }
    isItemContainsOnSplitList(item);
    update();
  }

  bool isItemContainsOnSplitList(OrderItemModel item) {
    return orderItemsListSplit.contains(item);
  }

  void splitReceipts() {
    if (orderItemsListSplit.isNotEmpty) {
      List<OrderItemModel> list = List.from(orderItemsListSplit);
      orderReceiptsList.add(list);
      orderReceiptsList[0] = List.from(orderItemsListTemporary);
      orderItemsListSplit.clear();
      update();
    }
  }

  TextEditingController startDateTEC = TextEditingController();
  updateStartDate(DateTime? date) {
    if (date != null) {
      startDateTEC.text =
          MyFormatter.formatDate(date.toString().split(' ').first);
      update();
    }
  }

  TextEditingController endDateTEC = TextEditingController();
  updateEndDate(DateTime? date) {
    if (date != null) {
      endDateTEC.text =
          MyFormatter.formatDate(date.toString().split(' ').first);
      update();
    }
  }

  // table active
  RxInt dineInTableActiveIndex = (-1).obs;
  RxInt barTableActiveIndex = (-1).obs;
  RxInt halTableActiveIndex = (-1).obs;
  // available table and booking table
  RxInt currentTableNumber = (-1).obs;
  RxInt currentTableId = (-1).obs;
  RxInt currentTableStatus = (-1).obs;
  String currentTableType = '';
  onActiveTable({
    required String tableType,
    required int index,
    required TableModel table,
  }) {
    currentTableType = tableType;
    Logger().e(currentTableStatus);

    if (tableType == "Bar Area") {
      // for bar
      dineInTableActiveIndex.value = -1;
      barTableActiveIndex.value = index;
      halTableActiveIndex.value = -1;
      currentTableNumber.value = table.number ?? -1;
      currentTableStatus.value = table.status ?? -1;
      currentTableId.value = table.id ?? -1;
    } else if (tableType == "Dine-In Area") {
      // for Dine-in
      dineInTableActiveIndex.value = index;
      barTableActiveIndex.value = -1;
      halTableActiveIndex.value = -1;
      currentTableNumber.value = table.number ?? -1;
      currentTableStatus.value = table.status ?? -1;
      currentTableId.value = table.id ?? -1;
    } else {
      // for Hall
      dineInTableActiveIndex.value = -1;
      barTableActiveIndex.value = -1;
      halTableActiveIndex.value = index;
      currentTableNumber.value = table.number ?? -1;
      currentTableStatus.value = table.status ?? -1;
      currentTableId.value = table.id ?? -1;
    }
    //get current order
    if (currentTableStatus.value == 2) {
      getCurrentOrder(table.id ?? -1);
    }
  }

  // On change table status
  onChangeTableStatus({
    required int tableId,
    required int status,
  }) async {
    String url = "${URLS.baseURL}/table/$tableId/hold/$status";
    String barUrl = "${URLS.baseURL}/bars/$tableId/hold/$status";
    try {
      PopupDialog.showLoadingDialog();
      if (currentTableType == "Bar Area") {
        var res = await Dio().get(barUrl);
        if (res.statusCode == 200) {
          // for bar
          getAllBars();
          currentTableStatus.value = status;
        }
      } else {
        var res = await Dio().get(url);
        if (res.statusCode == 200) {
          Logger().e(url);
          // for Dine-in
          getTables();
          // for Hall
          getHalls();
          currentTableStatus.value = status;
        }
      }
      PopupDialog.closeLoadingDialog();
    } catch (e) {
      PopupDialog.closeLoadingDialog();
      kLogger.e('Error from get all bar table %%%% get halls %%%% => $e');
    }
  }

  // get current-order
  OrderModel? currentOrderData;

  getCurrentOrder(int tableNumber) async {
    try {
      currentOrderData = null;
      update();
      var res =
          await Dio().get("${URLS.baseURL}/table/$tableNumber/current-order");
      // Logger().e(res);
      if (res.statusCode == 200) {
        currentOrderData = OrderModel.fromJson(res.data["order"]);
        update();
      }
    } catch (e) {
      kLogger.e('Error from %%%% get tables %%%% => $e');
    }
  }

  Cart productDetailsToCart(Detail product) {
    return Cart(
      id: product.id.toString(),
      type: product.productType,
      name: product.productDetails?.name ?? "",
      price: product.price,
      description: product.productDetails?.description ?? "",
      quantity: product.quantity,
      variations: [],
      isLiquor: product.isLiquor.toInt(),
    );
  }

  List<Cart> convertProductListToCartList(List<Detail> products) {
    return products.map((product) => productDetailsToCart(product)).toList();
  }

  // onAddIrem
  onAddIrem(List<Detail> item) {
    PosController.to.cartList = convertProductListToCartList(item);
    PosController.to.getTotalPrice();
    PosController.to.update();
    PosController.to.onchangePage(0);
  }

  RxInt paymentMathodActiveIndex = (-1).obs;
  List<String> paymentMathod = [
    "Visa",
    "Master Card",
    "Amex",
    "Debit Card",
    "Cash",
    "Others",
    "Cash & Card"
  ];

  // Table pages
  RxBool isShowTablePaymentbtn = false.obs;

  /// split order
  RxInt splitPaymentActiveIndex = (-1).obs;
  RxBool isShowsplitPaymentbtn = false.obs;
  splitPaymentShowHide() {}

  @override
  void onInit() {
    // getTables();
    // getBars();
    // getAllBars();
    // getHalls();
    // getOrderItems();
    super.onInit();
  }
}

//temporary table model
class TableModelTemp {
  String tableNo;
  bool isBooked;
  TableModelTemp({
    required this.tableNo,
    required this.isBooked,
  });
}

//temporary orderItem model
class OrderItemModel {
  String name;
  int quantity;
  double price;
  OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
  });
}
