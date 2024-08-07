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
        width: 500,
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
                    hintText: '',
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: CustomTextField(
                    controller: amountController,
                    extraLabel: 'Total Amount:',
                    hintText: '',
                    readOnly: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 26, horizontal: 22),
                  )),
                  const SizedBox(width: 16),
                  PrimaryBtn(
                      onPressed: onTap,
                      height: 66,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                      text: "Submit")
                ],
              ),
            )
          ],
        ));
  }
}
