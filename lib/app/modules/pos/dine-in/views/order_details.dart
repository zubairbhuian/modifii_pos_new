import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/order_setup.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_dialog.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';

import '../widgets/custom_table_item.dart';

class OrderDetails extends GetView {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // title area
            _titleRow(theme),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // for order details
                    Expanded(child: _itemDetails(theme)),
                    // order setup
                    SizedBox(width: 400, child: _orderSetup(theme)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // title row widgets
  Widget _titleRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            'Order: #423423',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Items: 4',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Table: 4',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Guests: 4',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Server: Haveli',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Order Type: Dine In',
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
              Center(
                child: Text(
                  'Order setup',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Change Order Status',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              // CustomDropdownTextField(data: const [], onChanged: (value) {}),
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
                          color: theme.scaffoldBackgroundColor,
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
                                  : theme.disabledColor,
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
  Widget _itemDetails(ThemeData theme) {
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
          Row(
            children: [
              // left area
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month).marginOnly(right: 8),
                      Text(
                        '22 Jun 2024',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Text(
                    'Authorization Code : N/A',
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
              // btn area
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () {},
                      // width: double.infinity,
                      text: 'Print Check',
                      textColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      color: StaticColors.blueLightColor,
                    ).marginOnly(left: 12),
                  ),
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () {},
                      // width: double.infinity,
                      text: 'Print Add-on Items',
                      textColor: Colors.white,
                      color: StaticColors.blueColor,
                    ).marginOnly(left: 12),
                  ),
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () {
                        OrdersController.to.printReceipt();
                      },
                      // width: double.infinity,
                      text: 'Print Items for Kicken / Bar',
                      textColor: Colors.white,
                      color: StaticColors.greenColor,
                    ).marginOnly(left: 12),
                  ),
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () {},
                      // width: double.infinity,
                      text: 'Discount Items',
                      textColor: Colors.white,
                      color: StaticColors.blueColor,
                    ).marginOnly(left: 12),
                  ),
                  Expanded(
                    child: PrimaryBtn(
                      onPressed: () {},
                      // width: double.infinity,
                      text: 'Discount Check',
                      textColor: Colors.white,
                      color: StaticColors.blueColor,
                    ).marginOnly(left: 12),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(height: 16),

          const SizedBox(
            // width: 1900,
            child: Column(
              children: [
                // header
                CustomTableItem(
                  isHeader: true,
                ),
                CustomTableItem(),
                CustomTableItem(),
              ],
            ),
          ),

          // SizedBox(
          //     width: 1200,
          //     child: ClipRRect(
          //         borderRadius: BorderRadius.circular(12),
          //         child: Table(
          //           columnWidths: const <int, TableColumnWidth>{
          //             // 0: m.sm
          //             //     ? const FlexColumnWidth()
          //             //     : const IntrinsicColumnWidth(),
          //             // 1: FlexColumnWidth(),
          //             // 1: FixedColumnWidth(m.xl ? 200 : 364),
          //             // 2: FlexColumnWidth(),
          //             // 3: FlexColumnWidth(),
          //             // 4: FlexColumnWidth(),
          //           },
          //           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //           children: <TableRow>[
          //             TableRow(
          //               // table decoration
          //               decoration:
          //                   const BoxDecoration(color: Colors.transparent),
          //               children: <Widget>[
          //                 Text(
          //                   'SL',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginSymmetric(vertical: 23, horizontal: 13),
          //                 Container(
          //                   color: Colors.red,
          //                   width: 10,
          //                   height: 10,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Items',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Qtty',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Price',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Discount',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Tex',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Total Price',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //               ],
          //             ),
          //             TableRow(
          //               // table decoration
          //               decoration:
          //                   const BoxDecoration(color: Colors.transparent),
          //               children: <Widget>[
          //                 Text(
          //                   'Lulu Mall',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginSymmetric(vertical: 23, horizontal: 13),
          //                 Text(
          //                   'Lorem ipsum dolor sit amet consectetur. Pharetra.',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   '10.4357784',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Longtitude',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Longtitude',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 // Dropdown Button
          //                 Text(
          //                   'Longtitude',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //                 Text(
          //                   'Total Price',
          //                   style: theme.textTheme.bodyLarge,
          //                 ).marginAll(10),
          //               ],
          //             ),

          //           ],
          //         )).marginOnly(left: 20, top: 30, right: 20, bottom: 50)),

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
          Row(
            children: [
              Expanded(
                child: PrimaryBtn(
                  onPressed: () {},
                  // width: double.infinity,
                  text: 'Add Items,Change Table,Guests',
                  textColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: theme.primaryColor,
                ),
              ),
              Expanded(
                child: PrimaryBtn(
                  onPressed: () {},
                  // width: double.infinity,
                  text: 'Repeat Items',
                  textColor: Colors.white,
                  color: StaticColors.greenColor,
                ).marginOnly(left: 12),
              ),
              Expanded(
                child: PrimaryBtn(
                  onPressed: () {},
                  // width: double.infinity,
                  text: 'Split Order',
                  textColor: Colors.white,
                  color: theme.primaryColor,
                ).marginOnly(left: 12),
              ),
              Expanded(
                child: PrimaryBtn(
                  onPressed: () {},
                  // width: double.infinity,
                  text: 'Transfer Items',
                  textColor: Colors.white,
                  color: StaticColors.pinkColor,
                ).marginOnly(left: 12),
              ),
              Expanded(
                child: PrimaryBtn(
                  onPressed: () {},
                  // width: double.infinity,
                  text: 'Discount Check',
                  textColor: Colors.white,
                  color: StaticColors.blueColor,
                ).marginOnly(left: 12),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _row(theme,
              title: "Subtotal :", value: "\$00", fontWeight: FontWeight.w500),
          _row(theme,
              title: "GST 5% :", value: "\$00", fontWeight: FontWeight.w500),
          _row(theme, title: "Total :", value: "\$00", fontSize: 18),
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
