import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  TextEditingController percentageDiscoun = TextEditingController();
  TextEditingController amountDiscoun = TextEditingController();

  bool isPercentage = true;
  onChangePercentage(bool value) {
    setState(() {
      isPercentage = value;
    });
  }

  @override
  void dispose() {
    percentageDiscoun.dispose();
    amountDiscoun.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ++++++ Percentage ++++++

        Row(
          children: [
            Checkbox(
              onChanged: (value) {
                onChangePercentage(true);
              },
              value: isPercentage,
            ),
            Text(
              'Percentage',
              style: theme.textTheme.titleLarge,
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GetBuilder<PosController>(builder: (controller) {
                return Wrap(
                  runSpacing: 6,
                  spacing: 6,
                  children: [
                    ...List.generate(controller.percentageDiscountList.length,
                        (index) {
                      var item = controller.percentageDiscountList[index];
                      return PrimaryBtn(
                        onPressed: () {},
                        text: "% $item",
                        width: 65,
                        height: 65,
                        isdisabled: !isPercentage,
                        textColor: Colors.white,
                        maxLines: 1,
                        textMaxSize: 16,
                        textMinSize: 14,
                      );
                    })
                  ],
                );
              }),
            ),
            Expanded(
                child: CustomTextField(
              controller: percentageDiscoun,
              hintText: "OTHERS",
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 22),
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
              ],
            ))
          ],
        ),

        const SizedBox(height: 50),
        // ++++++ Amount ++++++
        Row(
          children: [
            Checkbox(
              onChanged: (value) {
                onChangePercentage(false);
              },
              value: !isPercentage,
            ),
            Text(
              'Amount',
              style: theme.textTheme.titleLarge,
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GetBuilder<PosController>(builder: (controller) {
                return Wrap(
                  runSpacing: 6,
                  spacing: 6,
                  children: [
                    ...List.generate(controller.amountDiscountList.length,
                        (index) {
                      var item = controller.amountDiscountList[index];
                      return PrimaryBtn(
                        onPressed: () {
                          print("sfsadfasdf");
                        },
                        text: "\$ $item",
                        width: 65,
                        height: 65,
                        textColor: Colors.white,
                        isdisabled: isPercentage,
                        maxLines: 1,
                        textMaxSize: 16,
                        textMinSize: 14,
                      );
                    })
                  ],
                );
              }),
            ),
            Expanded(
                child: CustomTextField(
              controller: amountDiscoun,
              hintText: "OTHERS",
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 22),
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
              ],
            ))
          ],
        ),

        // btn row
        const SizedBox(height: 30),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryBtn(
                onPressed: () {
                  Get.back();
                },
                text: "Ok",
                height: 70,
                width: 150,
                color: StaticColors.greenColor,
                textColor: Colors.white,
              ),
              const SizedBox(width: 30),
              PrimaryBtn(
                onPressed: () {
                  Get.back();
                },
                text: "Cancle",
                height: 70,
                width: 150,
                color: StaticColors.redColor,
                textColor: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
