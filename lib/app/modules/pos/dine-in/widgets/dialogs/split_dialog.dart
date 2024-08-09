import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import '../../../../../widgets/custom_textfield.dart';

class SplitDialogs {
  SplitDialogs._();

  static selectNumberOfGuest({
    required TextEditingController guestController,
    required TextEditingController amountController,
    required VoidCallback onTap,
  }) {
    PopupDialog.customDialog(
        width: 900,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: CustomTextField(
                    controller: guestController,
                    extraLabel: 'Number of Guests:',
                    extraLabelFontSize: 32,
                    hintText: '',
                    autofocus: true,
                    style: const TextStyle(fontSize: 48),
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: CustomTextField(
                    controller: amountController,
                    extraLabel: 'Total Amount:',
                    extraLabelFontSize: 32,
                    hintText: '',
                    readOnly: true,
                    style: const TextStyle(fontSize: 48),
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
                  )),
                  const SizedBox(width: 16),
                  PrimaryBtnWithChild(
                    onPressed: onTap,
                    height: 115,
                    width: 128,
                    padding: const EdgeInsets.all(4.0),
                    child: const FittedBox(
                      child: MyCustomText(
                        'Submit',
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  static guestName({
    required TextEditingController guestController,
    required VoidCallback onTap,
  }) {
    PopupDialog.customDialog(
        width: 700,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: CustomTextField(
                    controller: guestController,
                    extraLabel: 'Guest Name:',
                    extraLabelFontSize: 32,
                    hintText: '',
                    autofocus: true,
                    style: const TextStyle(fontSize: 48),
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
                  )),
                  const SizedBox(width: 16),
                  PrimaryBtnWithChild(
                    onPressed: onTap,
                    height: 115,
                    width: 128,
                    padding: const EdgeInsets.all(4.0),
                    child: const FittedBox(
                      child: MyCustomText(
                        'Submit',
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  static totalAmount({
    required TextEditingController totalAmountController,
    GlobalKey<FormState>? formKey,
    String? Function(String?)? validator,
    required VoidCallback onTap,
  }) {
    PopupDialog.customDialog(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyCustomText(
              'Total Amount',
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Form(
                  key: formKey,
                  child: CustomTextField(
                    controller: totalAmountController,
                    // extraLabel: 'Tip Amount:',
                    extraLabelFontSize: 32,
                    prefixIcon: const MyCustomText('  \$  ', fontSize: 36),
                    // hintText: '(Optional)',
                    autofocus: true,
                    style: const TextStyle(fontSize: 48),
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
                    keyboardType: TextInputType.number,
                    validator: validator,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                )),
                const SizedBox(width: 16),
                PrimaryBtnWithChild(
                  onPressed: onTap,
                  height: 115,
                  width: 128,
                  padding: const EdgeInsets.all(4.0),
                  child: const FittedBox(
                    child: MyCustomText(
                      'Submit',
                      fontSize: 100,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
