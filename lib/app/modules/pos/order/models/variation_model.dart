import 'package:flutter_base/app/modules/pos/order/models/option_model.dart';

class VariationModel {
  VariationModel({
    required this.id,
    required this.name,
    required this.selcetionType,
    required this.max,
    required this.min,
    required this.required,
    required this.options,
  });

  final String id;
  final String name;
  final String selcetionType;
  final num max;
  final num min;
  final bool required;
  final List<OptionModel> options;

  factory VariationModel.fromJson(Map<String, dynamic> json) {
    return VariationModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      selcetionType: json["selcetionType"] ?? "",
      max: json["max"] ?? 0,
      min: json["min"] ?? 0,
      required: json["required"] ?? false,
      options: json["options"] == null
          ? []
          : List<OptionModel>.from(json["options"]!.map((x) => OptionModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "selcetionType": selcetionType,
        "max": max,
        "min": min,
        "required": required,
        "options": options.map((x) => x.toJson()).toList(),
      };
}