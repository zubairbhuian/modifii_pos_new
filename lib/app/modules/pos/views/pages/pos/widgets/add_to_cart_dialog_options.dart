import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/models/product_model.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';
import '../../../../models/order_place_model.dart';

class AddToCartDialogOptions extends StatelessWidget {
  final ProductModel item;

  const AddToCartDialogOptions({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    num price = item.price ?? 0;

    return GetBuilder<PosController>(builder: (c) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 14),
          //item name & price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCustomText(
                item.name,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              MyCustomText(
                '\$$price',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(height: 14),
          //description
          MyCustomText(
            'Description',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hintColor,
          ),
          const SizedBox(height: 4),
          MyCustomText(
            item.description == '' ? 'N/A' : item.description ?? '',
            fontSize: 14,
          ),
          const SizedBox(height: 24),
          //variations
          ...List.generate(c.productVariations.length, (index) {
            var variation = c.productVariations[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomText(variation.name),
                const SizedBox(height: 14),
                SizedBox(
                  // height: 100,
                  child: Row(
                    children: List.generate(
                      variation.options.length,
                      (index) => _popupPrimaryBtn(
                        onPressed: () {
                          c.setSelectedProductVariationValue(index);
                          // c.orderTotalPrice =
                          //     num.parse(variation.values[index].optionPrice);
                          price = c.orderTotalPrice =variation.options[index].price;
                          c.orderQuantity = 1;
                          c.update();
                        },
                        label: variation.options[index].name,
                        price: variation.options[index].price.toStringAsFixed(2),
                        isSelected: c.selectedProductVariationValue == index
                            ? true
                            : false,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          //quantity row
          Visibility(
            visible: c.selectedProductVariationValue != null,
            replacement: const SizedBox(height: 110),
            child: SizedBox(
              height: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: MyCustomText(
                      'Quantity',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryBtnWithChild(
                          onPressed: () {
                            c.updateOrderQuantity(false, price);
                          },
                          width: 48,
                          child: const Icon(
                            Icons.remove,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: Center(
                            child: MyCustomText(
                              c.orderQuantity.toString(),
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        PrimaryBtnWithChild(
                          onPressed: () {
                            c.updateOrderQuantity(true, price);
                          },
                          width: 48,
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MyCustomText(
                        '\$${c.orderTotalPrice.toStringAsFixed(2)}',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //order button
          Visibility(
            visible: c.selectedProductVariationValue != null,
            replacement: const SizedBox(height: 48),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryBtn(
                onPressed: () {
                  PosController.to.resetModifierSelections();
                  Cart order = Cart(
                    id: item.id.toString(),
                    name: item.name,
                    description: item.description,
                    // type: item.productType,
                    type: "",
                    price: price,
                    quantity: c.orderQuantity,
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
                  c.onAddCartItem(order);
                  Get.back();
                },
                text: 'ADD',
                textMaxSize: 22,
                textMinSize: 18,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _popupPrimaryBtn(
      {required VoidCallback onPressed,
      required String label,
      required String price,
      required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: PrimaryBtnWithChild(
        onPressed: onPressed,
        height: 70,
        width: 125,
        isOutline: true,
        color: isSelected
            ? StaticColors.blueColor
            : Theme.of(Get.context!).scaffoldBackgroundColor,
        borderColor:
            isSelected ? StaticColors.blueColor : StaticColors.greenColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyCustomText(
              label,
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            MyCustomText(
              '\$$price',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
