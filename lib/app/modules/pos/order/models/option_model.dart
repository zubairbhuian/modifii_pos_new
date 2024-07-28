class OptionModel {
  OptionModel({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final num price;

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
