import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/subCategory/models/sub_category_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

import '../models/category_type_model.dart';

class SubCategoryController extends GetxController {
  static SubCategoryController  get to => Get.find();
  TextEditingController titleController = TextEditingController();

// get sub category
  var categoryList = <SubCategoryModel>[].obs;
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

  // create sub category
  String? selectedCategory;
  createCategory() async {
    Map<String, dynamic> data = {
      "title": titleController.text,
      "type": selectedCategory // VEG, NON_VEG, DRINKS
    };
    if (selectedCategory == null) {
      PopupDialog.showErrorMessage("Category type is required");
    } else if (titleController.text.isEmpty) {
      PopupDialog.showErrorMessage("Tile is required");
    } else {
      try {
        var res = await BaseController.to.apiService.dio
            .post(URLS.categories, data: data);
        kLogger.e(res);
        if (res.statusCode == 201) {
          getCategoryList();
          Get.back();
          selectedCategory = null;
          titleController.clear();
        } else if (res.statusCode == 409) {
          PopupDialog.showErrorMessage("Tile is already exists");
        }
      } catch (e) {
        kLogger.e('Error from %%%% make category %%%% => $e');
      }
    }
  }

  @override
  void onReady() {
    getCategoryList();
    super.onReady();
  }
}
