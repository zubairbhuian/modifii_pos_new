import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/order/models/main_category_model.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';

class CategoryBody extends GetView<PosController> {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Obx(() {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(controller.categoryList.length, (index) {
            var data = controller.categoryList[index];
            return _categoryBtn(
                theme, data.subCategory, data.background, data.foreground);
          }),
        );
      }),
    );
  }


  Widget _categoryBtn(ThemeData theme, List<SubCategory> data, Color bgColor,
          Color color) =>
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) => PrimaryBtn(
            onPressed: () {
              controller.findProductsByCategoryId(data[index].id);
            },
            color: bgColor,
            style: theme.textTheme.titleLarge?.copyWith(color: color),
            text: data[index].title,
          ).marginOnly(bottom: 12, right: 12),
        ).marginOnly(bottom: 20),
      );
}
