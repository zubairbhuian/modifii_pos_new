import 'package:flutter_base/app/modules/product/models/product_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';
import '../../../utils/logger.dart';
import '../../subCategory/models/category_type_model.dart';
import '../../subCategory/models/sub_category_model.dart';

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;
  getProductList() async {
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

  CategoryTypeModel? selectedproductType;
  updateSelectedProductType(CategoryTypeModel? value) {
    selectedCategory = null;

    selectedproductType = value;

    filteredCategoryList.value = categoryList
        .where(
          (e) => e.type.toLowerCase() == value?.value.toLowerCase(),
        )
        .toList();
    if (value?.title.toLowerCase() == 'drinks') {
      isShowAlcohol = true;
    } else {
      isShowAlcohol = false;
    }
    update();
  }

  bool isShowAlcohol = false;

  bool isProductAlcohol = false;
  void updateIsProductAlcohol(bool? value) {
    isProductAlcohol = value ?? false;
    update();
  }

  var categoryList = <SubCategoryModel>[].obs;
  var filteredCategoryList = <SubCategoryModel>[].obs;
  getCategoryList() async {
    //     Map<String, dynamic> data = {
    //   "title": titleController.text,
    //   "type": selectedCategory // VEG, NON_VEG, DRINKS
    // };
    try {
      var res = await BaseController.to.apiService.dio.get(URLS.categories);

      if (res.statusCode == 200) {
        categoryList.assignAll((res.data["data"] as List)
            .map((e) => SubCategoryModel.fromJson(e))
            .toList());

        kLogger.e(categoryList.length);
      }
    } catch (e) {
      kLogger.e('Error from %%%% get category %%%% => $e');
    }
  }

  SubCategoryModel? selectedCategory;
  updateSelectedCategory(SubCategoryModel? value) {
    selectedCategory = value;
    update();
  }

  bool hasVariation = false;
  void updateHasVariation(bool? value) {
    hasVariation = value ?? false;
    update();
  }

  @override
  void onInit() {
    getProductList();
    getCategoryList();
    super.onInit();
  }
}
