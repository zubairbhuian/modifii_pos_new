// To parse this JSON data, do
//
//     final table = tableFromJson(jsonString);

import 'dart:convert';

TableModel tableFromJson(String str) => TableModel.fromJson(json.decode(str));

String tableToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  int? id;
  int? number;
  int? capacity;
  int? branchId;
  int? isActive;
  int? status;
  String? reservationType;
  int? position;
  int? combined;

  TableModel({
    this.id,
    this.number,
    this.capacity,
    this.branchId,
    this.isActive,
    this.status,
    this.reservationType,
    this.position,
    this.combined,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        number: json["number"],
        capacity: json["capacity"],
        branchId: json["branch_id"],
        isActive: json["is_active"],
        status: json["status"],
        reservationType: json["reservation_type"],
        position: json["position"],
        combined: json["combined"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "capacity": capacity,
        "branch_id": branchId,
        "is_active": isActive,
        "status": status,
        "reservation_type": reservationType,
        "position": position,
        "combined": combined,
      };
}
