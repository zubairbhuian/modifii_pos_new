import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';

class TopMenu extends GetView<PosController> {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const double width = 110;
    const double height = 70;
    const double txtMaxSize = 23;
    const double txtMinSize = 14;
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          GetBuilder<PosController>(builder: (context) {
            return Visibility(
              visible: context.pageController.page == 0 ? false : true,
              child: PrimaryBtn(
                width: width,
                height: height,
                onPressed: () {
                  PosController.to.onchangePage(0);
                },
                color: StaticColors.greenColor,
                textColor: Colors.white,
                text: 'pos'.toUpperCase(),
                textMaxSize: txtMaxSize,
                textMinSize: txtMinSize,
              ),
            );
          }),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: width,
            height: height,
            onPressed: () {
              PosController.to.onchangePage(1);
            },
            color: StaticColors.yellowColor,
            textColor: Colors.white,
            text: 'ORDERS',
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: width,
            height: height,
            onPressed: () {
              PosController.to.onchangePage(3);
            },
            padding: EdgeInsets.zero,
            color: StaticColors.greenColor,
            textColor: Colors.white,
            text: 'Dine-in/\nTAKEOUT'.toUpperCase(),
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          const Spacer(),
          //! right hand side
          PrimaryBtn(
            width: width,
            height: height,
            onPressed: () {},
            color: StaticColors.blueColor,
            textColor: Colors.white,
            text: 'Summary'.toUpperCase(),
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
          const SizedBox(width: 10),
          PrimaryBtn(
            width: width,
            height: height,
            onPressed: () {
              // controller.getCategory(type: 'drinks');
            },
            // isdisabled: true,
            color: StaticColors.greenColor,
            textColor: Colors.white,
            text: 'Cash Out'.toUpperCase(),
            textMaxSize: txtMaxSize,
            textMinSize: txtMinSize,
          ),
        ],
      ),
    );
  }
}
