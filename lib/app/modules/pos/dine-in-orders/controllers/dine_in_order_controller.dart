import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/models/meta_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/order_status_model.dart';

class DineInOrderController extends GetxController {
  static DineInOrderController get to => Get.find();

  TextEditingController startDate = TextEditingController();



  TextEditingController search = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController serverStartDate = TextEditingController();
  TextEditingController serverEndDate = TextEditingController();

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
  getOrder({
    String? orderStatus,
    String? startDate,
    String? endDate,
    String? page,
    String? limit = "1",
    String? search,
  }) async {
    Map<String, dynamic>? queryParameters = {
      if (orderStatus != null) "orderStatus": orderStatus,
      if (startDate != null) "startDate": startDate,
      if (endDate != null) "endDate": endDate,
      if (page != null) "page": page,
      if (limit != null) "limit": limit,
      if (search != null) "search": search,
    };
    try {
      var res = await BaseController.to.apiService
          .makeGetRequest(URLS.orders, queryParameters: queryParameters);
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



  @override
  void onInit() {
    getOrderStatus();
    getOrder();
    super.onInit();
  }
}
