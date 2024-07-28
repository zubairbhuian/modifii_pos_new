class SubCategoryModel {
  SubCategoryModel({
    required this.id,
    required this.title,
    required this.deleted,
    required this.status,
    required this.mainCategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final bool deleted;
  final String status;
  final String mainCategoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      deleted: json["deleted"] ?? false,
      status: json["status"] ?? "",
      mainCategoryId: json["mainCategoryId"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "deleted": deleted,
        "status": status,
        "mainCategoryId": mainCategoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

