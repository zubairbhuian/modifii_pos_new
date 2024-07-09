import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/widgets/cart_item.dart';
import 'package:flutter_base/app/modules/pos/views/pages/pos/widgets/category_body.dart';
import 'package:flutter_base/app/modules/pos/views/pages/pos/widgets/product_body.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/app_indecator.dart';
import 'package:flutter_base/app/widgets/custom_alert_dialog.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_dropdown.dart';
import '../../../../../widgets/custom_loading.dart';
import '../../../../../widgets/custom_textfield.dart';
import '../../../../../widgets/my_custom_text.dart';
import '../../../models/table_model.dart';
import 'widgets/search_custom_item_row.dart';

class PosPage extends GetView<PosController> {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              //search row
              const SearchAndCustomItemRow(),
              const SizedBox(height: 12),
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
                            child: Obx(
                              () => controller.isLoadingProduct.value
                                  ? const AppIndecator()
                                  : const ProductBody(),
                            ),
                          ),
                          const SizedBox(width: 18),
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

  GetBuilder<PosController> _modifiersRow(BuildContext context) {
    return GetBuilder<PosController>(builder: (c) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              c.orderServeTypes.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: _popupPrimaryBtn(
                  onPressed: () {
                    c.setSelectedOrderTypesIndex2(index);
                  },
                  text: c.orderServeTypes[index],
                  isSelected: c.selectedOrderServeTypesIndex == index,
                ),
              ),
            ),
            const SizedBox(height: 18),
            _popupPrimaryBtn(
              onPressed: () {
                c.toggleOrderTypeSelection(isTogo: true);
              },
              text: 'TO GO',
              isSelected: c.isTogoSelected,
            ),
            const SizedBox(height: 8),
            _popupPrimaryBtn(
              onPressed: () {
                c.toggleOrderTypeSelection(isDontMake: true);
              },
              text: "DON'T MAKE",
              isSelected: c.isDontMakeSelected,
            ),
            const SizedBox(height: 8),
            _popupPrimaryBtn(
              onPressed: () {
                c.toggleOrderTypeSelection(isRush: true);
              },
              text: 'RUSH',
              isSelected: c.isRushSelected,
            ),
            Column(children: [
              const SizedBox(height: 18),
              ...List.generate(
                c.orderHeatModifiers.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _popupPrimaryBtn(
                    onPressed: () {
                      c.setSelectedOrderModifiersIndex(index);
                    },
                    text: c.orderHeatModifiers[index],
                    isSelected: c.selectedOrderHeatModifiersIndex == index,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 18),
            _popupPrimaryBtn(
                onPressed: () {
                  _kitchenNoteDialog(context);
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

  void _kitchenNoteDialog(BuildContext context) {
    return customAlertDialog(
      context: context,
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyCustomText('Add Kitchen Note'),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(FontAwesomeIcons.xmark, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CustomTextField(
              controller: controller.kitchenNoteTEC,
              hintText: 'Kitchen Note',
              maxLines: 5,
            ),
            const SizedBox(height: 14),
            PrimaryBtn(
              onPressed: () {
                controller.addKitchenNote();
                Get.back();
              },
              text: 'Submit',
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  //** cart **
  Widget _cartArea(ThemeData theme) {
    return Container(
      width: 375,
      decoration: BoxDecoration(
        color: theme.cardColor,
        // border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: GetBuilder<TablesController>(builder: (c) {
                    return MyDropdownBtn(
                      hintText: 'Select Table',
                      data: c.tablesList.map((e) {
                        return DropdownMenuItem<TableModel>(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                width: 116,
                                height: 200,
                                color: c.getColor(e.status ?? 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: MyCustomText(
                                      'Table ${e.number}',
                                      color: Colors.white,
                                    ))),
                          ),
                        );
                      }).toList(),
                      selectedValue: c.selectedTable,
                      onChanged: (value) {
                        TableModel table = value;
                        c.updateSelectedTable(table);
                      },
                      menuItemPadding: EdgeInsets.zero,
                      dropdownStyleWidth: 220,
                    );
                  }),
                ),

                // Expanded(
                //   child: GetBuilder<TablesController>(builder: (c) {
                //     return MyDropdownBtn(
                //       hintText: 'Select Bar',
                //       data: c.barsList.map((e) {
                //         return DropdownMenuItem<TableModel>(
                //           value: e,
                //           child: Padding(
                //             padding: const EdgeInsets.all(2.0),
                //             child: Container(
                //                 width: 116,
                //                 height: 200,
                //                 color: c.getColor(e.status ?? 0),
                //                 child: Align(
                //                     alignment: Alignment.center,
                //                     child: MyCustomText(
                //                       'Table ${e.number}',
                //                       color: Colors.white,
                //                     ))),
                //           ),
                //         );
                //       }).toList(),
                //       selectedValue: c.selectedBar,
                //       onChanged: (value) {
                //         TableModel bar = value;
                //         c.updateSelectedBar(bar);
                //       },
                //       menuItemPadding: EdgeInsets.zero,
                //       dropdownStyleWidth: 220,
                //     );
                //   }),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GetBuilder<TablesController>(builder: (c) {
              return MyDropdownBtn(
                hintText: 'Number of Guests',
                data: c.guestNumbers
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: MyCustomText(e),
                        ))
                    .toList(),
                selectedValue: c.selectedGuestNumbers,
                onChanged: (value) {
                  c.updatedSelectedGuestNumbers(value);
                },
              );
            }),
          ),

          Expanded(
            child: GetBuilder<PosController>(
              builder: (c) => ListView.builder(
                  controller: c.cartListScrollController,
                  shrinkWrap: true,
                  itemCount: c.cartList.length,
                  itemBuilder: (context, index) {
                    var data = c.cartList[index];
                    return CartItem(
                      title: data.name ?? "",
                      amount: data.price * data.quantity,
                      quantity: data.quantity,
                      serveFirst: data.serveFirst ?? '',
                      togo: data.togo ?? '',
                      dontMake: data.dontMake ?? '',
                      rush: data.rush ?? '',
                      heat: data.heat ?? '',
                      note: data.kitchenNote ?? '',
                      onDecrement: () {
                        c.quantityUpdateWithCartListIndex(index,
                            isIncriment: false);
                      },
                      onIncrement: () {
                        c.quantityUpdateWithCartListIndex(index,
                            isIncriment: true);
                      },
                      onRemove: () {
                        c.onRemoveCartItemWithIndex(index);
                      },
                    );
                  }),
            ),
          ),
          // amount
          const Divider(),
          Obx(
            () => Visibility(
              visible: controller.cartSubTotalPrice.value > 0,
              child: _row(
                theme,
                title: "Subtotal : ",
                value: "\$${controller.cartSubTotalPrice.toStringAsFixed(2)}",
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.cartGSTAmount.value > 0,
              child: _row(
                theme,
                title: "GST 5% : ",
                value: "\$${controller.cartGSTAmount.toStringAsFixed(2)}",
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.cartGratuityAmount.value > 0,
              child: _row(
                theme,
                title: "Gratuity 18% : ",
                value: "\$${controller.cartGratuityAmount.toStringAsFixed(2)}",
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.cartPSTAmount.value > 0,
              child: _row(
                theme,
                title: "PST 10% : ",
                value: "\$${controller.cartPSTAmount.toStringAsFixed(2)}",
              ),
            ),
          ),
          const Divider(),
          Obx(
            () => _row(
              theme,
              title: "Total : ",
              value: "\$${controller.cartTotalAmount.toStringAsFixed(2)}",
            ),
          ),
          // order btn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryBtn(
                    onPressed: controller.postPlaceOrder,
                    height: 48,
                    color: StaticColors.greenColor,
                    textColor: Colors.white,
                    text: 'Place Order',
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
      ),
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
