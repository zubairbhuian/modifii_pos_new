class CategoryModel {
    CategoryModel({
        required this.id,
        required this.name,
        required this.parentId,
        required this.position,
        required this.status,
        required this.priority,
        required this.createdAt,
        required this.updatedAt,
        required this.image,
        required this.bannerImage,
        required this.type,
        required this.restaurants,
        required this.translations,
    });

    final int id;
    final String name;
    final int parentId;
    final int position;
    final int status;
    final int priority;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic image;
    final dynamic bannerImage;
    final String type;
    final dynamic restaurants;
    final List<dynamic> translations;

    factory CategoryModel.fromJson(Map<String, dynamic> json){ 
        return CategoryModel(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            parentId: json["parent_id"] ?? 0,
            position: json["position"] ?? 0,
            status: json["status"] ?? 0,
            priority: json["priority"] ?? 0,
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            image: json["image"],
            bannerImage: json["banner_image"],
            type: json["type"] ?? "",
            restaurants: json["restaurants"],
            translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
        );
    }

}