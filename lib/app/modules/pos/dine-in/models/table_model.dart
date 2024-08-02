import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';

class TableModel {
  TableModel(
      {required this.id,
      required this.tableName,
      required this.tableAvailability,
      required this.tableCapacity,
      this.currentOrderId,
      this.employee});

  final String id;
  final String tableName;
  final String tableAvailability;
  final int tableCapacity;
  final String? currentOrderId;
  final Employee? employee;
  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json["id"] ?? "",
      tableName: json["tableName"] ?? "",
      tableAvailability: json["tableAvailability"] ?? "",
      tableCapacity: json["tableCapacity"] ?? 0,
      currentOrderId: json["currentOrderId"],
      employee:
          json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "tableName": tableName,
        "tableAvailability": tableAvailability,
        "tableCapacity": tableCapacity,
        "currentOrderId": currentOrderId,
        "employee": employee,
      };
}
