import 'dart:async';
import 'package:flutter_base/app/services/base/preferences.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ClockInController extends GetxController {
  static ClockInController get to => Get.find();

  Timer? timer;
  RxInt secondsElapsed = 0.obs;

  void clockIn() async {
    PopupDialog.showLoadingDialog();
    var res =
        await BaseController.to.apiService.makePostRequest(URLS.clockIn, {});
    PopupDialog.closeLoadingDialog();
    if (res.statusCode == 201) {
      if (timer != null && timer!.isActive) return;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        secondsElapsed.value++;
      });
      Preferences.clockInId = res.data["data"]["id"];
      Get.offAllNamed(Routes.ENTRY_POINT);
    } else if (res.statusCode == 406) {
      PopupDialog.showErrorMessage(res.data["message"]);
    }
  }

  clockOut({bool isLogOut = false}) async {
    String id = Preferences.clockInId;
    PopupDialog.showLoadingDialog();
    var res = await BaseController.to.apiService
        .makePostRequest(URLS.clockOut, {"clockId": id});
    PopupDialog.closeLoadingDialog();
    if (res.statusCode == 200) {
      timer?.cancel();
      secondsElapsed.value = 0;
      if (isLogOut) {
        Get.offAllNamed(Routes.CLOCK_IN);
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    }
  }

  List<String> showClockInTimer() {
    final hours = (secondsElapsed ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((secondsElapsed % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (secondsElapsed % 60).toString().padLeft(2, '0');
    // return "$hours:$minutes:$secs";
    return [hours, minutes, secs];
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
