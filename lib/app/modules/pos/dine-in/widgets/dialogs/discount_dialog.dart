import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  TextEditingController percentageDiscoun = TextEditingController();
  TextEditingController amountDiscoun = TextEditingController();
  String myDiscoun = "";

  bool isPercentage = true;
  onChangePercentage(bool value) {
    setState(() {
      isPercentage = value;
      if (value) {
        amountDiscoun.clear();
      } else {
        percentageDiscoun.clear();
      }
    });
  }

  removeDiscount() {
    if (myDiscoun.isNotEmpty) {
      setState(() {
        myDiscoun = myDiscoun.substring(0, myDiscoun.length - 1);
        if (isPercentage) {
          percentageDiscoun.text = myDiscoun;
        } else {
          amountDiscoun.text = myDiscoun;
        }
      });
    }
  }

  addValueWithKeybord(String value, {bool isKeybord = false}) {
    setState(() {
      //
      if (isPercentage && isKeybord && myDiscoun.length < 3) {
        percentageDiscoun.clear();
        myDiscoun += value;
        percentageDiscoun.text = myDiscoun;
        if (myDiscoun.isNotEmpty) {
          if (int.parse(myDiscoun) > 101) {
            myDiscoun = "100";
            percentageDiscoun.text = myDiscoun;
          }
        }
      } else if (!isPercentage && isKeybord && myDiscoun.length < 7) {
        amountDiscoun.clear();
        myDiscoun += value;
        amountDiscoun.text = myDiscoun;
      } else {
        if (isPercentage) {
          amountDiscoun.clear();

          myDiscoun = value;
          // percentageDiscoun.text = myDiscoun;
          if (int.parse(myDiscoun) > 101) {
            myDiscoun = "100";
            percentageDiscoun.text = myDiscoun;
          }
        } else {
          percentageDiscoun.clear();
          myDiscoun = value;
        }
      }
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
        Center(
          child: Text(
            'Discount',
            style: theme.textTheme.displaySmall
                ?.copyWith(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ).marginOnly(bottom: 25),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // for Discount area
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          onChanged: (value) {
                            onChangePercentage(true);
                          },
                          value: isPercentage,
                        ),
                      ).marginOnly(right: 30),
                      Text(
                        'Percentage',
                        style: theme.textTheme.headlineMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<PosController>(builder: (controller) {
                    return Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      children: [
                        ...List.generate(
                            controller.percentageDiscountList.length, (index) {
                          var item = controller.percentageDiscountList[index];
                          return PrimaryBtn(
                            onPressed: () {
                              percentageDiscoun.clear();
                              addValueWithKeybord(item.toString());
                            },
                            text: "$item%",
                            width: 85,
                            height: 85,
                            isdisabled: !isPercentage,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            textMaxSize: 26,
                            textMinSize: 25,
                          );
                        }),
                        SizedBox(
                          width: 175,
                          child: CustomTextField(
                            controller: percentageDiscoun,
                            onChange: addValueWithKeybord,
                            onTap: () {
                              onChangePercentage(true);
                            },
                            hintText: "custom %".toUpperCase(),
                            borderRadius: 0,
                            marginBottom: 0,
                            hintStyle: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 23, fontWeight: FontWeight.bold),
                            style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            padding: const EdgeInsets.symmetric(
                                vertical: 27, horizontal: 22),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$'))
                            ],
                          ),
                        )
                      ],
                    );
                  }),

                  const SizedBox(height: 30),
                  // ++++++ Amount ++++++
                  Row(
                    children: [
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          onChanged: (value) {
                            onChangePercentage(false);
                          },
                          value: !isPercentage,
                        ),
                      ).marginOnly(right: 30),
                      Text(
                        'Amount',
                        style: theme.textTheme.headlineMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<PosController>(builder: (controller) {
                    return Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      children: [
                        ...List.generate(controller.amountDiscountList.length,
                            (index) {
                          var item = controller.amountDiscountList[index];
                          return PrimaryBtn(
                            onPressed: () {
                              amountDiscoun.clear();
                              addValueWithKeybord(item.toString());
                            },
                            text: "\$$item",
                            width: 85,
                            height: 85,
                            isdisabled: isPercentage,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            textMaxSize: 26,
                            textMinSize: 25,
                          );
                        }),
                        SizedBox(
                          width: 175,
                          child: CustomTextField(
                            controller: amountDiscoun,
                            onChange: addValueWithKeybord,
                            onTap: () {
                              onChangePercentage(false);
                            },
                            hintText: "custom \$".toUpperCase(),
                            marginBottom: 0,
                            borderRadius: 0,
                            hintStyle: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 23, fontWeight: FontWeight.bold),
                            padding: const EdgeInsets.symmetric(
                                vertical: 27, horizontal: 22),
                            style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$'))
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ],
              ),
            ),

            // for customKeybord
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  _customKeybord(theme),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 22),
                    decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        border: Border.all(width: .5, color: Colors.white)),
                    child: MyCustomText(
                      isPercentage ? "$myDiscoun%" : "\$$myDiscoun",
                      fontWeight: FontWeight.w900,
                      maxLines: 1,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: CustomTextField(
                      // controller: amountDiscoun,
                      hintText: "DISCOUNT PIN".toUpperCase(),
                      hintStyle: theme.textTheme.titleMedium
                          ?.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                      borderRadius: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 27, horizontal: 22),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          child: CustomTextField(
            maxLines: 1,
            // controller: amountDiscoun,
            hintText: "DISCOUNT reason (character limit 40)".toUpperCase(),
            hintStyle: theme.textTheme.titleMedium
                ?.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
            style: theme.textTheme.titleMedium
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            borderRadius: 0,
            padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 22),
            inputFormatters: [
              LengthLimitingTextInputFormatter(40),
              // LengthLimitingTextInputFormatter(6),
              // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
            ],
          ),
        ),

        // btn row
        const SizedBox(height: 30),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryBtn(
                onPressed: () async {
                  PosController.to.applyDiscount(
                    num.parse(myDiscoun),
                    PosController.to.selectedItemList,
                    isPercentage: isPercentage,
                  );
                  Get.back();
                  // PopupDialog.showLoadingDialog();
                  await PosController.to.onUpdateOrder(
                      PosController.to.myOrder.id,
                      isClearList: false);
                  // PopupDialog.closeLoadingDialog();
                },
                text: "Ok".toUpperCase(),
                height: 70,
                width: 150,
                textMinSize: 26,
                textMaxSize: 44,
                fontWeight: FontWeight.w700,
                color: StaticColors.greenColor,
                textColor: Colors.white,
              ),
              const SizedBox(width: 30),
              PrimaryBtn(
                onPressed: () async {
                  PosController.to.applyDiscount(
                    num.parse("0"),
                    PosController.to.selectedItemList,
                    isPercentage: isPercentage,
                  );
                  Get.back();
                  await PosController.to.onUpdateOrder(
                      PosController.to.myOrder.id,
                      isClearList: false);
                },
                text: "Cancel Discount".toUpperCase(),
                height: 70,
                width: 150,
                textMinSize: 15,
                textMaxSize: 30,
                fontWeight: FontWeight.w700,
                color: StaticColors.greenColor,
                textColor: Colors.white,
              ),
              const SizedBox(width: 30),
              PrimaryBtn(
                onPressed: () async {
                  Get.back();
                },
                text: "Cancel".toUpperCase(),
                height: 70,
                width: 150,
                textMinSize: 26,
                textMaxSize: 44,
                fontWeight: FontWeight.w700,
                color: StaticColors.redColor,
                textColor: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _customKeybord(ThemeData theme) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 3,
      crossAxisSpacing: 3,
      children: List.generate(
          PosController.to.numberList.length,
          (index) => StaggeredGridTile.count(
                crossAxisCellCount:
                    PosController.to.numberList[index] == "X" ? 2 : 1,
                mainAxisCellCount: .8,
                child: SizedBox(
                  width: 85,
                  height: 85,
                  child: ElevatedButton(
                    onPressed: () {
                      if (PosController.to.numberList[index] == "X") {
                        removeDiscount();
                      } else {
                        addValueWithKeybord(
                            isKeybord: true,
                            PosController.to.numberList[index]);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // ****** style ******
                      textStyle: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 36),
                      backgroundColor: theme.canvasColor,
                      foregroundColor: theme.dividerColor,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      // ****** Border color *******
                      side: const BorderSide(
                        color: Color(0xffEBEBEB),
                        width: .5,
                      ),
                    ),
                    child: PosController.to.numberList[index] == "X"
                        ? const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.red,
                            size: 50,
                          )
                        : MyCustomText(
                            PosController.to.numberList[index],
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            fontSize: 33,
                          ),
                  ),
                ),
              )),
    );
  }
}
