import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/subCategory/controllers/sub_category_controller.dart';
import 'package:flutter_base/app/utils/app_data.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';

import '../models/category_type_model.dart';

class AddCategoryDialog extends GetView<SubCategoryController> {
  const AddCategoryDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        const MyCustomText(
          "Add Sub-category ",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 48),
        CustomTextField(
          controller: controller.titleController,
          hintText: 'Category Name',
          maxLines: 1,
        ),
        const SizedBox(height: 16),
        CustomDropdownTextField(
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
        // DropdownButtonFormField<String>(
        //   hint: Text(
        //     'Select',
        //     style: theme.textTheme.bodyLarge
        //         ?.copyWith(color: const Color(0xFFC0C0C0)),
        //   ),
        //   value: controller.selectedCategory,
        //   dropdownColor: theme.scaffoldBackgroundColor,
        //   focusColor: theme.scaffoldBackgroundColor,
        //   decoration: InputDecoration(
        //       border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(4),
        //           borderSide: BorderSide(color: theme.hintColor)),
        //       focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(4),
        //           borderSide: BorderSide(color: theme.hintColor)),
        //       enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(4),
        //           borderSide: BorderSide(color: theme.hintColor)),
        //       contentPadding:
        //           const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        //       // filled: true,
        //       // fillColor: theme.scaffoldBackgroundColor,
        //       focusColor: theme.scaffoldBackgroundColor,
        //       hintStyle: theme.textTheme.bodyLarge?.copyWith(
        //           color: theme.hintColor) // Set the background color here
        //       ),
        //   items: List.generate(
        //     AppData.categoryList.length,
        //     (index) {
        //       var data = AppData.categoryList[index];
        //       return DropdownMenuItem<String>(
        //         value: data.value,
        //         child: MyCustomText(
        //           data.title,
        //         ),
        //       );
        //     },
        //   ),
        //   onChanged: (value) {
        //     controller.selectedCategory = value;
        //   },
        // ),
        const SizedBox(height: 48),
        PrimaryBtn(
          onPressed: () {
            controller.createCategory();
          },
          text: 'Add',
          textColor: Colors.white,
        ),
      ],
    );
  }
}
