import 'dart:ui';

class MainCategoryModel {
  MainCategoryModel({
    required this.id,
    required this.title,
    required this.status,
    required this.background,
    required this.foreground,
    required this.subCategory,
    required this.count,
  });

  final String id;
  final String title;
  final String status;
  final Color background;
  final Color foreground;
  final List<SubCategory> subCategory;
  final Count? count;

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) {
    return MainCategoryModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      status: json["status"] ?? "",
      background: _colorFromHex(json['background']),
      foreground: _colorFromHex(json['foreground']),
      subCategory: json["subCategory"] == null
          ? []
          : List<SubCategory>.from(
              json["subCategory"]!.map((x) => SubCategory.fromJson(x))),
      count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        'background': _colorToHex(background),
        'foreground': _colorToHex(foreground),
        "subCategory": subCategory.map((x) => x.toJson()).toList(),
        "_count": count?.toJson(),
      };
  static Color _colorFromHex(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add alpha if not provided
    }
    return Color(int.parse(hex, radix: 16));
  }

  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}

class Count {
  Count({
    required this.subCategory,
  });

  final int? subCategory;

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      subCategory: json["subCategory"],
    );
  }

  Map<String, dynamic> toJson() => {
        "subCategory": subCategory,
      };
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
    required this.status,
  });

  final String id;
  final String title;
  final String status;

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json["id"],
      title: json["title"] ?? '',
      status: json["status"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
      };
}
