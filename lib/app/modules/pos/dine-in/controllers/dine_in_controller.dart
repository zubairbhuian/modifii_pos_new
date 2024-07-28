import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/models/table_category_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class DineInController extends GetxController {
  static DineInController get to => Get.find();
  
  
  // is show order details
  bool isShowOrderDetails = false;
  void updateIsShowOrderDetails(bool value) {
    isShowOrderDetails = value;
    update();
  }

  // active table index
  RxInt currentTableNumber = (-1).obs;
  RxInt selectedTableIndex = 0.obs;
  void updateSelectedTableIndex(int value) {
    selectedTableIndex.value = value;
  }

  RxList<TableCategoryModel> tableCategoryList = <TableCategoryModel>[].obs;
  void getTableCategories() async {
    try {
      var res =
          await BaseController.to.apiService.makeGetRequest(URLS.tableCategory);
      if (res.statusCode == 200) {
        tableCategoryList.assignAll(
          (res.data["data"] as List)
              .map((e) => TableCategoryModel.fromJson(e))
              .toList(),
        );
      }
    } catch (e) {
      kLogger.e('Error from %%%% get tables %%%% => $e');
    }
  }

  // tible status change
  Future onChangeTableStatus(
      {required String id, required String status}) async {
    Map<String, dynamic> data = {
      "tableAvailability": status,
    };
    PopupDialog.showLoadingDialog();
    var res = await BaseController.to.apiService
        .makePatchRequest("${URLS.tableHold}/$id", data);
    PopupDialog.closeLoadingDialog();
    if (res.statusCode == 200) {
      getTableCategories();
    }
  }

  List<String> guestNumbers = List.generate(25, (index) => "${index + 1}");
  String? selectedGuestNumbers;
  void updatedSelectedGuestNumbers(String? value) {
    selectedGuestNumbers = value;
    PosController.to.getTotalPrice();
    update();
  }

  @override
  void onReady() {
    getTableCategories();
    super.onReady();
  }
}