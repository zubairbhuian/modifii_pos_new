class OrderStatusModel {
    OrderStatusModel({
        required this.status,
        required this.count,
    });

    final String status;
    final int count;

    factory OrderStatusModel.fromJson(Map<String, dynamic> json){ 
        return OrderStatusModel(
            status: json["status"] ?? "",
            count: json["count"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
    };

}
