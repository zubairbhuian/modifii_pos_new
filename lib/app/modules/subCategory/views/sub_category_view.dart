import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/subCategory/dialogs/add_category_dialog.dart';
import 'package:flutter_base/app/modules/subCategory/widgets/category_tile.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';

import 'package:get/get.dart';

import '../controllers/sub_category_controller.dart';

class SubCategoryView extends GetView<SubCategoryController> {
  const SubCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          isPrimary: false,
          title: Text("Add Category"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () {
                        PopupDialog.customDialog(
                          child: const AddCategoryDialog(),
                        );
                      },
                      text: "Add Sub-category",
                      textColor: Colors.white,
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                  const Expanded(
                    child: CustomTextField(
                      // controller: controller.searchTEController,
                      hintText: 'search ',
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: MyCustomText('Available Category')),
              const Divider(
                color: Colors.white,
                height: 20,
              ),
              Expanded(
                child: Obx(() {
                  return SingleChildScrollView(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.categoryList.length,
                      itemBuilder: (_, index) {
                        return Obx(() {
                          var data = controller.categoryList[index];
                          return CategoryTile(
                            sl: data.title,
                            title: data.type,
                            isActive: true,
                            onStatusChanged: (value) {},
                            onEdit: () {},
                            onDelete: () {},
                          );
                        });
                      },
                      separatorBuilder: (_, __) {
                        return const Divider(height: 24);
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
 
  }
}
