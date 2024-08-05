import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'order_print_receipt.dart';

class PrintOrderDialog extends StatelessWidget {
  final OrderModel order;
  const PrintOrderDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryBtn(
              onPressed: () async {
                final pdf = pw.Document();
                final image =
                    await imageFromAssetBundle('assets/images/app_icon.png');
                // Define the PDF page
                pdf.addPage(
                  pw.Page(
                    pageFormat: const PdfPageFormat(
                        70 * PdfPageFormat.mm, double.infinity),
                    build: (pw.Context context) {
                      return pw.Center(
                        child: orderPrintReceipt(image, order: order),
                      ); // Center
                    },
                  ),
                );
                // Directly print the PDF
                await Printing.directPrintPdf(
                  printer: const Printer(url: "XP-80C"),
                  onLayout: (PdfPageFormat format) async => pdf.save(),
                );
                Get.back();
              },
              text: " Customer Copy",
              textColor: Colors.white,
            ),
            const SizedBox(width: 6),
            PrimaryBtn(
              onPressed: () async {
                final pdf = pw.Document();
                final image =
                    await imageFromAssetBundle('assets/images/app_icon.png');
                // Define the PDF page
                pdf.addPage(
                  pw.Page(
                    pageFormat: const PdfPageFormat(
                        70 * PdfPageFormat.mm, double.infinity),
                    build: (pw.Context context) {
                      return pw.Center(
                        child: orderPrintReceipt(image,
                            isCustomerCopy: false, order: order),
                      ); // Center
                    },
                  ),
                );
                // Directly print the PDF
                await Printing.directPrintPdf(
                  printer: const Printer(url: "XP-80C"),
                  onLayout: (PdfPageFormat format) async => pdf.save(),
                );
                Get.back();
              },
              text: " Merchant Copy",
              textColor: Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset(
          "assets/images/app_icon.png",
          width: 140,
        ),
        const SizedBox(height: 16),
        //todo: need to add branch name
        const Text(
          "Haveli Bistro",
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
        ),
        //todo: need to add addresss
        Text(
          "7488 King George Blvd.",
          style: theme.textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          "Unit 350, Surrey, B.C. V3W 0H9",
          style: theme.textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        Visibility(
          visible: order.guestPhoneNumber.isNotEmpty,
          child: Text(
            "Phone: ${order.guestPhoneNumber}",
            style: theme.textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Order: ${order.orderId}",
                style: theme.textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
                child: Text(
              DateFormat("MMM.dd,yy;hh:mma").format(order.createdAt!),
              style: theme.textTheme.labelLarge,
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Server: ${order.employee?.firstName}",
                style: theme.textTheme.labelLarge,
                // textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Station: 1",
                style: theme.textTheme.labelLarge,
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Guest: ${order.guestName}",
                style: theme.textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Type: ${order.orderType}",
                style: theme.textTheme.labelLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        // !item header
        Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                "QYT",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                "ITEM",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "AMT",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            )
          ],
        ),
        const Divider(),
        // item
        // !item
        ...List.generate(order.carts.length, (index) {
          var data = order.carts[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  "${data.quantity}",
                  style: theme.textTheme.labelLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  data.name,
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "\$${data.price}",
                style: theme.textTheme.labelLarge,
                textAlign: TextAlign.start,
              )
            ],
          ).marginOnly(bottom: 8);
        }),

        Divider(
          color: theme.textTheme.bodyLarge?.color,
          height: 18,
        ),
        // ! total calculation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub total",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              "\$${order.subTotal}",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            )
          ],
        ),
        //  ******  gst  *****
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GST 5%",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              "\$${order.totalGst}",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            )
          ],
        ),
        // ****** pst ******
        Visibility(
          visible: order.totalPst > 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PST 18%",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                "\$${order.totalPst}",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // ****** Gratuity ******
        Visibility(
          visible: order.totalGratuity > 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PST 18%",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                "\$${order.totalGratuity}",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // ****** Tip ******
        Visibility(
          visible: order.tip > 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tip",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                "\$${order.tip}",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),

        // ****** Discount ******
        Visibility(
          visible: order.totalDiscount > 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount (-)",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                "\$${order.totalDiscount}",
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // ****** Total ******
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              order.paymentStatus == "UNPAID" ? "Total" : "Total (PAID)",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            Text(
              "\$${order.totalOrderAmount}",
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Divider(
          color: theme.textTheme.bodyLarge?.color,
          height: 18,
        ),
        // !  end
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Customer Copy: ",
            style: theme.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        //todo need to dynamic
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Visa Credit Card Sale",
            style: theme.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Divider(
          color: theme.textTheme.bodyLarge?.color,
          height: 18,
        ),
        //todo need to dynamic
        Text(
          "Thank you for visiting HAVELI BISTRO",
          style: theme.textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        Divider(
          color: theme.textTheme.bodyLarge?.color,
          height: 18,
        ),
        Text(
          "Please review us on Google",
          style: theme.textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        Divider(
          color: theme.textTheme.bodyLarge?.color,
          height: 18,
        ),
        Text(
          "GST NUMBER: GST 717783914 RT0001",
          style: theme.textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
