import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import '../../../../../../widgets/custom_alert_dialog.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void printersListDialog(List<Printer> value) {
  return customAlertDialog(
    contentPadding: const EdgeInsets.all(12),
    context: Get.context!,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyCustomText(
              'Select Printers',
              fontWeight: FontWeight.w600,
            ),
            IconButton(
              onPressed: Get.back,
              icon: const Icon(FontAwesomeIcons.xmark, size: 14),
            )
          ],
        ),
        const SizedBox(height: 14),
        ...List.generate(
          value.length,
          (index) {
            final pdf = pw.Document();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: PrimaryBtn(
                width: 200,
                onPressed: () async {
                  OrdersController.to.printerName.value = value[index].name;

                  final image =
                      await imageFromAssetBundle('assets/images/app_icon.png');

                  pdf.addPage(
                    pw.Page(
                        pageFormat: PdfPageFormat.a4,
                        build: (_) {
                          return pw.Center(
                            child: _printReceipt(image),
                          );
                        }),
                  );

                  await Printing.directPrintPdf(
                    printer:
                        Printer(url: OrdersController.to.printerName.value),
                    onLayout: (PdfPageFormat format) async => pdf.save(),
                    name: 'receipt00.pdf',
                    format: PdfPageFormat.undefined,
                  );

                  Get.back();
                  Get.back();
                },
                text: value[index].name,
                textColor: Colors.white,
              ),
            );
          },
        ),
      ],
    ),
  );
}

pw.Widget? _printReceipt(dynamic image) {
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      // pw.SvgImage(
      //   svg: 'assets/images/splash/login_logo.svg',
      //   height: 100,
      // ),
      pw.Image(image, height: 80),
      pw.SizedBox(height: 10),
      pw.Text(
        '7488 King George Blvd.',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          height: 2,
        ),
      ),
      pw.Text(
        'Unit 350, Surrey, B.C. V3W 0H9',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Text(
        'Phone: 604-706-0109',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          height: 3,
        ),
      ),
      pw.Divider(color: PdfColor.fromHex('#303030')),
      pw.SizedBox(height: 10.0),
      pw.Row(
        children: [
          pw.Expanded(child: pw.Text('Order: 100089')),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('Jun.04,24;11:04am')),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(child: pw.Text('Server: Haveli')),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('Station: 1')),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(child: pw.Text('Table: 23')),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('Guests: 3')),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(child: pw.Text('Server: Haveli')),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('Station: 1')),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(child: pw.Text('Type: Dine-In')),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('')),
        ],
      ),
      pw.SizedBox(height: 16.0),
      pw.Row(
        children: [
          pw.Expanded(
              flex: 1,
              child: pw.Text('QTY', style: const pw.TextStyle(fontSize: 18))),
          pw.SizedBox(width: 10.0),
          pw.Expanded(
              flex: 3,
              child: pw.Text('Item', style: const pw.TextStyle(fontSize: 18))),
          pw.SizedBox(width: 10.0),
          pw.Expanded(
              flex: 1,
              child: pw.Text('AMT', style: const pw.TextStyle(fontSize: 18))),
        ],
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 25),
      pw.Row(
        children: [
          pw.Expanded(
              flex: 1,
              child: pw.Text('4', style: const pw.TextStyle(fontSize: 18))),
          pw.SizedBox(width: 10.0),
          pw.Expanded(
              flex: 3,
              child: pw.Text('BHINDI DO PYAZA',
                  style: const pw.TextStyle(fontSize: 18))),
          pw.SizedBox(width: 10.0),
          pw.Expanded(
              flex: 1,
              child:
                  pw.Text('\$67.96', style: const pw.TextStyle(fontSize: 18))),
        ],
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 25),
      pw.SizedBox(height: 10.0),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Sub total'),
          pw.SizedBox(width: 10.0),
          pw.Text('\$67.96'),
        ],
      ),
      pw.SizedBox(height: 10.0),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('GST 5%'),
          pw.SizedBox(width: 10.0),
          pw.Text('\$3.40'),
        ],
      ),
      pw.SizedBox(height: 10.0),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Tip'),
          pw.SizedBox(width: 10.0),
          pw.Text('\$5.00'),
        ],
      ),
      pw.SizedBox(height: 10.0),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Total (PAID)', style: const pw.TextStyle(fontSize: 20)),
          pw.SizedBox(width: 10.0),
          pw.Text('\$76.36', style: const pw.TextStyle(fontSize: 20)),
        ],
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 20),
      pw.Text(
        'Customer Copy',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(height: 4.0),
      pw.Text(
        'Visa Credit Card Sale',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 20),
      pw.Text(
        'Thank you for visiting HAVELI BISTRO',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 20),
      pw.Text(
        'Please review us on Google',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 20),
      pw.Text(
        'GST NUMBER: GST 717783914 RT0001',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ],
  );
}
