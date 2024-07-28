class MetaModel {
    MetaModel({
        required this.total,
        required this.limit,
        required this.currentPage,
        required this.totalPages,
        required this.hasNextPage,
        required this.hasPreviousPage,
    });

    final int total;
    final int limit;
    final int currentPage;
    final int totalPages;
    final bool hasNextPage;
    final bool hasPreviousPage;

    factory MetaModel.fromJson(Map<String, dynamic> json){ 
        return MetaModel(
            total: json["total"] ?? 0,
            limit: json["limit"] ?? 0,
            currentPage: json["currentPage"] ?? 0,
            totalPages: json["totalPages"] ?? 0,
            hasNextPage: json["hasNextPage"] ?? false,
            hasPreviousPage: json["hasPreviousPage"] ?? false,
        );
    }

}