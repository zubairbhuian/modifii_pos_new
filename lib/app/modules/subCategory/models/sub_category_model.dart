class SubCategoryModel {
    SubCategoryModel({
        required this.id,
        required this.title,
        required this.type,
        required this.count,
        required this.status,
    });

    final String id;
    final String title;
    final String type;
    final Count? count;
    final String status;

    factory SubCategoryModel.fromJson(Map<String, dynamic> json){ 
        return SubCategoryModel(
            id: json["id"] ?? "",
            title: json["title"] ?? "",
            type: json["type"] ?? "",
            count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
            status: json["status"] ?? "",
        );
    }

    @override
    String toString(){
        return "$id, $title, $type, $count, $status, ";
    }
}

class Count {
    Count({
        required this.products,
    });

    final int products;

    factory Count.fromJson(Map<String, dynamic> json){ 
        return Count(
            products: json["products"] ?? 0,
        );
    }

    @override
    String toString(){
        return "$products, ";
    }
}