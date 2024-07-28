import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../models/order_place_model.dart';
import 'add_to_cart_dialog_options.dart';

class ProductBody extends GetView<PosController> {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
        child: GetBuilder<PosController>(builder: (controller) {
      return StaggeredGrid.count(
        crossAxisCount: context.isPortrait ? 2 : 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: List.generate(controller.productList.length, (index) {
          var item = controller.productList[index];
          return PrimaryBtn(
            onPressed: () {
              controller.orderTotalPrice = item.price.toDouble();
              controller.resetModifierSelections();
              controller.checkHasVariations(item.variations);
              if (controller.hasVariations) {
                PopupDialog.customDialog(
                    child: AddToCartDialogOptions(item: item));
              } else {
                CartModel order = CartModel(
                  name: item.name,
                  description: item.description,
                  price: item.price,
                  quantity: PosController.to.orderQuantity,
                  // isLiquor: int.parse(item.isLiquor.toString()),
                  isLiquor: false,
                  toGo: '',
                  dontMake: '',
                  rush: '',
                  heat: '',
                  serveFirst: '',
                  kitchenNote: '',
                  discountAmount: 0,
                );
                //** Add item **
                PosController.to.onAddCartItem(order);
                FocusScope.of(context).unfocus();
              }
            },
            isOutline: true,
            height: 78,
            text: controller.productList[index].name.toUpperCase(),
            color: theme.scaffoldBackgroundColor,
          );
        }),
      );
    }));
  }
}
