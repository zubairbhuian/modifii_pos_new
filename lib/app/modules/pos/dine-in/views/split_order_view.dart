import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/split_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/dialogs/split_dialog.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_dialog.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../order/models/order_model.dart';
import '../controllers/dine_in_controller.dart';

class SplitOrderView extends GetView<DineInController> {
  const SplitOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplitOrderController());
    // final OrderModel order = PosController.to.myOrder;

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
            _header(theme, SplitOrderController.to.order),
            const SizedBox(height: 16),
            Expanded(child: _splitBody(theme, SplitOrderController.to.order))
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
          'Split Check',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(width: 12),
        PrimaryBtn(
          onPressed: () {
            SplitOrderController.to.resetSplitChecks();
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
                //TODO: split amount

                // SplitOrderController.to.updateSplitCheckCount(
                //   int.parse(SplitOrderController.to.noOfGuestTEC.text),
                // );
                SplitOrderController.to.calculateSplitReceipts();
                Get.back();
              },
            );
          },
          text: "Split Amount",
          color: StaticColors.pinkColor,
          textColor: Colors.white,
        ),
        const SizedBox(width: 12),
        PrimaryBtn(
          onPressed: () {
            SplitOrderController.to.divideItems();
          },
          text: "Breakdown Items",
          color: StaticColors.orangeColor,
          textColor: Colors.white,
        ),
        const SizedBox(width: 12),
        PrimaryBtn(
          onPressed: () {},
          text: "Divide Items",
          color: StaticColors.yellowColor,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _splitBody(ThemeData theme, OrderModel order) {
    return GetBuilder<SplitOrderController>(builder: (c) {
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
                        'Type: ${(order.orderType).replaceAll('_', '-')}',
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
                      child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: order.carts.length,
                          itemBuilder: (_, i) {
                            var item = order.carts[i];
                            return _itemRow(
                              theme,
                              onTap: () {
                                c.updateSelectedItems(item);
                              },
                              isSelected: c.selectedItems.carts.contains(item),
                              name: item.name,
                              quantity: item.quantity.toString(),
                              price: "\$${(item.price * item.quantity)}",
                            );
                          },
                          separatorBuilder: (_, __) => Divider(
                            height: 16,
                            color: theme.dividerColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Divider(
                        height: 16,
                        color: theme.dividerColor.withOpacity(0.6),
                      ),
                      // price area
                      _priceRow(theme,
                          title: "Sub Total",
                          value: "\$${c.mainSubtotal.toStringAsFixed(2)}"),
                      _priceRow(theme,
                          title: "GST 5%",
                          value: "\$${c.mainGST.toStringAsFixed(2)}"),
                      if (order.totalPst > 0.0)
                        _priceRow(theme,
                            title: "PST 10%",
                            value: "\$${c.mainPST.toStringAsFixed(2)}"),
                      if (order.totalGratuity > 0.0)
                        _priceRow(theme,
                            title: "Gratuity 18%",
                            value: "\$${c.mainGratuity.toStringAsFixed(2)}"),
                      if (order.totalDiscount > 0.0)
                        _priceRow(theme,
                            title: "Discount",
                            value:
                                "\$${order.totalDiscount.toStringAsFixed(2)}"),
                      _priceRow(theme,
                          title: "Total",
                          fontSize: 18,
                          value: "\$${c.mainTotal.toStringAsFixed(2)}"),
                    ],
                  )),

                  // btn area
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryBtn(
                          onPressed: () {
                            // TablesController.to.splitReceipts();
                            c.addToListOfSelectedItems();
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: theme.colorScheme.background),
                                  borderColor: controller
                                              .paymentMathodActiveIndex.value ==
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
                if (c.isSplitByAmount == null) {
                  return const SizedBox();
                }
                return Visibility(
                  visible: c.isSplitByAmount!,
                  //split by items
                  replacement: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: List.generate(c.listOfSpitChecksByItems.length,
                          (index) {
                        return Container(
                          color: theme.cardColor,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // header
                              Row(
                                children: [
                                  Text(
                                    'Order: #${order.orderId}-SC${index + 1}',
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      //TODO: close a split bill and return item to main check
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              Divider(
                                color: theme.dividerColor.withOpacity(0.4),
                                height: 16,
                              ),
                              Row(
                                children: [
                                  MyCustomText(
                                      '${order.orderType.replaceAll('_', '-')}:  ',
                                      fontSize: 18),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        SplitDialogs.guestName(
                                          guestController: c.guestNameTEC,
                                          onTap: () => c.updateGuestName(index),
                                        );
                                      },
                                      child: MyCustomText(
                                          c.listOfSpitChecksByItems[index]
                                              .userName,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),

                              ...List.generate(
                                  c.listOfSpitChecksByItems[index].carts.length,
                                  (j) {
                                var item =
                                    c.listOfSpitChecksByItems[index].carts[j];
                                return _itemRow(
                                  theme,
                                  onTap: () {
                                    // c.updateSelectedItems(item);
                                  },
                                  isSelected:
                                      c.selectedItems.carts.contains(item),
                                  name: item.name,
                                  quantity: item.quantity.toString(),
                                  price: "\$${(item.price * item.quantity)}",
                                );
                              }),

                              Divider(
                                color: theme.dividerColor.withOpacity(0.4),
                                height: 16,
                              ),
                              //price area
                              _priceRow(theme,
                                  title: "Sub Total",
                                  value:
                                      "\$${c.listOfSpitChecksByItems[index].subTotal.toStringAsFixed(2)}"),
                              _priceRow(theme,
                                  title: "GST 5%",
                                  value:
                                      "\$${c.listOfSpitChecksByItems[index].totalGst.toStringAsFixed(2)}"),
                              if (c.listOfSpitChecksByItems[index].totalPst >
                                  0.0)
                                _priceRow(theme,
                                    title: "PST 10%",
                                    value:
                                        "\$${c.listOfSpitChecksByItems[index].totalPst.toStringAsFixed(2)}"),
                              if (c.listOfSpitChecksByItems[index]
                                      .totalGratuity >
                                  0.0)
                                _priceRow(theme,
                                    title: "Gratuity 18%",
                                    value:
                                        "\$${c.listOfSpitChecksByItems[index].totalGratuity.toStringAsFixed(2)}"),
                              if (c.listOfSpitChecksByItems[index]
                                      .totalDiscount >
                                  0.0)
                                _priceRow(theme,
                                    title: "Discount",
                                    value:
                                        "\$${c.listOfSpitChecksByItems[index].totalDiscount.toStringAsFixed(2)}"),
                              _priceRow(theme,
                                  title: "Total",
                                  fontSize: 18,
                                  value:
                                      "\$${c.listOfSpitChecksByItems[index].totalOrderAmount.toStringAsFixed(2)}"),
                              Divider(
                                color: theme.dividerColor.withOpacity(0.4),
                                height: 16,
                              ),
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
                                  controller.paymentMathodActiveIndex.value =
                                      -1;
                                  controller.isShowsplitPaymentbtn.value =
                                      false;
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                  //Split by amount
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: List.generate(
                          c.splitAmountChecks.splitAmounts.length, (index) {
                        var check = c.splitAmountChecks.splitAmounts[index];
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
                              Row(
                                children: [
                                  MyCustomText(
                                      '${order.orderType.replaceAll('_', '-')}:  ',
                                      fontSize: 18),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        SplitDialogs.guestName(
                                          guestController: c.guestNameTEC,
                                          onTap: () => c.updateGuestName(index),
                                        );
                                      },
                                      child: MyCustomText(check.guestName,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: theme.dividerColor.withOpacity(0.4),
                                height: 16,
                              ),
                              _priceRow(theme,
                                  title: "Total Amount",
                                  value:
                                      "\$${order.totalOrderAmount.toStringAsFixed(2)}"),
                              Divider(
                                color: theme.dividerColor.withOpacity(0.4),
                                height: 16,
                              ),
                              _priceRow(theme,
                                  title: "Split Amount",
                                  value:
                                      "\$${check.splitAmount.toStringAsFixed(2)}"),
                              Divider(
                                color: theme.dividerColor.withOpacity(0.4),
                                height: 16,
                              ),
                              _priceRow(theme,
                                  title: "Total Due",
                                  value:
                                      "\$${check.splitAmount.toStringAsFixed(2)}"),
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
                                onPressed: c
                                            .splitAmountChecks
                                            .splitAmounts[index]
                                            .paymentMethod !=
                                        'Unpaid'
                                    ? () {
                                        //paid already
                                      }
                                    : () {
                                        controller
                                            .splitPaymentActiveIndex.value = -1;
                                        controller.paymentMathodActiveIndex
                                            .value = -1;
                                        controller.isShowsplitPaymentbtn.value =
                                            false;
                                        controller.splitPaymentActiveIndex
                                            .value = index;
                                      },
                                width: double.infinity,
                                text: c.splitAmountChecks.splitAmounts[index]
                                            .paymentMethod !=
                                        'Unpaid'
                                    ? 'PAID (${c.splitAmountChecks.splitAmounts[index].paymentMethod})'
                                    : 'PAY',
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
                                        (j) {
                                          var data =
                                              controller.paymentMathod[j];
                                          return Obx(() {
                                            return PrimaryBtn(
                                              color:
                                                  theme.scaffoldBackgroundColor,
                                              onPressed: () {
                                                //TODO: split amount payment
                                                // controller
                                                //     .paymentMathodActiveIndex
                                                //     .value = index;
                                                SplitDialogs.tipAmount(
                                                  tipAmountController:
                                                      c.tipAmountTEC,
                                                  onTap: () {
                                                    c.updateTipAndPayMethod(
                                                        index, data);
                                                  },
                                                );
                                              },
                                              text: data.replaceAll('_', ' '),
                                              padding:
                                                  const EdgeInsets.symmetric(
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
    });
  }

  // row
  Widget _priceRow(ThemeData theme,
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
  Widget _itemRow(
    ThemeData theme, {
    required String name,
    required String quantity,
    required String price,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onTap,
      child: ColoredBox(
        color: isSelected
            ? StaticColors.blueColor.withOpacity(.18)
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
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
        ),
      ),
    );
  }
}
