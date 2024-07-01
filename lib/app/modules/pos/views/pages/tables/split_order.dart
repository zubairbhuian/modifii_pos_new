import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/views/pages/tables/widgets/table_dialog.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controllers/tables_controller.dart';

class SplitOrder extends GetView<TablesController> {
  const SplitOrder({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // header
            _header(theme),
            const SizedBox(height: 16),
            Expanded(child: _splitBody(theme))
          ],
        ),
      ),
    );
  }

  Widget _header(ThemeData theme) {
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
          onPressed: () {},
          text: "Reset",
          color: const Color(0xfff5ca99),
          textColor: Colors.black,
        ),
        const SizedBox(width: 12),
        PrimaryBtn(
          onPressed: () {},
          text: "Split Amount",
          color: StaticColors.pinkColor,
          textColor: Colors.white,
        )
      ],
    );
  }

  Widget _splitBody(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left area
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            width: 450,
            child: Column(
              children: [
                // header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order 1 #0523452',
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      'Type: Dine in',
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
                      _row2(theme,
                          name: "Afsada", quantity: "2", price: "\$342"),
                      _row2(theme,
                          name: "Adfsada", quantity: "2", price: "\$342"),
                      _row2(theme,
                          name: "Adfsada", quantity: "2", price: "\$342"),
                      // price area
                      _row(theme, title: "Sub Total", value: "\$23423"),
                      _row(theme, title: "GST 5%", value: "\$23423"),
                      _row(theme, title: "Total", value: "\$23423"),
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
                          TablesController.to.splitReceipts();
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
                                side: BorderSide(
                                  color: controller
                                              .paymentMathodActiveIndex.value ==
                                          index
                                      ? theme.primaryColor
                                      : theme.disabledColor,
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: theme.primaryColorDark),
                                borderColor: theme.hintColor,
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

          // right area
          const SizedBox(width: 22),
          Expanded(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(16),
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: List.generate(10, (index) {
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // header
                        Text(
                          'Order 1 #0523452',
                          style: theme.textTheme.titleSmall,
                        ),
                        Divider(
                          color: theme.dividerColor,
                          height: 16,
                        ),
                        Text(
                          'Dine in: Guest ${index + 1}',
                          style: theme.textTheme.titleSmall,
                        ),

                        Divider(
                          color: theme.dividerColor,
                          height: 16,
                        ),
                        _row(theme, title: "Total Amount", value: "\$23423"),
                        Divider(
                          color: theme.dividerColor,
                          height: 16,
                        ),
                        _row(theme, title: "Split Amount", value: "\$23423"),
                        Divider(
                          color: theme.dividerColor,
                          height: 16,
                        ),
                        _row(theme, title: "Total Due", value: "\$23423"),
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
                            controller.splitPaymentActiveIndex.value = index;
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
                                    var data = controller.paymentMathod[index];
                                    return Obx(() {
                                      return PrimaryBtn(
                                        color: theme.scaffoldBackgroundColor,
                                        onPressed: () {
                                          controller.paymentMathodActiveIndex
                                              .value = index;
                                          TableDialogs.makePayment();
                                        },
                                        text: data,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        side: BorderSide(
                                          color: controller
                                                      .paymentMathodActiveIndex
                                                      .value ==
                                                  index
                                              ? theme.primaryColor
                                              : theme.disabledColor,
                                        ),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: theme.primaryColorDark),
                                        borderColor: theme.hintColor,
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
                  fontWeight: fontWeight ?? FontWeight.w800),
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
