import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintUtils {
  directPrint({required pw.Widget child, required String printerName}) async {
    final pdf = pw.Document();
    // Define the PDF page
    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(70 * PdfPageFormat.mm, double.infinity),
        build: (pw.Context context) {
          return pw.Center(
            child: child,
          ); // Center
        },
      ),
    );
    // Directly print the PDF
    await Printing.directPrintPdf(
      printer: Printer(url: printerName),
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
