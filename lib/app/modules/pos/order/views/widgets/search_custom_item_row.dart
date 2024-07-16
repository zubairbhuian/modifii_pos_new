import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/order/views/widgets/custom_order_dialog_options.dart';
import 'package:flutter_base/app/modules/pos/order/views/widgets/discount_dialog_options.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_btn.dart';
import '../../../../../widgets/custom_textfield.dart';

class SearchAndCustomItemRow extends GetView<PosController> {
  const SearchAndCustomItemRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PrimaryBtn(
          onPressed: () {
            PopupDialog.customDialog(
              child: const CustomOrderDialogOptions(productType: "Custom Food"),
            );
          },
          color: StaticColors.blueColor,
          text: 'Custom Food',
          textColor: Colors.white,
        )),
        const SizedBox(width: 12.0),
        Expanded(
            child: PrimaryBtn(
          onPressed: () {
            PopupDialog.customDialog(
              child:
                  const CustomOrderDialogOptions(productType: "Custom Drink"),
            );
          },
          color: StaticColors.blueColor,
          text: 'Custom Drink',
          textColor: Colors.white,
        )),
        const SizedBox(width: 36.0),
        Expanded(
          flex: 2,
          child: CustomTextField(
            controller: controller.searchController,
            hintText: 'Search item',
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
            onChange: (value) {
              // controller.findProductsByName(value);
            },
          ),
        ),
        const SizedBox(width: 36.0),
        Expanded(
            child: PrimaryBtn(
          onPressed: () {
            PopupDialog.customDialog(
              child: const CustomOrderDialogOptions(productType: "Custom Bar"),
            );
          },
          color: StaticColors.blueColor,
          text: 'Custom Bar',
          textColor: Colors.white,
        )),
        const SizedBox(width: 12.0),
        Expanded(
            child: PrimaryBtn(
          onPressed: () {
            PopupDialog.customDialog(
              child: const DiscountDialogOptions(),
            );
          },
          color: StaticColors.blueColor,
          text: 'Discount',
          textColor: Colors.white,
        )),
      ],
    );
  }
}
