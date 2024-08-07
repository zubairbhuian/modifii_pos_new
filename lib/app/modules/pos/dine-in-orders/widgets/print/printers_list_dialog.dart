import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/services/base/preferences.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
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
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: PrimaryBtn(
                width: 200,
                onPressed: () async {
                  Preferences.currenterPrinter = value[index].name;
                  kLogger.e(Preferences.currenterPrinter);
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
