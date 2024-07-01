import 'package:flutter_base/app/modules/product/models/product_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // get sub category
  String? selectedCategory;
  String? selectedproductType;
  var productList = <ProductModel>[].obs;
  getCategoryList() async {
    //     Map<String, dynamic> data = {
    //   "title": titleController.text,
    //   "type": selectedCategory // VEG, NON_VEG, DRINKS
    // }; 
    var res = await BaseController.to.apiService.dio.get(URLS.products);

    if (res.statusCode == 200) {
      productList.assignAll((res.data["data"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList());
    }
  }

  @override
  void onInit() {
    getCategoryList();
    super.onInit();
  }
}
