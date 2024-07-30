import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_body.dart';
import 'package:flutter_base/app/modules/pos/order/views/widgets/search_custom_item_row.dart';
import 'package:flutter_base/app/modules/pos/order/views/widgets/cart_item.dart';
import 'package:flutter_base/app/modules/pos/order/views/widgets/category_body.dart';
import 'package:flutter_base/app/modules/pos/order/views/widgets/product_body.dart';
import 'package:flutter_base/app/utils/my_func.dart';
import 'package:flutter_base/app/utils/my_reg_exp.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/app_indecator.dart';
import 'package:flutter_base/app/widgets/custom_alert_dialog.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../views/widgets/top_menu.dart';

class OrderView extends GetView<PosController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // top menu bar
              const TopMenu(),
              const SizedBox(height: 16),
              //search row
              const SearchAndCustomItemRow(),
              const SizedBox(height: 12),
              // sub category and product
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // item 1 (Category)
                    const Flexible(flex: 2, child: CategoryBody()),
                    const SizedBox(width: 16),
                    // item 2 (Product)
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: GetBuilder<PosController>(
                                builder: (controller) {
                              if (controller.isLoadingProduct) {
                                return const AppIndecator();
                              } else {
                                return const ProductBody();
                              }
                            }),
                          ),
                          const SizedBox(width: 18),
                          // modifier
                          Expanded(
                            flex: 1,
                            child: _modifiersRow(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // item 3 (Cart)
        _cartArea(theme),
        // cart area
      ],
    );
  }

  Widget _modifiersRow(BuildContext context) {
    return GetBuilder<PosController>(builder: (c) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              c.serveFirstList.length,
              (index) {
                var data = c.serveFirstList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _popupPrimaryBtn(
                    onPressed: () {
                      c.onServeFirst(data);
                    },
                    text: data,
                    isSelected: c.selectedserveFirstList.contains(data),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            ...List.generate(
              c.othermodifierList.length,
              (index) {
                var data = c.othermodifierList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _popupPrimaryBtn(
                    onPressed: () {
                      c.onOthermodifier(data);
                    },
                    text: data,
                    isSelected: c.selectedOthermodifierList.contains(data),
                  ),
                );
              },
            ),
            // _popupPrimaryBtn(
            //   onPressed: () {
            //     c.toggleOrderTypeSelection(isTogo: true);
            //     c.update();
            //   },
            //   text: 'TO GO',
            //   isSelected: c.isTogoSelected,
            // ),
            // const SizedBox(height: 8),
            // _popupPrimaryBtn(
            //   onPressed: () {
            //     c.toggleOrderTypeSelection(isDontMake: true);
            //     c.update();
            //   },
            //   text: "DON'T MAKE",
            //   isSelected: c.isDontMakeSelected,
            // ),
            // const SizedBox(height: 8),
            // _popupPrimaryBtn(
            //   onPressed: () {
            //     c.toggleOrderTypeSelection(isRush: true);
            //     c.update();
            //   },
            //   text: 'RUSH',
            //   isSelected: c.isRushSelected,
            // ),
            Column(children: [
              const SizedBox(height: 18),
              ...List.generate(
                c.heatList.length,
                (index) {
                  var data = c.heatList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _popupPrimaryBtn(
                      onPressed: () {
                        c.onHeat(data);
                      },
                      text: data,
                      isSelected: c.selectedHeatList.contains(data),
                    ),
                  );
                },
              ),
            ]),
            const SizedBox(height: 18),
            _popupPrimaryBtn(
                onPressed: () {
                  PopupDialog.customDialog(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyCustomText(
                            'Add Kitchen Note',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                          controller: controller.kitchenNoteTEC,
                          hintText: 'Kitchen Note',
                          maxLines: 10,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16)),
                      const SizedBox(height: 20),
                      PrimaryBtn(
                        width: 200,
                        height: 70,
                        onPressed: () {
                          controller.addKitchenNote();
                          Get.back();
                        },
                        text: 'Submit',
                        textColor: Colors.white,
                      )
                    ],
                  ));
                  c.update();
                },
                text: 'KITCHEN NOTE',
                isSelected: c.cartList.isNotEmpty
                    ? c.cartList.last.kitchenNote == ""
                        ? false
                        : true
                    : false),
          ],
        ),
      );
    });
  }

  //** cart **
  Widget _cartArea(ThemeData theme) {
    return Container(
      width: 375,
      decoration: BoxDecoration(
        color: theme.cardColor,
        // border: Border.all(color: Colors.white),
      ),
      child: GetBuilder<PosController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    focusNode: controller.tableFocusNode,
                    controller: controller.tableController,
                    hintText: "Select Table",
                    readOnly: true,
                    onTap: () {
                      DineInController.to.getTableCategories();
                      PopupDialog.customDialog(
                          width: Get.width * 0.8,
                          child: const TableBody(
                            isScrollable: false,
                          ));
                    },
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.guestController,
                      focusNode: controller.guestFocusNode,
                      hintText: "Guest Number",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(MyRegExp.guestNumber)),
                        // NumberRangeInputFormatter(1, 25),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 12),
                  // PrimaryBtnWithChild(
                  //     onPressed: () {},
                  //     borderRadius: 4,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 18, vertical: 20),
                  //     child: const Icon(Icons.copy_all_rounded)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: controller.cartListScrollController,
                  shrinkWrap: true,
                  itemCount: controller.myOrder.carts.length,
                  itemBuilder: (context, index) {
                    var data = controller.myOrder.carts[index];
                    return CartItem(
                      title: data.name,
                      amount: data.price * data.quantity,
                      quantity: data.quantity,
                      serveFirst: data.serveFirst,
                      togo: data.toGo,
                      dontMake: data.dontMake,
                      rush: data.rush,
                      heat: data.heat,
                      note: data.kitchenNote,
                      onDecrement: () {
                        controller.quantityUpdateWithCartListIndex(index,
                            isIncriment: false);
                      },
                      onIncrement: () {
                        controller.quantityUpdateWithCartListIndex(index,
                            isIncriment: true);
                      },
                      onRemove: () {
                        controller.onRemoveCartItemWithIndex(index);
                      },
                    );
                  }),
            ),
            // amount
            const Divider(),
            _row(
              theme,
              title: "Subtotal : ",
              value: "\$${controller.myOrder.subTotal.toStringAsFixed(2)}",
            ),
            _row(
              theme,
              title: "GST 5% : ",
              value: "\$${controller.myOrder.totalGst.toStringAsFixed(2)}",
            ),
            Visibility(
              visible: controller.myOrder.totalGratuity > 0,
              child: _row(
                theme,
                title: "Gratuity 18% : ",
                value:
                    "\$${controller.myOrder.totalGratuity.toStringAsFixed(2)}",
              ),
            ),
            Visibility(
              visible: controller.myOrder.totalPst > 0,
              child: _row(
                theme,
                title: "PST 10% : ",
                value: "\$${controller.myOrder.totalPst.toStringAsFixed(2)}",
              ),
            ),
            const Divider(),
            _row(
              theme,
              title: "Total : ",
              value: controller.myOrder.totalOrderAmount.toStringAsFixed(2),
            ),
            // order btn
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () async {
                        if (controller.isUpdateView) {
                          PopupDialog.showLoadingDialog();
                          await controller.onUpdateOrder(controller.myOrder.id);
                          PopupDialog.closeLoadingDialog();
                        } else {
                          PopupDialog.showLoadingDialog();
                          await controller.onPlaseOrder();
                          PopupDialog.closeLoadingDialog();
                        }
                      },
                      height: 48,
                      color: StaticColors.greenColor,
                      textColor: Colors.white,
                      text: controller.isUpdateView
                          ? "Update Order"
                          : 'Place Order',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: controller.clearCartList,
                      height: 48,
                      color: theme.colorScheme.error,
                      textColor: Colors.white,
                      text: 'Cancel',
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  // row
  Widget _row(ThemeData theme,
      {double? fontSize, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
                fontSize: fontSize ?? 16, fontWeight: FontWeight.w700),
          )),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
                fontSize: fontSize ?? 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  PrimaryBtn _popupPrimaryBtn(
      {required VoidCallback onPressed,
      required String text,
      required bool isSelected}) {
    return PrimaryBtn(
      onPressed: onPressed,
      width: double.infinity,
      text: text,
      isOutline: true,
      color: isSelected
          ? StaticColors.blueColor
          : Theme.of(Get.context!).scaffoldBackgroundColor,
      borderColor:
          isSelected ? StaticColors.blueColor : StaticColors.greenColor,
    );
  }
}
