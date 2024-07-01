class SubCategoryModel {
  SubCategoryModel({
    required this.id,
    required this.title,
    required this.type,
  });

  final String id;
  final String title;
  final String type;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      type: json["type"] ?? "",
    );
  }

  @override
  String toString() {
    return "$id, $title, $type, ";
  }
}
