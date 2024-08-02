import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/split_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/dialogs/split_dialog.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_dialog.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../order/models/order_model.dart';
import '../controllers/dine_in_controller.dart';

class SplitOrderView extends GetView<DineInController> {
  const SplitOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplitOrderController());
    final OrderModel order = PosController.to.myOrder;

    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
        isPrimary: false,
      ),
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // header
            _header(theme, order),
            const SizedBox(height: 16),
            Expanded(child: _splitBody(theme, order))
          ],
        ),
      ),
    );
  }

  Widget _header(ThemeData theme, OrderModel order) {
    return Row(
      children: [
        const Icon(Icons.insert_page_break_sharp),
        const SizedBox(width: 12),
        Text(
          'Split Order',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(width: 12),
        PrimaryBtn(
          onPressed: () {
            SplitOrderController.to.updateSplitCheckCount(0);
          },
          text: "Reset",
          color: const Color(0xfff5ca99),
          textColor: Colors.black,
        ),
        const SizedBox(width: 12),
        PrimaryBtn(
          onPressed: () {
            SplitDialogs.selectNumberOfGuest(
              guestController: SplitOrderController.to.noOfGuestTEC,
              amountController: SplitOrderController.to.totalAmountTEC,
              onTap: () {
                SplitOrderController.to.updateSplitCheckCount(
                  int.parse(SplitOrderController.to.noOfGuestTEC.text),
                );
                Get.back();
              },
            );
          },
          text: "Split Amount",
          color: StaticColors.pinkColor,
          textColor: Colors.white,
        )
      ],
    );
  }

  Widget _splitBody(ThemeData theme, OrderModel order) {
    num subTotal = (order.totalOrderAmount) -
        (order.totalGst +
            order.totalPst +
            order.totalGratuity +
            order.totalDiscount);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // *** Left area MAIN RECEIPT */
          Container(
            color: theme.cardColor,
            padding: const EdgeInsets.all(16),
            width: 450,
            child: Column(
              children: [
                // header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order: #${order.orderId}',
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      'Type: ${order.orderType}',
                      style: theme.textTheme.titleSmall,
                    )
                  ],
                ),
                Divider(
                  color: theme.dividerColor,
                  height: 24,
                ),
                // items area
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(order.carts.length, (i) {
                        var item = order.carts[i];
                        return _row2(
                          theme,
                          name: item.name,
                          quantity: item.quantity.toString(),
                          price: "\$${(item.price * item.quantity)}",
                        );
                      }),
                      // price area
                      _row(theme,
                          title: "Sub Total",
                          value: "\$${subTotal.toStringAsFixed(2)}"),
                      _row(theme,
                          title: "GST 5%",
                          value: "\$${order.totalGst.toStringAsFixed(2)}"),
                      if (order.totalPst > 0.0)
                        _row(theme,
                            title: "PST 10%",
                            value: "\$${order.totalPst.toStringAsFixed(2)}"),
                      if (order.totalGratuity > 0.0)
                        _row(theme,
                            title: "Gratuity 18%",
                            value:
                                "\$${order.totalGratuity.toStringAsFixed(2)}"),
                      if (order.totalDiscount > 0.0)
                        _row(theme,
                            title: "Discount",
                            value:
                                "\$${order.totalDiscount.toStringAsFixed(2)}"),
                      _row(theme,
                          title: "Total",
                          fontSize: 18,
                          value:
                              "\$${order.totalOrderAmount.toStringAsFixed(2)}"),
                    ],
                  ),
                )),

                // btn area
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryBtn(
                        onPressed: () {
                          // TablesController.to.splitReceipts();
                        },
                        text: 'CREATE NEW ORDER',
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryBtn(
                        onPressed: () {},
                        text: 'PRINT CHECK',
                        textColor: Colors.white,
                        color: StaticColors.blueLightColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                PrimaryBtn(
                  onPressed: () {},
                  width: double.infinity,
                  text: 'GO TO ORDER',
                  textColor: Colors.white,
                  color: StaticColors.pinkColor,
                ),
                const SizedBox(height: 8),
                PrimaryBtn(
                  onPressed: () {
                    controller.splitPaymentActiveIndex.value = -1;
                    controller.paymentMathodActiveIndex.value = -1;
                    controller.isShowsplitPaymentbtn.value =
                        !controller.isShowsplitPaymentbtn.value;
                  },
                  width: double.infinity,
                  text: 'PAY',
                  textColor: Colors.white,
                  color: StaticColors.greenColor,
                ),
                // payment method
                const SizedBox(height: 16),
                Obx(() {
                  if (controller.isShowsplitPaymentbtn.value == true) {
                    return Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        children: List.generate(
                          controller.paymentMathod.length,
                          (index) {
                            var data = controller.paymentMathod[index];
                            return Obx(() {
                              return PrimaryBtn(
                                color: theme.scaffoldBackgroundColor,
                                onPressed: () {
                                  controller.paymentMathodActiveIndex.value =
                                      index;
                                  TableDialogs.makePayment();
                                },
                                text: data,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: theme.primaryColorDark),
                                borderColor:
                                    controller.paymentMathodActiveIndex.value ==
                                            index
                                        ? theme.primaryColor
                                        : theme.disabledColor,
                              );
                            });
                          },
                        ));
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),

          // *** Right area SPLIT RECEIPTS */
          const SizedBox(width: 22),
          Expanded(
            child: GetBuilder<SplitOrderController>(builder: (c) {
              return Visibility(
                visible: c.splitCheckCount > 0,
                child: SingleChildScrollView(
                  // padding: const EdgeInsets.all(16),
                  child: StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: List.generate(c.splitCheckCount, (index) {
                      return Container(
                        color: theme.cardColor,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // header
                            Text(
                              'Order: #${order.orderId}-SC${index + 1}',
                              style: theme.textTheme.titleSmall,
                            ),
                            Divider(
                              color: theme.dividerColor.withOpacity(0.4),
                              height: 16,
                            ),
                            Text(
                              'Dine in: Guest ${index + 1}',
                              style: theme.textTheme.titleSmall,
                            ),

                            Divider(
                              color: theme.dividerColor.withOpacity(0.4),
                              height: 16,
                            ),
                            _row(theme,
                                title: "Total Amount",
                                value:
                                    "\$${order.totalOrderAmount.toStringAsFixed(2)}"),
                            Divider(
                              color: theme.dividerColor.withOpacity(0.4),
                              height: 16,
                            ),
                            _row(theme,
                                title: "Split Amount",
                                value:
                                    "\$${((order.totalOrderAmount) / c.splitCheckCount).toStringAsFixed(2)}"),
                            Divider(
                              color: theme.dividerColor.withOpacity(0.4),
                              height: 16,
                            ),
                            _row(theme,
                                title: "Total Due",
                                value:
                                    "\$${((order.totalOrderAmount) / c.splitCheckCount).toStringAsFixed(2)}"),
                            const SizedBox(height: 8),
                            PrimaryBtn(
                              onPressed: () {},
                              text: 'PRINT CHECK',
                              width: double.infinity,
                              textColor: Colors.white,
                              color: StaticColors.blueLightColor,
                            ),
                            const SizedBox(height: 8),
                            PrimaryBtn(
                              onPressed: () {
                                controller.splitPaymentActiveIndex.value = -1;
                                controller.paymentMathodActiveIndex.value = -1;
                                controller.isShowsplitPaymentbtn.value = false;
                                controller.splitPaymentActiveIndex.value =
                                    index;
                              },
                              width: double.infinity,
                              text: 'PAY',
                              textColor: Colors.white,
                              color: StaticColors.greenColor,
                            ),
                            const SizedBox(height: 8),
                            // payment method
                            Obx(() {
                              if (controller.splitPaymentActiveIndex.value ==
                                  index) {
                                return Wrap(
                                    spacing: 8,
                                    runSpacing: 12,
                                    children: List.generate(
                                      controller.paymentMathod.length,
                                      (index) {
                                        var data =
                                            controller.paymentMathod[index];
                                        return Obx(() {
                                          return PrimaryBtn(
                                            color:
                                                theme.scaffoldBackgroundColor,
                                            onPressed: () {
                                              controller
                                                  .paymentMathodActiveIndex
                                                  .value = index;
                                              TableDialogs.makePayment();
                                            },
                                            text: data,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: theme
                                                    .colorScheme.background),
                                            borderColor: controller
                                                        .paymentMathodActiveIndex
                                                        .value ==
                                                    index
                                                ? theme.primaryColor
                                                : theme.disabledColor,
                                          );
                                        });
                                      },
                                    ));
                              }
                              return const SizedBox();
                            }),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  // row
  Widget _row(ThemeData theme,
      {double? fontSize,
      FontWeight? fontWeight,
      required String title,
      required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: fontSize ?? 14,
                  fontWeight: fontWeight ?? FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.w800),
          ),
        ],
      ),
    );
  }

// row 2
  Widget _row2(
    ThemeData theme, {
    required String name,
    required String quantity,
    required String price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: Text(
                'X$quantity',
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Text(
              price,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
        const Divider(
          height: 16,
        )
      ],
    );
  }
}
