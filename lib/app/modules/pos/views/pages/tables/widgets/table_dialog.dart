import 'package:flutter/material.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';

import '../../../../../../widgets/custom_textfield.dart';

class TableDialogs {
  static makePayment() {
    PopupDialog.customDialog(
        width: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                      child: CustomTextField(
                    hintText: "Add Tip (Optional)",
                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 22),
                  )),
                  const SizedBox(width: 16),
                  PrimaryBtn(
                      onPressed: () {},
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
