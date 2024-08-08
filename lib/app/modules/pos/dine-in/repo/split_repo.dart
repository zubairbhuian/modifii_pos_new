import 'package:flutter_base/app/modules/pos/dine-in/models/split_amount_model.dart';
import 'package:flutter_base/app/utils/urls.dart';
import '../../../../services/base/base_model.dart';
import '../../../../services/controller/base_controller.dart';

class SplitRepo {
  SplitRepo._();

  static Future<bool> splitAmount({
    required String orderId,
    required SplitAmountModel splitAmount,
  }) async {
    try {
      final BaseModel res = await BaseController.to.apiService.makePatchRequest(
        URLS.splitAmount(orderId),
        splitAmount.toJson(),
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        // showCustomSnackbar(message: res.data['message']);
        return false;
      }
    } catch (e) {
      // showCustomSnackbar(message: e.toString());
      return false;
    }
  }
}
