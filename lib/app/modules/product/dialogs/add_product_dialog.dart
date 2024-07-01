import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/product/controllers/product_controller.dart';
import 'package:flutter_base/app/modules/subCategory/controllers/sub_category_controller.dart';
import 'package:flutter_base/app/utils/app_data.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';

class AddProductDialog extends GetView<ProductController> {
  const AddProductDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Text(
          'Add Product',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 48),
        // row 1
        Row(
          children: [
            const Expanded(
                child: CustomTextField(
              extraLabel: "Product Name",
              // controller: controller.titleController,
              hintText: 'Name',
              maxLines: 1,
            )),
            const SizedBox(width: 26),
            Expanded(
                child: CustomTextField(
              extraLabel: "Product Price",
              // controller: controller.titleController,
              hintText: 'Price',
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
            )),
          ],
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          extraLabel: "Product description",
          // controller: controller.titleController,
          hintText: 'Description',
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropdownTextField(
                        label: "Product Type",
                        value: controller.selectedCategory,
                        onChanged: (value) {
                          controller.selectedCategory = value;
                        },
                        items: List.generate(
                          AppData.categoryList.length,
                          (index) {
                            var data = AppData.categoryList[index];
                            return DropdownMenuItem<String>(
                              value: data.value,
                              child: MyCustomText(
                                data.title,
                              ),
                            );
                          },
                        )),
                  ),
                  Checkbox(value: true, onChanged: (value) {})
                ],
              ),
            ),
            const SizedBox(width: 26),
            Expanded(
              child: CustomDropdownTextField(
                  label: "Product Category",
                  value: controller.selectedCategory,
                  onChanged: (value) {
                    controller.selectedCategory = value;
                  },
                  items: List.generate(
                    AppData.categoryList.length,
                    (index) {
                      var data = AppData.categoryList[index];
                      return DropdownMenuItem<String>(
                        value: data.value,
                        child: MyCustomText(
                          data.title,
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),

        const SizedBox(height: 48),
        PrimaryBtn(
          onPressed: () {
            // controller.createCategory();
          },
          text: 'Add',
          textColor: Colors.white,
        ),
      ],
    );
  }
}
