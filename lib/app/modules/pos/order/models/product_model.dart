import 'package:flutter_base/app/modules/pos/order/models/sub_category_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/variation_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.status,
    required this.subCategory,
    required this.branchId,
    required this.variations,
  });

  final String id;
  final String name;
  final String description;
  final num price;
  final String status;
  final SubCategoryModel subCategory;
  final dynamic branchId;
  final List<VariationModel> variations;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] ?? 0,
      status: json["status"] ?? "",
      subCategory: SubCategoryModel.fromJson(json["subCategory"]),
      branchId: json["branchId"],
      variations: json["variations"] == null
          ? []
          : List<VariationModel>.from(
              json["variations"]!.map((x) => VariationModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "status": status,
        // "subCategory": SubCategoryModel.toJson(),
        "branchId": branchId,
        "variations": variations.map((x) => x.toJson()).toList(),
      };
}
