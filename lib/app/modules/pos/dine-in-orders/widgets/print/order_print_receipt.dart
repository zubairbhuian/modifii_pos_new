import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget orderPrintReceipt(dynamic image,
    {bool isCustomerCopy = true, required OrderModel order}) {
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
      pw.Image(image, height: 60),
      // Todo:
      pw.Center(
          child: pw.Text(
        'Haveli Bistro'.toUpperCase(),
        style: titleStyle,
      )),
      pw.SizedBox(height: 10),
      // Todo:
      pw.Text(
        '7488 King George Blvd.',
        style: bodyStyle,
      ),
      pw.Text(
        'Unit 350, Surrey, B.C. V3W 0H9',
        style: bodyStyle,
      ),
      if (order.guestPhoneNumber.isNotEmpty)
        pw.Text(
          'Phone: ${order.guestPhoneNumber}',
          style: bodyStyle,
        ),
      pw.Divider(color: PdfColor.fromHex('#303030')),
      pw.Row(
        children: [
          pw.Text(
            'Order: ${order.orderId}',
            style: bodyStyle,
          ),
          pw.SizedBox(width: 6.0),
          pw.Expanded(
              child: pw.Text(
            DateFormat("MMM.dd,yy;hh:mma").format(order.createdAt!),
            style: bodyStyle,
          )),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(
              child: pw.Text('Server: ${order.employee?.firstName}',
                  style: bodyStyle)),
          pw.SizedBox(width: 10.0),
          pw.Expanded(child: pw.Text('Station: 1', style: bodyStyle)),
        ],
      ),
      pw.SizedBox(height: 6.0),
      pw.Row(
        children: [
          pw.Expanded(
              child: pw.Text('Guest: ${order.guestName}', style: bodyStyle)),
          pw.SizedBox(width: 10.0),
          pw.Expanded(
              child: pw.Text('Type: ${order.orderType}', style: bodyStyle)),
        ],
      ),
      pw.SizedBox(height: 15.0),
      // ! item header
      pw.Row(
        children: [
          pw.SizedBox(width: 25, child: pw.Text('QTY', style: bodyStyle)),
          pw.SizedBox(width: 6),
          pw.Expanded(child: pw.Text('Item', style: bodyStyle)),
          pw.SizedBox(width: 6),
          pw.Text('AMT', style: bodyStyle),
        ],
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 2),
      // ! item
      pw.SizedBox(
        height: 10,
      ),
      ...List.generate(order.carts.length, (index) {
        var data = order.carts[index];
        return pw.Row(
          children: [
            pw.SizedBox(
                width: 25,
                child: pw.Text('${data.quantity}', style: bodyStyle)),
            pw.SizedBox(width: 6),
            pw.Expanded(
                child: pw.Text(data.name.toUpperCase(), style: bodyStyle)),
            pw.SizedBox(width: 6),
            pw.Text('\$${data.price}', style: bodyStyle),
          ],
        );
      }),
      //! total calculation
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 16),
      // subTotal
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Sub total', style: titleSmallStyle),
          pw.SizedBox(width: 6),
          pw.Text('\$${order.subTotal}', style: titleSmallStyle),
        ],
      ),
      // GST
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('GST 5%', style: titleSmallStyle),
          pw.SizedBox(width: 10.0),
          pw.Text('\$${order.totalGst}', style: titleSmallStyle),
        ],
      ),
      //PST
      if (order.totalPst > 0)
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('PST 10%', style: titleSmallStyle),
            pw.SizedBox(width: 10.0),
            pw.Text('\$${order.totalPst}', style: titleSmallStyle),
          ],
        ),
      // ****** Gratuity ******
      if (order.totalGratuity > 0)
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Gratuity 18%', style: titleSmallStyle),
            pw.SizedBox(width: 10.0),
            pw.Text('\$${order.totalGratuity}', style: titleSmallStyle),
          ],
        ),
      // ****** Tip ******
      if (order.tip > 0)
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Tip', style: titleSmallStyle),
            pw.SizedBox(width: 10.0),
            pw.Text('\$${order.tip}', style: titleSmallStyle),
          ],
        ),
      // ****** Discount ******
      if (order.totalDiscount > 0)
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Discount (-)', style: titleSmallStyle),
            pw.SizedBox(width: 10.0),
            pw.Text('\$${order.totalDiscount}', style: titleSmallStyle),
          ],
        ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Tip', style: titleSmallStyle),
          pw.SizedBox(width: 10.0),
          pw.Text('\$5.00', style: titleSmallStyle),
        ],
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(order.paymentStatus == "UNPAID" ? "Total" : "Total (PAID)",
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              )),
          pw.SizedBox(width: 10.0),
          pw.Text('\$${order.totalOrderAmount}',
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              )),
        ],
      ),
      // ! card details
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 12),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          isCustomerCopy ? 'Customer Copy:' : 'Merchant Copy:',
          style: lavelStyle,
        ),
      ),

      pw.SizedBox(height: 4.0),
      //Todo
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'Visa Credit Card Sale',
          style: lavelStyle,
        ),
      ),
      // !  end
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 12),
      //Todo
      pw.Text(
        'Thank you for visiting HAVELI BISTRO',
        style: lavelStyle,
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 12),
      pw.Text(
        'Please review us on Google',
        style: lavelStyle,
      ),
      pw.Divider(color: PdfColor.fromHex('#303030'), height: 12),
      //Todo : what is GST number
      pw.Text(
        'GST NUMBER: GST 717783914 RT0001',
        style: lavelStyle,
      ),
    ],
  );
}
