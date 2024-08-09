import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/controllers/dine_in_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/widgets/print/print_order_dialog.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/views/split_order_view.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/dialogs/discount_dialog.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_dialog.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/my_func.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
// import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widgets/custom_table_item.dart';

class OrderDetailsView extends GetView<DineInController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const double btnSize = 120;
    const double height = 80;
    const double textMaxSize = 30;
    const double textMinSize = 11;
    return Scaffold(
      appBar: CustomAppBar(
        isPrimary: false,
        onLeading: () {
          PosController.to.clearCartList();
          Get.back();
        },
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
                        onPressed: () {
                          Get.back();
                          controller.isUpdateView = false;
                          controller.clearCartList();
                          PosController.to.onchangePage(0);
                          controller.update();
                        },
                        color: StaticColors.greenColor,
                        textColor: Colors.white,
                        text: 'pos'.toUpperCase(),
                        textMaxSize: textMaxSize,
                        textMinSize: textMinSize,
                      ),

                      GetBuilder<PosController>(builder: (context) {
                        return PrimaryBtnWithChild(
                          width: btnSize,
                          height: height,
                          onPressed: () {},
                          textColor: Colors.white,
                          color: context.selectedItemList.isEmpty
                              ? StaticColors.blueColor.withOpacity(.7)
                              : StaticColors.blueColor,
                          // width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.print),
                              SizedBox(height: 6),
                              Text("Print Items"),
                            ],
                          ),
                        ).marginOnly(left: 16);
                      }),
                      GetBuilder<PosController>(builder: (context) {
                        return PrimaryBtnWithChild(
                          width: btnSize,
                          height: height,
                          // isdisabled:
                          //     context.selectedItemList.isEmpty ? true : false,
                          // textMaxSize: textMaxSize,
                          // textMinSize: textMinSize,
                          onPressed: () {
                            PopupDialog.customDialog(
                                width: 435,
                                topLavel: Text(
                                  "Print Invoice",
                                  style: theme.textTheme.labelMedium,
                                ),
                                child: PrintOrderDialog(
                                  order: controller.myOrder,
                                ));
                          },
                          // maxLines: 3,
                          textColor: Colors.white,
                          color: StaticColors.blueLightColor,
                          // width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.print),
                              SizedBox(height: 6),
                              Text("Print Check"),
                            ],
                          ),
                        ).marginOnly(left: 16);
                      }),

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
                      GetBuilder<PosController>(builder: (context) {
                        return PrimaryBtn(
                          width: btnSize,
                          height: height,
                          isdisabled:
                              context.selectedItemList.isEmpty ? true : false,
                          textMaxSize: textMaxSize,
                          textMinSize: textMinSize,
                          onPressed: () {
                            PopupDialog.customDialog(
                                width: 700, child: const DiscountDialog());
                          },
                          // width: double.infinity,
                          text: 'Discount'.toUpperCase(),
                          textColor: Colors.white,
                          color: StaticColors.blueColor,
                        ).marginOnly(left: 12);
                      }),
                      // right side
                    ],
                  ),
                ],
              ).marginOnly(left: 25),

              // title area
              GetBuilder<PosController>(builder: (context) {
                return _titleRow(theme, context.myOrder).marginOnly(left: 25);
              }),
              Expanded(
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
              const SizedBox(height: 50),
            ],
          ),
        );
      }),
    );
  }

  // title row widgets
  Widget _titleRow(ThemeData theme, OrderModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            'Order: #${data.orderId}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Items: ${data.carts.length}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Table: ${data.tableName}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Guests: ${data.numberOfPeople}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          InkWell(
            onTap: () {
              PopupDialog.customDialog(
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change Server',
                        style: theme.textTheme.displaySmall,
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Select Server',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<DineInOrderController>(builder: (context) {
                        return CustomSearchTextField(
                          dropDownItemCount: context.orderStatusList.length,
                          hintText: data.employee?.firstName,
                          dropDownList: List.generate(
                              PosController.to.employeeList.length, (index) {
                            var data = PosController.to.employeeList[index];
                            return DropDownValueModel(
                                name: data.firstName, value: data.id);
                          }),
                          onChanged: (value) async {
                            PopupDialog.showLoadingDialog();
                            bool isLoaded = await PosController.to
                                .onUpdateOrderItems(PosController.to.myOrder.id,
                                    employeeId: "${value.value}");
                            PopupDialog.closeLoadingDialog();
                            if (isLoaded) {
                              Get.back();
                            }

                            // DineInOrderController.to.getAllOrders();
                          },
                        );
                      }),
                      const SizedBox(height: 35),
                    ],
                  ));
            },
            child: Row(
              children: [
                Text(
                  'Server:${MyFunc.capitalizeEachWord(s: data.employee?.firstName)}',
                  style: theme.textTheme.titleMedium,
                ),
                const Icon(
                  Icons.edit_square,
                  color: StaticColors.blueLightColor,
                )
              ],
            ).marginOnly(right: 16),
          ),
          Text(
            'Order Type: ${data.orderType}'.replaceAll("_", " "),
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
              GetBuilder<DineInOrderController>(builder: (context) {
                return CustomSearchTextField(
                  dropDownItemCount: context.orderStatusList.length,
                  hintText: PosController.to.myOrder.orderStatus,
                  dropDownList: const [
                    DropDownValueModel(name: "COMPLETED", value: "COMPLETED"),
                    DropDownValueModel(name: "CANCELED", value: "CANCELED"),
                    DropDownValueModel(name: "CONFIRMED", value: "CONFIRMED"),
                  ],
                  onChanged: (value) async {
                    PopupDialog.showLoadingDialog();
                    await PosController.to.onUpdateOrderItems(
                        PosController.to.myOrder.id,
                        orderStatus: "${value.name}".toUpperCase());
                    PopupDialog.closeLoadingDialog();
                    DineInOrderController.to.getAllOrders();
                  },
                );
              }),
              const SizedBox(height: 16),
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
                    GetBuilder<PosController>(builder: (c) {
                      return Row(
                        children: [
                          Text(
                            c.myOrder.paymentStatus,
                            style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: theme.disabledColor),
                          ),
                          Switch(
                            value: c.myOrder.paymentStatus == "UNPAID"
                                ? false
                                : true,
                            onChanged: (value) async {
                              if (c.myOrder.paymentStatus == "UNPAID") {
                                PopupDialog.showLoadingDialog();
                                await PosController.to.onUpdateOrderItems(
                                    c.myOrder.id,
                                    paymentStatus: "PAID");
                                PopupDialog.closeLoadingDialog();
                                DineInOrderController.to.getAllOrders();
                              }
                            },
                            splashRadius: 12,
                          )
                        ],
                      ).marginOnly(left: 10);
                    })
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
  Widget _itemDetails(ThemeData theme, OrderModel data) {
    const double btnSize = 180;
    const double height = 60;
    const double textMaxSize = 30;
    const double textMinSize = 11;
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
          // header
          GetBuilder<PosController>(builder: (c) {
            return CustomTableItem(
              isSelected: c.selectedItemList.isNotEmpty,
              isHeader: true,
              onChanged: (value) {
                c.toggleAllSelectedItem();
              },
            );
          }),
          Expanded(
            child: SingleChildScrollView(
              // width: 1900,
              child: Column(
                children: [
                  Column(
                    children: List.generate(data.carts.length, (index) {
                      var item = data.carts[index];
                      var tax = (item.price - item.discountAmount) * .05;
                      var totalPrice =
                          (item.price - item.discountAmount) * item.quantity;
                      var discount = item.discountAmount;
                      return GetBuilder<PosController>(builder: (c) {
                        return CustomTableItem(
                          onTap: () {
                            c.onChangeSelectedItemList("$index");
                          },
                          isSelected: c.selectedItemList.contains("$index"),
                          onChanged: (value) {
                            kLogger.e(c.onChangeSelectedItemList.toString());
                            c.onChangeSelectedItemList(index.toString());
                          },
                          sl: "${index + 1}",
                          name: item.name,
                          qty: "${item.quantity}",
                          discount: "\$ ${discount.toStringAsFixed(2)}",
                          tax: "\$ ${tax.toStringAsFixed(2)}",
                          totalPrice: "\$ ${totalPrice.toStringAsFixed(2)}",
                          price: "\$ ${item.price}",
                        );
                      });
                    }),
                  ),
                ],
              ),
            ),
          ),

          const Divider(
            height: 20,
          ),
          _row(theme,
              title: "Subtotal :",
              fontSize: 17,
              value: "\$ ${data.subTotal.toStringAsFixed(2)}",
              fontWeight: FontWeight.w800),
          const SizedBox(height: 8),
          _row(theme,
              title: "GST 5% :",
              fontSize: 16,
              value: "\$ ${data.totalGst.toStringAsFixed(2)}",
              fontWeight: FontWeight.w500),
          Visibility(
            visible: data.totalGratuity > 0,
            child: _row(
              fontWeight: FontWeight.w500,
              theme,
              title: "Gratuity 18% : ",
              value: "\$${data.totalGratuity.toStringAsFixed(2)}",
            ),
          ),
          Visibility(
            visible: data.totalPst > 0,
            child: _row(
              fontWeight: FontWeight.w500,
              theme,
              title: "PST 10% : ",
              value: "\$${data.totalPst.toStringAsFixed(2)}",
            ),
          ),
          Visibility(
            visible: data.tip > 0,
            child: _row(
              fontWeight: FontWeight.w500,
              theme,
              title: "Tip : ",
              value: "\$${data.tip.toStringAsFixed(2)}",
            ),
          ),
          Visibility(
            visible: data.totalDiscount > 0,
            child: _row(
              child: InkWell(
                onTap: () {
                  PopupDialog.customDialog(
                      width: 500,
                      child: Column(
                        children: [
                          Text(
                            'Are you sure to delete this Discount?',
                            style: theme.textTheme.displaySmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryBtn(
                                onPressed: () async {
                                  PosController.to.deleteDiscount();
                                  Get.back();
                                  await PosController.to.onUpdateOrder(
                                      PosController.to.myOrder.id,
                                      isClearList: false);
                                },
                                width: 120,
                                height: 60,
                                text: "Yes",
                                textMaxSize: 35,
                                textMinSize: 30,
                                textColor: Colors.white,
                                color: StaticColors.greenColor,
                              ),
                              const SizedBox(width: 16),
                              PrimaryBtn(
                                  width: 120,
                                  height: 60,
                                  textMaxSize: 35,
                                  textMinSize: 30,
                                  textColor: Colors.white,
                                  color: StaticColors.redColor,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  text: "No"),
                            ],
                          )
                        ],
                      ));
                },
                child: const Icon(
                  Icons.delete,
                  color: StaticColors.redColor,
                ),
              ),
              fontWeight: FontWeight.w500,
              theme,
              title: "Discount : ",
              value: "\$${data.totalDiscount.toStringAsFixed(2)}",
            ),
          ),
          const SizedBox(height: 12),
          _row(theme,
              title: "Total :",
              value: "\$ ${data.totalOrderAmount.toStringAsFixed(2)}",
              fontSize: 18,
              fontWeight: FontWeight.w800),
          const SizedBox(height: 30),
          Row(
            children: [
              PrimaryBtn(
                width: 200,
                height: height,
                textMaxSize: textMaxSize,
                textMinSize: textMinSize,
                onPressed: () {
                  PosController.to.isUpdateView = true;
                  PosController.to.guestController.text =
                      data.numberOfPeople.toString();
                  PosController.to.tableController.text = data.tableName;
                  PosController.to.guestNameController.text = data.guestName;
                  PosController.to.guestPhoneController.text =
                      data.guestPhoneNumber;
                  // unable to edit
                  PosController.to.onReadOnlyAllCartTextField();
                  // Get.to(() => const OrderDetailsView());
                  Get.back();
                  PosController.to.onchangePage(0);
                },
                // Add Items,Change Table,Guests
                text: 'Add Items ,\nChange Table, Guests'.toUpperCase(),
                textColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                color: theme.primaryColor,
              ),
              GetBuilder<PosController>(builder: (context) {
                return PrimaryBtn(
                  onPressed: () {},
                  width: btnSize,
                  height: height,
                  isdisabled: context.selectedItemList.isEmpty ? true : false,
                  textMaxSize: textMaxSize,
                  textMinSize: textMinSize,
                  text: 'Repeat Items'.toUpperCase(),
                  textColor: Colors.white,
                  color: StaticColors.greenColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                ).marginOnly(left: 12);
              }),
              PrimaryBtn(
                onPressed: () {},
                width: btnSize,
                height: height,
                textMaxSize: textMaxSize,
                textMinSize: textMinSize,
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                text: 'Transfer Items'.toUpperCase(),
                textColor: Colors.white,
                color: StaticColors.pinkColor,
              ).marginOnly(left: 12),
              GetBuilder<PosController>(builder: (context) {
                return PrimaryBtn(
                  width: btnSize,
                  height: height,
                  isdisabled: context.selectedItemList.isEmpty ? true : false,
                  textMaxSize: textMaxSize,
                  textMinSize: textMinSize,
                  onPressed: () {
                    context.removeAllSelectedItem();
                  },
                  // width: double.infinity,
                  text: 'Remove Items'.toUpperCase(),
                  textColor: Colors.white,
                  color: StaticColors.pinkColor,
                ).marginOnly(left: 12);
              }),
            ],
          )
        ],
      ),
    );
  }
}

// row
Widget _row(
  ThemeData theme, {
  double? fontSize,
  FontWeight? fontWeight,
  Widget? child,
  required String title,
  required String value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.w700),
          ),
          SizedBox(
            child: child,
          )
        ],
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
