// class OrderPlaceModel {
//   OrderPlaceModel({
//     this.cart,
//     this.orderAmount,
//     this.tableId,
//     this.barId,
//     this.branchId,
//     this.serverId,
//     this.numberOfPeople,
//     this.paymentStatus,
//     this.paymentMethod,
//     this.gratuityAmount,
//     this.gstAmount,
//     this.pstAmount,
//     this.orderNote,
//   });

//   final List<Cart>? cart;
//   final num? orderAmount;
//   final int? tableId;
//   final int? barId;
//   final int? branchId;
//   final int? serverId;
//   final num? numberOfPeople;
//   final String? paymentStatus;
//   final String? paymentMethod;
//   final num? gratuityAmount;
//   final num? gstAmount;
//   final num? pstAmount;
//   final String? orderNote;

//   factory OrderPlaceModel.fromJson(Map<String, dynamic> json) {
//     return OrderPlaceModel(
//       cart: json["cart"] == null
//           ? []
//           : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
//       orderAmount: json["order_amount"],
//       tableId: json["table_id"],
//       barId: json["bar_id"],
//       branchId: json["branch_id"],
//       serverId: json["server_id"],
//       numberOfPeople: json["number_of_people"],
//       paymentStatus: json["payment_status"],
//       paymentMethod: json["payment_method"],
//       gratuityAmount: json["gratuity_amount"],
//       gstAmount: json["gst_amount"],
//       pstAmount: json["pst_amount"],
//       orderNote: json["order_note"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "cart": cart?.map((x) => x.toJson()).toList(),
//         "order_amount": orderAmount,
//         "table_id": tableId,
//         "bar_id": barId,
//         "branch_id": branchId,
//         "server_id": serverId,
//         "number_of_people": numberOfPeople,
//         "payment_status": paymentStatus,
//         "payment_method": paymentMethod,
//         "gratuity_amount": gratuityAmount,
//         "gst_amount": gstAmount,
//         "pst_amount": pstAmount,
//         "order_note": orderNote,
//       };
// }

class Cart {
  Cart({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    this.kitchenNote,
    this.serveFirst,
    this.togo,
    this.dontMake,
    this.rush,
    this.heat,
    this.variations,
    this.isLiquor,
  });

  final String id;
  final String? type;
  final String? name;
  final num price;
  final String? description;
  num quantity;
  String? kitchenNote;
  String? serveFirst;
  String? togo;
  String? dontMake;
  String? rush;
  String? heat;
  final List<dynamic>? variations;
  final int? isLiquor;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      price: json["price"],
      description: json["description"],
      quantity: json["quantity"],
      kitchenNote: json["kitchen_note"],
      serveFirst: json["serve_first"],
      togo: json["to_go"],
      dontMake: json["dont_make"],
      rush: json["rush"],
      heat: json["heat"],
      isLiquor: json["is_liquor"],
      variations: json["variations"] == null
          ? []
          : List<dynamic>.from(json["variations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "price": price,
        "description": description,
        "quantity": quantity,
        "kitchen_note": kitchenNote,
        "serve_first": serveFirst,
        "to_go": togo,
        "dont_make": dontMake,
        "rush": rush,
        "heat": heat,
        "is_liquor": isLiquor,
        // "variations": variations?.map((x) => x).toList(),
      };

  @override
  String toString() {
    return 'Cart(id: $id, type: $type, name: $name,price: $price, description: $description, quantity: $quantity, note: $kitchenNote, serveFirst: $serveFirst, togo: $togo, dontmake: $dontMake, rush: $rush, isLiquor: $isLiquor)';
  }
}
