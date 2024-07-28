import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/models/meta_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';

import '../models/order_status_model.dart';

class DineInOrderController extends GetxController {
  static DineInOrderController get to => Get.find();

  List<OrderStatusModel> orderStatusList = [];
  getOrderStatus() async {
    try {
      var res =
          await BaseController.to.apiService.makeGetRequest(URLS.orderStatus);
      if (res.statusCode == 200) {
        orderStatusList.assignAll((res.data["data"] as List)
            .map((e) => OrderStatusModel.fromJson(e))
            .toList());
        update();
      }
    } catch (e) {
      kLogger.e('Error from %%%% OrderStatus %%%% => $e');
    }
  }

  List<OrderModel> orderList = [];
  MetaModel? pagination;
  getOrder() async {
    try {
      var res = await BaseController.to.apiService.makeGetRequest(URLS.orders);
      if (res.statusCode == 200) {
        orderList.assignAll((res.data["data"] as List)
            .map((e) => OrderModel.fromJson(e))
            .toList());
        pagination = MetaModel.fromJson(res.data["meta"]);
        update();
      }
      // kLogger.e(res.data["meta"]);
      // kLogger.e(pagination?.total);
    } catch (e) {
      kLogger.e('Error from %%%% OrderStatus %%%% => $e');
    }
  }

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  

  @override
  void onInit() {
    getOrderStatus();
    getOrder();
    super.onInit();
  }
}
