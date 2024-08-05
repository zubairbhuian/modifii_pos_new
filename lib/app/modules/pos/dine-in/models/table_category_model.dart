import 'package:flutter_base/app/modules/pos/dine-in/models/table_model.dart';

class TableCategoryModel {
  TableCategoryModel({
    required this.id,
    required this.name,
    required this.tableCategoryType,
    required this.tables,
  });

  final String id;
  final String name;
  final String tableCategoryType;
  final List<TableModel> tables;

  factory TableCategoryModel.fromJson(Map<String, dynamic> json) {
    return TableCategoryModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      tableCategoryType: json["tableCategoryType"] ?? "",
      tables: json["tables"] == null
          ? []
          : List<TableModel>.from(
              json["tables"]!.map((x) => TableModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tableCategoryType": tableCategoryType,
        "tables": tables.map((x) => x.toJson()).toList(),
      };
}


