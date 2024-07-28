class OrderModel {
  OrderModel({
    List<CartModel>? carts,
    this.userName = "",
    this.orderType = "",
    this.orderStatus = "",
    this.totalOrderAmount = 0,
    this.subTotal = 0,
    this.tableId = "",
    this.employeeId = "",
    this.numberOfPeople = 1,
    this.paymentStatus = "",
    this.paymentMethod = "",
    this.totalGratuity = 0,
    this.totalGst = 0,
    this.totalPst = 0,
    this.totalDiscount = 0,
    this.addOn = 0,
    this.createdAt,
    this.employee,
    this.table,
    this.id = "",
    this.orderNote = "",
  }) : carts = carts ?? [];

  List<CartModel> carts;
  String userName;
  String orderType;
  String orderStatus;
  num totalOrderAmount;
  num subTotal;
  String tableId;
  String employeeId;
  int numberOfPeople;
  String paymentStatus;
  String paymentMethod;
  num totalGratuity;
  num totalGst;
  num totalPst;
  num totalDiscount;
  num addOn;
  String orderNote;
  final String id;
  final Table? table;
  final Employee? employee;
  final DateTime? createdAt;
  

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      carts: json["carts"] == null
          ? []
          : List<CartModel>.from(
              json["carts"]!.map((x) => CartModel.fromJson(x))),
      userName: json["userName"] ?? "",
      orderType: json["orderType"] ?? "",
      orderStatus: json["orderStatus"] ?? "",
      totalOrderAmount: json["totalOrderAmount"] ?? 0,
      tableId: json["tableId"] ?? "",
      employeeId: json["employeeId"] ?? "",
      numberOfPeople: json["numberOfPeople"] ?? 0,
      paymentStatus: json["paymentStatus"] ?? "",
      paymentMethod: json["paymentMethod"] ?? "",
      totalGratuity: json["totalGratuity"] ?? 0,
      totalGst: json["totalGst"] ?? 0,
      totalPst: json["totalPst"] ?? 0,
      totalDiscount: json["totalDiscount"] ?? 0,
      addOn: json["addOn"] ?? 0,
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      orderNote: json["orderNote"] ?? "",
      table: json["table"] == null ? null : Table.fromJson(json["table"]),
      employee:
          json["employee"] == null ? null : Employee.fromJson(json["employee"]),
      
    );
  }

  Map<String, dynamic> toJson() => {
        "carts": carts.map((x) => x.toJson()).toList(),
        "userName": userName,
        "orderType": orderType,
        "orderStatus": orderStatus,
        "totalOrderAmount": totalOrderAmount,
        "tableId": tableId,
        "employeeId": employeeId,
        "numberOfPeople": numberOfPeople,
        "paymentStatus": paymentStatus,
        "paymentMethod": paymentMethod,
        "totalGratuity": totalGratuity,
        "totalGst": totalGst,
        "totalPst": totalPst,
        "totalDiscount": totalDiscount,
        "addOn": addOn,
        "orderNote": orderNote,
      };
}

class CartModel {
  CartModel({
    required this.name,
    required this.price,
    required this.quantity,
    this.kitchenNote = "",
    this.toGo = "",
    this.serveFirst = "",
    this.dontMake = "",
    this.rush = "",
    this.discountAmount = 0,
    this.pstAmount = 0,
    this.heat = "",
    this.description = "",
    this.isLiquor = false,
    this.isCustomProduct = false,
  });

  String name;
  num price;
  int quantity;
  String kitchenNote;
  String toGo;
  String serveFirst;
  String dontMake;
  String rush;
  num discountAmount;
  num pstAmount;
  String heat;
  String description;
  bool isLiquor;
  bool isCustomProduct;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
      quantity: json["quantity"] ?? 0,
      kitchenNote: json["kitchenNote"] ?? "",
      toGo: json["toGo"] ?? "",
      serveFirst: json["serveFirst"] ?? "",
      dontMake: json["dontMake"] ?? "",
      rush: json["rush"] ?? "",
      discountAmount: json["discountAmount"] ?? 0,
      pstAmount: json["pstAmount"] ?? 0,
      heat: json["heat"] ?? "",
      description: json["description"] ?? "",
      isLiquor: json["isLiquor"] ?? false,
      isCustomProduct: json["isCustomProduct"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "kitchenNote": kitchenNote,
        "toGo": toGo,
        "serveFirst": serveFirst,
        "dontMake": dontMake,
        "rush": rush,
        "discountAmount": discountAmount,
        "pstAmount": pstAmount,
        "heat": heat,
        "description": description,
        "isLiquor": isLiquor,
        "isCustomProduct": isCustomProduct,
      };
}

class Employee {
  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String id;
  final String firstName;
  final String lastName;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json["id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class Table {
  Table({
    required this.id,
    required this.tableName,
  });

  final String id;
  final String tableName;

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json["id"] ?? "",
      tableName: json["tableName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "tableName": tableName,
      };
}


