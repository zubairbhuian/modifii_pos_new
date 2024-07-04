import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/models/category_model.dart';
import 'package:flutter_base/app/modules/subCategory/models/sub_category_model.dart';
import 'package:flutter_base/app/utils/my_func.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CategoryBody extends GetView<PosController> {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return _body(theme, context);
  }

  //** Body **
  Widget _body(ThemeData theme, BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        List<SubCategoryModel> veg = controller.categoryList
            .where((value) => value.type == 'VEG')
            .toList();
        List<SubCategoryModel> nonVeg = controller.categoryList
            .where((value) => value.type == 'NON_VEG')
            .toList();
        List<SubCategoryModel> drinks = controller.categoryList
            .where((value) => value.type == 'DRINKS')
            .toList();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _categoryBtn(theme, veg),
            const SizedBox(width: 12),
            _categoryBtn(theme, nonVeg),
            const SizedBox(width: 12),
            _categoryBtn(theme, drinks),
          ],
        );
      }),
    );
  }

  Widget _categoryBtn(ThemeData theme, List<SubCategoryModel> data) => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) => PrimaryBtn(
            onPressed: () {
              controller.findProductsByCategoryId(data[index].id);
            },
            color: MyFunc.productColor(data[index].type),
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            text: data[index].title,
          ).marginOnly(bottom: 12),
        ).marginOnly(bottom: 20),
      );
}
