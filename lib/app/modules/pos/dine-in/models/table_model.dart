class TableModel {
    TableModel({
        required this.id,
        required this.tableName,
        required this.tableAvailability,
        required this.tableCapacity,
    });

    final String id;
    final String tableName;
    final String tableAvailability;
    final int tableCapacity;

    factory TableModel.fromJson(Map<String, dynamic> json){ 
        return TableModel(
            id: json["id"] ?? "",
            tableName: json["tableName"] ?? "",
            tableAvailability: json["tableAvailability"] ?? "",
            tableCapacity: json["tableCapacity"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "tableName": tableName,
        "tableAvailability": tableAvailability,
        "tableCapacity": tableCapacity,
    };
}