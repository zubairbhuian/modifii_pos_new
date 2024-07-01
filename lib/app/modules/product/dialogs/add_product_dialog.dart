import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/utils/app_data.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_dropdown.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';
import '../../subCategory/models/category_type_model.dart';
import '../../subCategory/models/sub_category_model.dart';
import '../controllers/product_controller.dart';

class AddProductDialog extends StatelessWidget {
  const AddProductDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetBuilder<ProductController>(builder: (c) {
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
                flex: 6,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: MyDropdownBtn(
                        hintText: 'Product Type',
                        data: AppData.categoryList.map((e) {
                          return DropdownMenuItem<CategoryTypeModel>(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: MyCustomText(e.title),
                            ),
                          );
                        }).toList(),
                        selectedValue: c.selectedproductType,
                        onChanged: (value) {
                          c.updateSelectedProductType(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (c.isShowAlcohol)
                      Expanded(
                        flex: 1,
                        child: CheckboxListTile(
                          title: const MyCustomText("Alcohol"),
                          value: c.isProductAlcohol,
                          onChanged: c.updateIsProductAlcohol,
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          activeColor: theme.primaryColor,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 26),
              Expanded(
                flex: 5,
                child: MyDropdownBtn(
                  hintText: 'Product Category',
                  data: c.filteredCategoryList.map((e) {
                    return DropdownMenuItem<SubCategoryModel>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MyCustomText(e.title),
                      ),
                    );
                  }).toList(),
                  selectedValue: c.selectedCategory,
                  onChanged: (value) {
                    c.updateSelectedCategory(value);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),
          CheckboxListTile(
            title: const MyCustomText("Has Variations"),
            value: c.hasVariation,
            onChanged: c.updateHasVariation,
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            activeColor: theme.primaryColor,
          ),

          const SizedBox(height: 42),

          //variations
          if (c.hasVariation)
            Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                extraLabel: "Variation Name",
                                // controller: controller.titleController,
                                hintText: 'Name',
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(width: 12),
                            MyCustomText('Selection Type'),
                          ],
                        )),
                    const SizedBox(width: 26),
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                extraLabel: "Min",
                                // controller: controller.titleController,
                                hintText: '0.0',
                                maxLines: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextField(
                                extraLabel: "Max",
                                // controller: controller.titleController,
                                hintText: '0.0',
                                maxLines: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    const Expanded(
                        child: CustomTextField(
                      extraLabel: "Option name",
                      // controller: controller.titleController,
                      hintText: '',
                      maxLines: 1,
                    )),
                    const SizedBox(width: 26),
                    Expanded(
                        child: CustomTextField(
                      extraLabel: "Additional Price",
                      // controller: controller.titleController,
                      hintText: '0.0',
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                    )),
                  ],
                ),
              ],
            ),

          const SizedBox(height: 56),
          PrimaryBtn(
            onPressed: () {
              Get.back();
              // controller.createCategory();
            },
            width: 240,
            text: 'Add',
            textColor: Colors.white,
          ),
        ],
      );
    });
  }
}
