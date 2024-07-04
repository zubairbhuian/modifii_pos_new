import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../models/order_place_model.dart';
import 'add_to_cart_dialog_options.dart';

class ProductBody extends GetView<PosController> {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return _body(theme, context);
  }

  //** Body **
  Widget _body(ThemeData theme, BuildContext context) {
    return SingleChildScrollView(child: Obx(() {
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
                Cart order = Cart(
                  id: item.id.toString(),
                  name: item.name,
                  description: item.description,
                  type: "",
                  price: item.price ,
                  quantity: PosController.to.orderQuantity,
                  // isLiquor: int.parse(item.isLiquor.toString()),
                  isLiquor: 1,
                  togo: '',
                  dontMake: '',
                  rush: '',
                  heat: '',
                  serveFirst: '',
                  kitchenNote: '',
                );

                //** Add item **
                PosController.to.onAddCartItem(order);
                FocusScope.of(context).unfocus();
              }
            },
            isOutline: true,
            height: 78,
            text: item.name!.toUpperCase(),
          );
        }),
      );
    }));
  }
}
