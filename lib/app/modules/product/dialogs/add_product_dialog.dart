import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/utils/app_data.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
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
          const MyCustomText(
            'Add Product',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 36),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                extraLabel: "Product Name",
                controller: c.nameTEC,
                hintText: 'Name',
                maxLines: 1,
              )),
              const SizedBox(width: 26),
              Expanded(
                  child: CustomTextField(
                extraLabel: "Product Price",
                controller: c.priceTEC,
                hintText: 'Price',
                maxLines: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
              )),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            extraLabel: "Product description",
            controller: c.descriptionTEC,
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

          //variations
          if (c.hasVariation)
            ...c.variationsList.asMap().entries.map((entry) {
              int index = entry.key;
              Variations variation = entry.value;
              return Column(
                key: ValueKey(variation),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),
                  _variations(
                    context: context,
                    variation: variation,
                    variationIndex: index,
                    name: variation.nameTEC,
                    minPrice: variation.minPriceTEC,
                    maxPrice: variation.maxPriceTEC,
                  ),
                  const SizedBox(height: 8),
                  PrimaryBtn(
                    onPressed: () => c.removeVariations(index),
                    text: 'Remove Variation',
                    isOutline: true,
                    textColor: Colors.red,
                    borderColor: Colors.red,
                  ),
                ],
              );
            }),
          const SizedBox(height: 48),
          if (c.hasVariation)
            Align(
              alignment: Alignment.centerLeft,
              child: PrimaryBtn(
                onPressed: () => c.addVariations(),
                text: 'Add Variation',
                isOutline: true,
                textColor: StaticColors.blueLightColor,
                borderColor: StaticColors.blueLightColor,
              ),
            ),

          const SizedBox(height: 56),
          PrimaryBtn(
            onPressed: () {
              c.addProduct();
              // Get.back();
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

  Widget _variations({
    required BuildContext context,
    required Variations variation,
    required int variationIndex,
    required TextEditingController name,
    required TextEditingController minPrice,
    required TextEditingController maxPrice,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration:
          BoxDecoration(border: Border.all(color: StaticColors.blueLightColor)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  extraLabel: "Variation Name",
                  controller: name,
                  hintText: 'Name',
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: CustomTextField(
                  extraLabel: "Min",
                  controller: minPrice,
                  hintText: '0.0',
                  maxLines: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  extraLabel: "Max",
                  controller: maxPrice,
                  hintText: '0.0',
                  maxLines: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  const MyCustomText(
                    'Selection Type',
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const MyCustomText('Single'),
                            value: 'SINGLE',
                            groupValue: variation.selectionType,
                            onChanged: variation.updateSelectionType,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const MyCustomText('Multiple'),
                            value: 'MULTIPLE',
                            groupValue: variation.selectionType,
                            onChanged: variation.updateSelectionType,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Expanded(
                child: CheckboxListTile(
                  title: const MyCustomText(
                    "Required",
                    fontWeight: FontWeight.w600,
                  ),
                  value: variation.isRequired,
                  onChanged: variation.updateIsRequired,
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          ...variation.options.asMap().entries.map((entry) {
            int optionIndex = entry.key;
            VariationOptions option = entry.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              key: ValueKey(option),
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: _variationOptions(
                      name: option.nameTEC,
                      price: option.priceTEC,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                PrimaryBtn(
                  onPressed: () => ProductController.to.removeVariationOption(
                    variationIndex,
                    optionIndex,
                  ),
                  text: 'Remove',
                  isOutline: true,
                  textColor: Colors.red,
                  borderColor: Colors.red,
                ).paddingOnly(bottom: 12),
              ],
            );
          }),
          const SizedBox(height: 36),
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryBtn(
              onPressed: () =>
                  ProductController.to.addVariationOption(variationIndex),
              text: 'Add Option',
              isOutline: true,
            ),
          ),
        ],
      ),
    );
  }

  Row _variationOptions({
    required TextEditingController name,
    required TextEditingController price,
  }) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          extraLabel: "Option name",
          controller: name,
          hintText: '',
          maxLines: 1,
        )),
        const SizedBox(width: 26),
        Expanded(
            child: CustomTextField(
          extraLabel: "Additional Price",
          controller: price,
          hintText: '0.0',
          maxLines: 1,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ],
        )),
      ],
    );
  }
}
