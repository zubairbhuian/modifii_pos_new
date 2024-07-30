import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/views/split_order_view.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/dialogs/discount_dialog.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_dialog.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

import '../widgets/custom_table_item.dart';

class OrderDetailsView extends GetView<DineInController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const double btnSize = 115;
    const double height = 80;
    const double textMaxSize = 30;
    const double textMinSize = 11;
    return Scaffold(
      appBar: const CustomAppBar(
        isPrimary: false,
      ),
      body: GetBuilder<PosController>(builder: (controller) {
        var data = controller.myOrder;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // left area
                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           const Icon(Icons.calendar_month).marginOnly(right: 8),
                  //           Text(
                  //             '22 Jun 2024',
                  //             style: theme.textTheme.titleSmall,
                  //           ),
                  //         ],
                  //       ),
                  //       Text(
                  //         'Authorization Code : N/A',
                  //         style: theme.textTheme.titleSmall,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // btn area
                  Row(
                    children: [
                      PrimaryBtn(
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        onPressed: () {
                          Get.back();
                          PosController.to.isUpdateView = true;
                          PosController.to.guestController.text =
                              data.numberOfPeople.toString();
                          PosController.to.tableController.text =
                              data.table?.tableName ?? "";
                          PosController.to.onchangePage(0);
                        },
                        // Add Items,Change Table,Guests
                        text: 'Add Items'.toUpperCase(),
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        color: theme.primaryColor,
                      ),
                      PrimaryBtn(
                        onPressed: () {},
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        text: 'Repeat Items'.toUpperCase(),
                        textColor: Colors.white,
                        color: StaticColors.greenColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                      ).marginOnly(left: 12),
                      PrimaryBtn(
                        onPressed: () {},
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        text: 'Transfer Items'.toUpperCase(),
                        textColor: Colors.white,
                        color: StaticColors.pinkColor,
                      ).marginOnly(left: 12),
                    ],
                  ),
                  // const Spacer(),
                  Row(
                    children: [
                      PrimaryBtn(
                        onPressed: () {
                          Get.to(() => const SplitOrderView());
                        },
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        text: 'Split Check'.toUpperCase(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        textColor: Colors.white,
                        color: theme.primaryColor,
                      ).marginOnly(left: 12),
                      PrimaryBtn(
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        onPressed: () {
                          PopupDialog.customDialog(
                              child: const DiscountDialog());
                        },
                        // width: double.infinity,
                        text: 'Discount'.toUpperCase(),
                        textColor: Colors.white,
                        color: StaticColors.blueColor,
                      ).marginOnly(left: 12),
                    ],
                  ),

                  Row(
                    children: [
                      PrimaryBtn(
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        onPressed: () {},
                        // width: double.infinity,
                        text: 'Print Check'.toUpperCase(),

                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        color: StaticColors.blueLightColor,
                      ).marginOnly(left: 12, right: 12),
                      PrimaryBtn(
                        width: btnSize,
                        height: height,
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                        onPressed: () {},
                        // width: double.infinity,
                        text: 'Print Items'.toUpperCase(),
                        maxLines: 3,
                        textColor: Colors.white,
                        color: StaticColors.blueColor,
                      ).marginOnly(right: 16),

                      // PrimaryBtn(
                      //   width: btnSize,
                      //   height: btnSize,
                      //   textMaxSize: textMaxSize,
                      //   textMinSize: textMinSize,
                      //   onPressed: () {
                      //     OrdersController.to.printReceipt();
                      //   },
                      //   // width: double.infinity,
                      //   text: 'Print Items for Kicken / Bar'.toUpperCase(),
                      //   textColor: Colors.white,
                      //   maxLines: 4,
                      //   color: StaticColors.greenColor,
                      // ).marginOnly(left: 12),
                    ],
                  )
                ],
              ).marginOnly(left: 25),

              // title area
              _titleRow(theme, data).marginOnly(left: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // for order details
                      Expanded(child: _itemDetails(theme, data)),
                      // order setup
                      SizedBox(width: 400, child: _orderSetup(theme)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      }),
    );
  }

  // title row widgets
  Widget _titleRow(ThemeData theme, OrderModel? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            'Order: #${data?.orderId}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Items: ${data?.carts.length}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Table: ${data?.table?.tableName}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Guests: ${data?.numberOfPeople}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Server:${data?.employee?.firstName}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Order Type: ${data?.orderType}'.replaceAll("_", " "),
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
        ],
      ),
    );
  }

  // order setup
  Widget _orderSetup(ThemeData theme) {
    return Column(
      children: [
        // cal 1
        Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order setup',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Change Order Status',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              // CustomDropdownTextField(data: const [], onChanged: (value) {}),
              // const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.hintColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Payment Status',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Unpaid',
                          style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.disabledColor),
                        ),
                        Switch(
                          value: false,
                          onChanged: (value) {},
                          splashRadius: 12,
                        )
                      ],
                    ).marginOnly(left: 10)
                  ],
                ),
              )
            ],
          ),
        ),
        // cal 2
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16, top: 16),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          child: Text(
            'Customer: Walk-in Customer',
            style: theme.textTheme.titleSmall,
          ),
        ),
        // payment Method
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16, top: 16),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer: Walk-in Customer',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.generate(
                    controller.paymentMathod.length,
                    (index) {
                      var data = controller.paymentMathod[index];
                      return Obx(() {
                        return PrimaryBtn(
                          color: ConfigController.to.isLightTheme
                              ? theme.scaffoldBackgroundColor
                              : Colors.white,
                          textColor: Colors.red,
                          onPressed: () {
                            controller.paymentMathodActiveIndex.value = index;
                            TableDialogs.makePayment();
                          },
                          text: data,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: theme.primaryColorDark),
                          borderColor:
                              controller.paymentMathodActiveIndex.value == index
                                  ? theme.primaryColor
                                  : theme.hintColor,
                          isOutline: true,
                        );
                      });
                    },
                  )),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ],
    );
  }

  // item details
  Widget _itemDetails(ThemeData theme, OrderModel? data) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header

          const SizedBox(height: 16),

          SizedBox(
            // width: 1900,
            child: Column(
              children: [
                // header
                const CustomTableItem(
                  isHeader: true,
                ),
                ...List.generate(data!.carts.length, (index) {
                  var item = data.carts[index];
                  var tax = (item.price - item.discountAmount) * .05;
                  var totalPrice =
                      (item.price - item.discountAmount) * item.quantity;
                  var discount = item.discountAmount;
                  return CustomTableItem(
                    sl: "${index + 1}",
                    name: item.name,
                    qty: "${item.quantity}",
                    discount: discount.toStringAsFixed(2),
                    tax: tax.toStringAsFixed(2),
                    totalPrice: totalPrice.toStringAsFixed(2),
                    price: "${item.price}",
                  );
                })
              ],
            ),
          ),

          SizedBox(
            child: Column(
              children: [
                // header
                Container(
                  decoration: BoxDecoration(color: theme.disabledColor),
                  child: const Row(),
                )
                // items
              ],
            ),
          ),

          // btns area
          const SizedBox(height: 24),
          const Divider(),
          // Row(
          //   children: [
          //     Expanded(
          //       child: PrimaryBtn(
          //         onPressed: () {
          //           Get.back();
          //           PosController.to.isUpdateView = true;
          //           PosController.to.guestController.text =
          //               data.numberOfPeople.toString();
          //           PosController.to.tableController.text =
          //               data.table?.tableName ?? "";
          //           PosController.to.onchangePage(0);
          //         },
          //         // width: double.infinity,
          //         text: 'Add Items,Change Table,Guests',
          //         textColor: Colors.white,
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //         color: theme.primaryColor,
          //       ),
          //     ),
          //     Expanded(
          //       child: PrimaryBtn(
          //         onPressed: () {},
          //         // width: double.infinity,
          //         text: 'Repeat Items',
          //         textColor: Colors.white,
          //         color: StaticColors.greenColor,
          //       ).marginOnly(left: 12),
          //     ),
          //     Expanded(
          //       child: PrimaryBtn(
          //         onPressed: () {
          //           Get.to(() => const SplitOrderView());
          //         },
          //         // width: double.infinity,
          //         text: 'Split Order',
          //         textColor: Colors.white,
          //         color: theme.primaryColor,
          //       ).marginOnly(left: 12),
          //     ),
          //     Expanded(
          //       child: PrimaryBtn(
          //         onPressed: () {},
          //         // width: double.infinity,
          //         text: 'Transfer Items',
          //         textColor: Colors.white,
          //         color: StaticColors.pinkColor,
          //       ).marginOnly(left: 12),
          //     ),
          //     Expanded(
          //       child: PrimaryBtn(
          //         onPressed: () {},
          //         // width: double.infinity,
          //         text: 'Discount Check',
          //         textColor: Colors.white,
          //         color: StaticColors.blueColor,
          //       ).marginOnly(left: 12),
          //     ),
          //   ],
          // ),

          const SizedBox(height: 16),
          _row(theme,
              title: "Subtotal :",
              fontSize: 16,
              value: data.subTotal.toStringAsFixed(2),
              fontWeight: FontWeight.w500),
          _row(theme,
              title: "GST 5% :",
              fontSize: 16,
              value: data.totalGst.toStringAsFixed(2),
              fontWeight: FontWeight.w500),
          _row(theme,
              title: "Total :",
              value: data.totalOrderAmount.toStringAsFixed(2),
              fontSize: 18),
        ],
      ),
    );
  }
}

// row
Widget _row(ThemeData theme,
    {double? fontSize,
    FontWeight? fontWeight,
    required String title,
    required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w700),
      ),
      Text(
        value,
        style: theme.textTheme.titleSmall?.copyWith(
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w700),
      ),
    ],
  );
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.name,
    required this.qnty,
    required this.price,
    this.onTap,
    this.bgColor,
  });

  final String name;
  final int qnty;
  final double price;
  final VoidCallback? onTap;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Theme.of(context).focusColor, width: 0.15),
        ),
        child: Row(
          children: [
            Expanded(flex: 4, child: MyCustomText(name)),
            Expanded(flex: 1, child: MyCustomText('x$qnty')),
            Expanded(
              flex: 2,
              child: MyCustomText('\$${price.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}
