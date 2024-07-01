import 'package:flutter/widgets.dart';
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
      width: 300,
      backgroundColor: Theme.of(Get.context!).primaryColorLight,
      content: Center(child: MyCustomText(message)),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  // error messase
  static void showErrorMessage(String message) {
    // ThemeData theme = Theme.of(Get.context!);
    var snackBar = SnackBar(
      width: 300,
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
                width: 80,
                height: 80,
                child: Material(
                  elevation: 2,
                  // dialog color
                  shadowColor: Colors.black12,
                  // backgraund color
                  color: Colors.transparent,
                  // border radius
                  borderRadius: BorderRadius.circular(8),
                  // main body
                  /// DoubleBounce
                  /// SpinningLines
                  child: SpinKitSpinningLines(
                    color: theme.primaryColor,
                    size: 43, // You can customize the size
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static customDialog({required Widget child, double? width}) {
    return showDialog<void>(
      // Context
      context: Get.context!,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: width ?? MediaQuery.sizeOf(context).width * 0.5,
            child: Material(
              elevation: 2,
              // dialog color
              shadowColor: Colors.black12,
              // backgraund color
              color: Theme.of(context).scaffoldBackgroundColor,
              // border radius
              borderRadius: BorderRadius.circular(6),

              // main body
              /// DoubleBounce
              /// SpinningLines
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, right: 4),
                      child: InkWell(
                        onTap: Get.back,
                        splashFactory: NoSplash.splashFactory,
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.background,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
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
