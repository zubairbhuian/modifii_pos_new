class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.variations,
  });

  final String id;
  final String name;
  final String description;
  final num price;
  final List<Variation> variations;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"]??"",
      price: json["price"] ?? 0,
      variations: json["variations"] == null
          ? []
          : List<Variation>.from(
              json["variations"]!.map((x) => Variation.fromJson(x))),
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $price, $variations, ";
  }
}

class Variation {
  Variation({
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
  final int max;
  final int min;
  final bool required;
  final List<Option> options;

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      selcetionType: json["selcetionType"] ?? "",
      max: json["max"] ?? 0,
      min: json["min"] ?? 0,
      required: json["required"] ?? false,
      options: json["options"] == null
          ? []
          : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );
  }

  @override
  String toString() {
    return "$id, $name, $selcetionType, $max, $min, $required, $options, ";
  }
}

class Option {
  Option({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final num price;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
    );
  }

  @override
  String toString() {
    return "$id, $name, $price, ";
  }
}
