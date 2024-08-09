// To parse this JSON data, do
//
//     final splitAmountModel = splitAmountModelFromJson(jsonString);

import 'dart:convert';

SplitAmountModel splitAmountModelFromJson(String str) =>
    SplitAmountModel.fromJson(json.decode(str));

String splitAmountModelToJson(SplitAmountModel data) =>
    json.encode(data.toJson());

class SplitAmountModel {
  List<SplitAmount> splitAmounts;

  SplitAmountModel({
    required this.splitAmounts,
  });

  factory SplitAmountModel.fromJson(Map<String, dynamic> json) =>
      SplitAmountModel(
        splitAmounts: List<SplitAmount>.from(
            json["splitAmounts"].map((x) => SplitAmount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "splitAmounts": List<dynamic>.from(splitAmounts.map((x) => x.toJson())),
      };
}

class SplitAmount {
  String guestName;
  num splitAmount;
  num tipAmount;
  String? paymentMethod;

  SplitAmount({
    required this.guestName,
    required this.splitAmount,
    required this.tipAmount,
    this.paymentMethod,
  });

  factory SplitAmount.fromJson(Map<String, dynamic> json) => SplitAmount(
        guestName: json["guestName"],
        splitAmount: json["splitAmount"],
        tipAmount: json["tipAmount"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() {
    final data = {
      "guestName": guestName,
      "splitAmount": splitAmount,
      "tipAmount": tipAmount,
    };
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod ?? '';
    }
    return data;
  }
}
