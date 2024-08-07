import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget itemPrintReceipt({required OrderModel order}) {
  // style
  var titleStyle = pw.TextStyle(
    fontSize: 21,
    height: 3,
    fontWeight: pw.FontWeight.bold,
  );
  var titleSmallStyle = pw.TextStyle(
    fontSize: 10,
    height: 3,
    fontWeight: pw.FontWeight.bold,
  );
  var bodyStyle = const pw.TextStyle(
    fontSize: 11,
    height: 3,
    // fontWeight: pw.FontWeight.bold,
  );
  var lavelStyle = pw.TextStyle(
    fontSize: 9,
    height: 3,
    fontWeight: pw.FontWeight.bold,
  );
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      pw.Row(
        children: [
          pw.Text(
            'Order: ${order.orderId}',
            style: bodyStyle,
          ),
          pw.SizedBox(width: 6.0),
          pw.Expanded(
              child: pw.Text(
            DateFormat("MMM.dd,yy;hh:mma")
                .format(order.createdAt ?? DateTime.now()),
            style: bodyStyle,
          )),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(
              child: pw.Text(
                  'Server: ${order.employee?.firstName ?? order.employeeName}',
                  style: bodyStyle)),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('Station: 1', style: bodyStyle)),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text('Guest: ${order.guestName}', style: bodyStyle),
      ),
      pw.SizedBox(height: 15.0),
      pw.Text('****  ${order.orderType}  ****', style: titleStyle),
      pw.Text('****  ${order.table?.tableName ?? order.tableName}  ****',
          style: titleStyle),
      pw.SizedBox(height: 15.0),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 2),
      // ! item
      pw.SizedBox(
        height: 10,
      ),
      ...List.generate(order.carts.length, (index) {
        var data = order.carts[index];
        return pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10),
            child: pw.Row(
              children: [
                pw.SizedBox(
                    width: 30,
                    child: pw.Text('${data.quantity}',
                        style: titleStyle.copyWith(fontSize: 12))),
                pw.SizedBox(width: 6),
                pw.Expanded(
                    child: pw.Text(data.name.toUpperCase(),
                        style: titleStyle.copyWith(fontSize: 12))),
              ],
            ));
      }),
    ],
  );
}
