import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../utils/logger.dart';
import '../../../utils/urls.dart';
import 'package:printing/printing.dart';
import '../order/models/dine_in_order_model.dart';
import '../dine-in-orders/widgets/printers_list_dialog.dart';

class OrdersController extends GetxController {
  static OrdersController get to => Get.find();

  RxList<OrderData> ordersList = <OrderData>[].obs;

  bool isLoadingOrders = false;
  getOrders() async {
    // Map<String, dynamic>? queryParameters = {
    //   "limit": 20,
    // };
    isLoadingOrders = true;
    update();
    ordersList.clear();
    try {
      var res = await Dio().get(URLS.ordersList);
      if (res.statusCode == 200) {
        ordersList.assignAll((res.data["orders"]["data"] as List)
            .map((e) => OrderData.fromJson(e))
            .toList());

        /// Save fetched posts to Hive for future use
        // await MyHive.saveAllProducts(productList);

        isLoadingOrders = false;
        update();
      }
      kLogger.e('>> total: ${ordersList.length}');
    } catch (e) {
      kLogger.e('Error from %%%% get orders list %%%% => $e');
    }
  }

  RxString printerName = ''.obs;
  // final pdf = pw.Document();
  void printReceipt() async {
    await Printing.listPrinters().then(
      (value) => printersListDialog(value),
    );
  }

  @override
  void onInit() {
    // getOrders();
    super.onInit();
  }
}
