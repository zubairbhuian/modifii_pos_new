import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/entryPoint/widgets/my_time.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';
import '../controllers/entry_point_controller.dart';

class EntryPointView extends GetView<EntryPointController> {
  const EntryPointView({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
        preferredHeight: 110,
        isLeading: false,
        hasButtonsRow: false,
      ),
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            width: 1100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dine-in
                _dineInBTN(theme),
                const SizedBox(width: 60),
                // Take Out
                _takeOutBTN(theme),
                const SizedBox(width: 60),
                // Delivery
                _deliveryBTN(theme)
              ],
            ),
          )),
          _bottomSheet(theme)
        ],
      ),
    );
  }

  // ***** Dine-in
  Widget _dineInBTN(ThemeData theme) {
    return Expanded(
      child: PrimaryBtn(
        onPressed: () {
          Get.toNamed(Routes.POS);
        },
        height: 220,
        style: theme.textTheme.displayLarge?.copyWith(color: Colors.white),
        textMaxSize: 46,
        text: 'Dine-in',
      ),
    );
  }

  // ***** Take Out
  Widget _takeOutBTN(ThemeData theme) {
    return Expanded(
      child: PrimaryBtn(
        onPressed: () {
          Get.toNamed(Routes.POS);
        },
        height: 220,
        style: theme.textTheme.displayLarge?.copyWith(color: Colors.white),
        color: const Color(0xff008F5F),
        textMaxSize: 46,
        text: 'Take Out',
      ),
    );
  }

  // ***** Delivery
  Widget _deliveryBTN(ThemeData theme) {
    return Expanded(
      child: PrimaryBtn(
        onPressed: () {
          Get.toNamed(Routes.POS);
        },
        height: 220,
        style: theme.textTheme.displayLarge?.copyWith(color: Colors.white),
        color: const Color(0xffFBB052),
        textMaxSize: 46,
        text: 'Delivery',
      ),
    );
  }

  // **** bottom sheet
  Widget _bottomSheet(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
          // color: Colors.red
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Station: 2",
                    style: theme.textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "User: modifii",
                    style: theme.textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ],
            ),
          ),
          const Expanded(
            flex: 5,
            child: MyTime(),
          )
        ],
      ),
    );
  }
}
