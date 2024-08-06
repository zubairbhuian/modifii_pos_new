import 'package:flutter/material.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
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
        width: 1000,
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
                    extraLabel: 'Number of Guest:',
                    extraLabelFontSize: 32,
                    hintText: '',
                    autofocus: true,
                    style: const TextStyle(fontSize: 48),
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
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
                  PrimaryBtn(
                      onPressed: onTap,
                      height: 115,
                      width: 120,
                      padding: const EdgeInsets.all(4.0),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 200),
                      text: "Submit")
                ],
              ),
            )
          ],
        ));
  }
}
