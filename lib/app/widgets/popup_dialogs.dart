import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupDialog {
  // SuccessDialog
  static void showSuccessDialog(String message) {
    // ThemeData theme = Theme.of(Get.context!);
    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      width: 500,
      backgroundColor: StaticColors.greenColor,
      content: Center(child: MyCustomText(message, color: Colors.white)),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  // error messase
  static void showErrorMessage(String message) {
    // ThemeData theme = Theme.of(Get.context!);
    var snackBar = SnackBar(
      width: 500,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      backgroundColor: Colors.redAccent,
      content: Center(child: MyCustomText(message, color: Colors.white)),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
  // Loading Dialog

  static showLoadingDialog() {
    ThemeData theme = Theme.of(Get.context!);
    return showDialog<void>(
      // Context
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          // for horizontal minHeight
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // for ertical minWidth
            Center(
              child: SizedBox(
                // dialog width
                width: 120,
                height: 120,
                child: Material(
                  elevation: 2,
                  // dialog color
                  shadowColor: Colors.transparent,
                  // backgraund color
                  color: Colors.transparent,
                  // border radius
                  borderRadius: BorderRadius.circular(8),
                  // main body
                  /// DoubleBounce
                  /// SpinningLines
                  child: SpinKitRing(
                    color: theme.primaryColor,
                    size: 53, // You can customize the size
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static customDialog({required Widget child, double? width, double? height}) {
    return showDialog<void>(
      // Context
      context: Get.context!,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        ThemeData theme = Theme.of(context);
        return Center(
          child: SizedBox(
            height: height,
            width: width ?? MediaQuery.sizeOf(context).width * 0.7,
            child: Material(
              elevation: 3,
              // dialog color
              shadowColor: ConfigController.to.isLightTheme
                  ? Colors.black12
                  : Colors.white,
              // backgraund color
              color: theme.cardColor,
              // border radius
              borderRadius: BorderRadius.circular(6),

              /// SpinningLines
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: Get.back,
                      splashFactory: NoSplash.splashFactory,
                      child: Padding(
                        // padding: const EdgeInsets.only(
                        //     left: 8, right: 8, top: 8, bottom: 2),
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.background,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 26, bottom: 20),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // close dialog
  static void closeLoadingDialog() {
    Get.back();
  }
}
