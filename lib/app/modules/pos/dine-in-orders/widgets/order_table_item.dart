import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/widgets/printers_list_dialog.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/views/order_details_view.dart';
import 'package:flutter_base/app/modules/pos/order/controllers/order_controller.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'print/print_order_dialog.dart';

class OrderTableItem extends StatelessWidget {
  final OrderModel order;
  final String no;
  const OrderTableItem({
    super.key,
    required this.order,
    required this.no,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const double titleFontSize = 14;
    const FontWeight fontWeight = FontWeight.w400;
    const double gap = 2;

    return Container(
      // decoration: BoxDecoration(
      //   border: Border.symmetric(
      //     horizontal: BorderSide(
      //       width: 2,
      //       color: theme.colorScheme.background,
      //     ),
      //   ),
      // ),
      // padding: const EdgeInsets.symmetric(vertical: 14),
      margin: const EdgeInsets.only(bottom: 28),
      child: Row(
        children: [
          SizedBox(
              width: 50,
              child: MyCustomText(
                no,
                fontSize: titleFontSize,
                fontWeight: fontWeight,
              )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.orderId ?? "",
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.employee?.firstName ?? "",
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.table?.tableName ?? "",
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          SizedBox(
              width: 200,
              child: Center(
                child: MyCustomText(
                  DateFormat('MMM dd, yyyy HH:mm a').format(order.createdAt!),
                  fontSize: titleFontSize,
                  fontWeight: fontWeight,
                ),
              )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.orderType,
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              flex: 2,
              child: Center(
                child: MyCustomText(
                  order.orderStatus,
                  fontSize: titleFontSize,
                  fontWeight: fontWeight,
                ),
              )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.tip.toStringAsFixed(2),
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.totalDiscount.toStringAsFixed(2),
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.totalGratuity.toStringAsFixed(2),
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.totalGst.toStringAsFixed(2),
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.totalPst.toStringAsFixed(2),
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.refund ? 'YES' : 'N/A',
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.recall ? 'YES' : 'N/A',
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              order.totalOrderAmount.toStringAsFixed(2),
              fontSize: titleFontSize,
              fontWeight: fontWeight,
            ),
          )),
          const SizedBox(width: gap),
          SizedBox(
              width: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1,
                      child: IconButton(
                        onPressed: () async {
                          PopupDialog.showLoadingDialog();
                          var hasData =
                              await DineInController.to.getOrderById(order.id);
                          PopupDialog.closeLoadingDialog();
                          if (hasData) {
                            Get.to(() => const OrderDetailsView());
                          }
                        },
                        icon: const Icon(
                          FontAwesomeIcons.eye,
                          size: 18,
                          color: StaticColors.orangeColor,
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1,
                      child: IconButton(
                        // onPressed: onPrint,
                        onPressed: () async {
                          PopupDialog.customDialog(
                              width: 435,
                              topLavel: Text(
                                "Print Invoice",
                                style: theme.textTheme.labelMedium,
                              ),
                              child: PrintOrderDialog(
                                order: order,
                              ));
                          // OrdersController.to.printReceipt();

                          // final pdf = pw.Document();

                          // // Define the PDF page
                          // pdf.addPage(
                          //   pw.Page(
                          //     pageFormat: PdfPageFormat.a4,
                          //     build: (pw.Context context) {
                          //       return pw.Center(
                          //         child: pw.Text('Hello World',
                          //             style: const pw.TextStyle(fontSize: 40)),
                          //       ); // Center
                          //     },
                          //   ),
                          // );

                          // // Directly print the PDF
                          // await Printing.directPrintPdf(
                          //   printer: const Printer(url: "XP-80C"),
                          //   onLayout: (PdfPageFormat format) async =>
                          //       pdf.save(),
                          // );
                        },
                        icon: const Icon(
                          FontAwesomeIcons.print,
                          size: 18,
                          color: StaticColors.greenColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
