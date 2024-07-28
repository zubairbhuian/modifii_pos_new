// To parse this JSON data, do
//
//     final dineinOrderModel = dineinOrderModelFromJson(jsonString);

import 'dart:convert';

DineInOrderModel dineinOrderModelFromJson(String str) =>
    DineInOrderModel.fromJson(json.decode(str));

String dineinOrderModelToJson(DineInOrderModel data) =>
    json.encode(data.toJson());

class DineInOrderModel {
  Orders? orders;

  DineInOrderModel({this.orders});

  factory DineInOrderModel.fromJson(Map<String, dynamic> json) =>
      DineInOrderModel(
        orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders?.toJson(),
      };
}

class Orders {
  int? currentPage;
  List<OrderData>? orderData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Orders({
    this.currentPage,
    this.orderData,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        currentPage: json["current_page"],
        orderData: json["data"] == null
            ? []
            : List<OrderData>.from(
                json["data"]!.map((x) => OrderData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": orderData == null
            ? []
            : List<dynamic>.from(orderData!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class OrderData {
  int? id;
  int? adminId;
  dynamic userId;
  int? serverId;
  int? isGuest;
  num? orderAmount;
  num? gratuityAmount;
  num? pstAmount;
  int? couponDiscountAmount;
  dynamic couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  num? totalTaxAmount;
  String? paymentMethod;
  dynamic transactionReference;
  dynamic deliveryAddressId;
  int? checked;
  dynamic deliveryManId;
  int? deliveryCharge;
  dynamic orderNote;
  dynamic couponCode;
  String? orderType;
  int? branchId;
  dynamic callback;
  String? deliveryDate;
  String? deliveryTime;
  String? extraDiscount;
  dynamic extraDiscountType;
  int? extraDiscountDiscount;
  dynamic extraDiscountReason;
  dynamic deliveryAddress;
  int? preparationTime;
  int? tableId;
  int? numberOfPeople;
  int? tableOrderId;
  dynamic refundOrderId;
  dynamic voidOrderId;
  dynamic refundReason;
  int? totalRefundAmount;
  String? authorizationCode;
  int? recieveCash;
  int? changeCashAmount;
  dynamic deliveryDistance;
  int? addonSubTotal;
  num? addonGst;
  num? addonPst;
  num? addonGratuity;
  num? addonTotal;
  num? tipAmount;
  int? parentOrderId;
  dynamic clearedAt;
  dynamic bookingType;
  dynamic customerName;
  dynamic barId;
  dynamic deletedAt;
  dynamic serveFirst;
  int? packagingCharge;
  String? extraPaymentMethod;
  num? cashTip;
  String? serverName;
  Server? server;
  dynamic admin;
  List<OrderProductDetailsModel>? details;

  OrderData({
    this.id,
    this.adminId,
    this.userId,
    this.serverId,
    this.isGuest,
    this.orderAmount,
    this.gratuityAmount,
    this.pstAmount,
    this.couponDiscountAmount,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.transactionReference,
    this.deliveryAddressId,
    this.checked,
    this.deliveryManId,
    this.deliveryCharge,
    this.orderNote,
    this.couponCode,
    this.orderType,
    this.branchId,
    this.callback,
    this.deliveryDate,
    this.deliveryTime,
    this.extraDiscount,
    this.extraDiscountType,
    this.extraDiscountDiscount,
    this.extraDiscountReason,
    this.deliveryAddress,
    this.preparationTime,
    this.tableId,
    this.numberOfPeople,
    this.tableOrderId,
    this.refundOrderId,
    this.voidOrderId,
    this.refundReason,
    this.totalRefundAmount,
    this.authorizationCode,
    this.recieveCash,
    this.changeCashAmount,
    this.deliveryDistance,
    this.addonSubTotal,
    this.addonGst,
    this.addonPst,
    this.addonGratuity,
    this.addonTotal,
    this.tipAmount,
    this.parentOrderId,
    this.clearedAt,
    this.bookingType,
    this.customerName,
    this.barId,
    this.deletedAt,
    this.serveFirst,
    this.packagingCharge,
    this.extraPaymentMethod,
    this.cashTip,
    this.serverName,
    this.server,
    this.admin,
    this.details,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        adminId: json["admin_id"],
        userId: json["user_id"],
        serverId: json["server_id"],
        isGuest: json["is_guest"],
        orderAmount: json["order_amount"],
        gratuityAmount: json["gratuity_amount"],
        pstAmount: json["pst_amount"],
        couponDiscountAmount: json["coupon_discount_amount"],
        couponDiscountTitle: json["coupon_discount_title"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        totalTaxAmount: json["total_tax_amount"],
        paymentMethod: json["payment_method"],
        transactionReference: json["transaction_reference"],
        deliveryAddressId: json["delivery_address_id"],
        checked: json["checked"],
        deliveryManId: json["delivery_man_id"],
        deliveryCharge: json["delivery_charge"],
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        orderType: json["order_type"],
        branchId: json["branch_id"],
        callback: json["callback"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        extraDiscount: json["extra_discount"],
        extraDiscountType: json["extra_discount_type"],
        extraDiscountDiscount: json["extra_discount_discount"],
        extraDiscountReason: json["extra_discount_reason"],
        deliveryAddress: json["delivery_address"],
        preparationTime: json["preparation_time"],
        tableId: json["table_id"],
        numberOfPeople: json["number_of_people"],
        tableOrderId: json["table_order_id"],
        refundOrderId: json["refund_order_id"],
        voidOrderId: json["void_order_id"],
        refundReason: json["refund_reason"],
        totalRefundAmount: json["total_refund_amount"],
        authorizationCode: json["authorization_code"],
        recieveCash: json["recieve_cash"],
        changeCashAmount: json["change_cash_amount"],
        deliveryDistance: json["delivery_distance"],
        addonSubTotal: json["addon_sub_total"],
        addonGst: json["addon_gst"],
        addonPst: json["addon_pst"],
        addonGratuity: json["addon_gratuity"],
        addonTotal: json["addon_total"],
        tipAmount: json["tip_amount"],
        parentOrderId: json["parent_order_id"],
        clearedAt: json["cleared_at"],
        bookingType: json["booking_type"],
        customerName: json["customer_name"],
        barId: json["bar_id"],
        deletedAt: json["deleted_at"],
        serveFirst: json["serve_first"],
        packagingCharge: json["packaging_charge"],
        extraPaymentMethod: json["extra_payment_method"],
        cashTip: json["cash_tip"],
        serverName: json["server_name"],
        server: json["server"] == null ? null : Server.fromJson(json["server"]),
        admin: json["admin"],
        // details: OrderProductDetailsModel.fromJson(json["product_details"]),
        // details: (json['details'] as List)
        //     .map((item) => OrderProductDetailsModel.fromJson(item))
        //     .toList(),
        details: json["details"] == null
            ? []
            : List<OrderProductDetailsModel>.from(json["details"]!
                .map((x) => OrderProductDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "user_id": userId,
        "server_id": serverId,
        "is_guest": isGuest,
        "order_amount": orderAmount,
        "gratuity_amount": gratuityAmount,
        "pst_amount": pstAmount,
        "coupon_discount_amount": couponDiscountAmount,
        "coupon_discount_title": couponDiscountTitle,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "total_tax_amount": totalTaxAmount,
        "payment_method": paymentMethod,
        "transaction_reference": transactionReference,
        "delivery_address_id": deliveryAddressId,
        "checked": checked,
        "delivery_man_id": deliveryManId,
        "delivery_charge": deliveryCharge,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "order_type": orderType,
        "branch_id": branchId,
        "callback": callback,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "extra_discount": extraDiscount,
        "extra_discount_type": extraDiscountType,
        "extra_discount_discount": extraDiscountDiscount,
        "extra_discount_reason": extraDiscountReason,
        "delivery_address": deliveryAddress,
        "preparation_time": preparationTime,
        "table_id": tableId,
        "number_of_people": numberOfPeople,
        "table_order_id": tableOrderId,
        "refund_order_id": refundOrderId,
        "void_order_id": voidOrderId,
        "refund_reason": refundReason,
        "total_refund_amount": totalRefundAmount,
        "authorization_code": authorizationCode,
        "recieve_cash": recieveCash,
        "change_cash_amount": changeCashAmount,
        "delivery_distance": deliveryDistance,
        "addon_sub_total": addonSubTotal,
        "addon_gst": addonGst,
        "addon_pst": addonPst,
        "addon_gratuity": addonGratuity,
        "addon_total": addonTotal,
        "tip_amount": tipAmount,
        "parent_order_id": parentOrderId,
        "cleared_at": clearedAt,
        "booking_type": bookingType,
        "customer_name": customerName,
        "bar_id": barId,
        "deleted_at": deletedAt,
        "serve_first": serveFirst,
        "packaging_charge": packagingCharge,
        "extra_payment_method": extraPaymentMethod,
        "cash_tip": cashTip,
        "server_name": serverName,
        "server": server?.toJson(),
        "admin": admin,
        "details": details,
      };
}

class Server {
  num? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  String? password;
  String? rememberToken;
  num? adminRoleId;
  num? status;
  String? identityNumber;
  String? identityType;
  String? identityImage;
  String? authenticationPin;
  dynamic accessPin;
  String? adminName;
  String? workTime;

  Server({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.password,
    this.rememberToken,
    this.adminRoleId,
    this.status,
    this.identityNumber,
    this.identityType,
    this.identityImage,
    this.authenticationPin,
    this.accessPin,
    this.adminName,
    this.workTime,
  });

  factory Server.fromJson(Map<String, dynamic> json) => Server(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        password: json["password"],
        rememberToken: json["remember_token"],
        adminRoleId: json["admin_role_id"],
        status: json["status"],
        identityNumber: json["identity_number"],
        identityType: json["identity_type"],
        identityImage: json["identity_image"],
        authenticationPin: json["authentication_pin"],
        accessPin: json["access_pin"],
        adminName: json["admin_name"],
        workTime: json["work_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "image": image,
        "password": password,
        "remember_token": rememberToken,
        "admin_role_id": adminRoleId,
        "status": status,
        "identity_number": identityNumber,
        "identity_type": identityType,
        "identity_image": identityImage,
        "authentication_pin": authenticationPin,
        "access_pin": accessPin,
        "admin_name": adminName,
        "work_time": workTime,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

OrderProductDetailsModel orderProductDetailsModelFromJson(String str) =>
    OrderProductDetailsModel.fromJson(json.decode(str));

String orderProductDetailsModelToJson(OrderProductDetailsModel data) =>
    json.encode(data.toJson());

class OrderProductDetailsModel {
  final int? id;
  final int? productId;
  final int? orderId;
  final double? price;
  final ProductDetailsModel? productDetails;
  final String? variation;
  final int? discountOnProduct;
  final String? discountType;
  final int? quantity;
  final double? taxAmount;
  final dynamic addOnIds;
  final dynamic variant;
  final dynamic addOnQtys;
  final String? addOnTaxes;
  final String? addOnPrices;
  final int? addOnTaxAmount;
  final dynamic orderStatus;
  final String? productType;
  final dynamic kitchenNote;
  final int? isAddon;
  final int? printStatus;
  final dynamic heat;
  final dynamic toGo;
  final dynamic dontMake;
  final dynamic modifier;
  final dynamic rush;
  final int? isLiquor;
  final dynamic deletedAt;
  final dynamic serveFirst;

  OrderProductDetailsModel({
    this.id,
    this.productId,
    this.orderId,
    this.price,
    this.productDetails,
    this.variation,
    this.discountOnProduct,
    this.discountType,
    this.quantity,
    this.taxAmount,
    this.addOnIds,
    this.variant,
    this.addOnQtys,
    this.addOnTaxes,
    this.addOnPrices,
    this.addOnTaxAmount,
    this.orderStatus,
    this.productType,
    this.kitchenNote,
    this.isAddon,
    this.printStatus,
    this.heat,
    this.toGo,
    this.dontMake,
    this.modifier,
    this.rush,
    this.isLiquor,
    this.deletedAt,
    this.serveFirst,
  });

  factory OrderProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderProductDetailsModel(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        price: json["price"]?.toDouble(),
        productDetails:
            ProductDetailsModel.fromJson(jsonDecode(json['product_details'])),
        variation: json["variation"],
        discountOnProduct: json["discount_on_product"],
        discountType: json["discount_type"],
        quantity: json["quantity"],
        taxAmount: json["tax_amount"]?.toDouble(),
        addOnIds: json["add_on_ids"],
        variant: json["variant"],
        addOnQtys: json["add_on_qtys"],
        addOnTaxes: json["add_on_taxes"],
        addOnPrices: json["add_on_prices"],
        addOnTaxAmount: json["add_on_tax_amount"],
        orderStatus: json["order_status"],
        productType: json["product_type"],
        kitchenNote: json["kitchen_note"],
        isAddon: json["is_addon"],
        printStatus: json["print_status"],
        heat: json["heat"],
        toGo: json["to_go"],
        dontMake: json["dont_make"],
        modifier: json["modifier"],
        rush: json["rush"],
        isLiquor: json["is_liquor"],
        deletedAt: json["deleted_at"],
        serveFirst: json["serve_first"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "order_id": orderId,
        "price": price,
        "product_details": productDetails,
        "variation": variation,
        "discount_on_product": discountOnProduct,
        "discount_type": discountType,
        "quantity": quantity,
        "tax_amount": taxAmount,
        "add_on_ids": addOnIds,
        "variant": variant,
        "add_on_qtys": addOnQtys,
        "add_on_taxes": addOnTaxes,
        "add_on_prices": addOnPrices,
        "add_on_tax_amount": addOnTaxAmount,
        "order_status": orderStatus,
        "product_type": productType,
        "kitchen_note": kitchenNote,
        "is_addon": isAddon,
        "print_status": printStatus,
        "heat": heat,
        "to_go": toGo,
        "dont_make": dontMake,
        "modifier": modifier,
        "rush": rush,
        "is_liquor": isLiquor,
        "deleted_at": deletedAt,
        "serve_first": serveFirst,
      };
}

class ProductDetailsModel {
  final dynamic id;
  final dynamic name;
  final dynamic description;
  final dynamic image;
  final dynamic price;
  // final List<dynamic> variations;
  // final List<dynamic> addOns;
  final dynamic tax;
  final dynamic availableTimeStarts;
  final dynamic availableTimeEnds;
  final dynamic status;
  // final List<dynamic> attributes;
  // final List<dynamic> categoryIds;
  // final List<dynamic> choiceOptions;
  final dynamic discount;
  final dynamic discountType;
  final dynamic taxType;
  final dynamic setMenu;
  final dynamic branchId;
  final dynamic colors;
  final dynamic popularityCount;
  final dynamic productType;
  final dynamic isLiquor;
  // final List<dynamic> translations;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    // required this.variations,
    // required this.addOns,
    required this.tax,
    required this.availableTimeStarts,
    required this.availableTimeEnds,
    required this.status,
    // required this.attributes,
    // required this.categoryIds,
    // required this.choiceOptions,
    required this.discount,
    required this.discountType,
    required this.taxType,
    required this.setMenu,
    required this.branchId,
    required this.colors,
    required this.popularityCount,
    required this.productType,
    required this.isLiquor,
    // required this.translations,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
      // variations: jsonDecode(json['variations']),
      // addOns: jsonDecode(json['add_ons']),
      tax: json['tax'],
      availableTimeStarts: json['available_time_starts'],
      availableTimeEnds: json['available_time_ends'],
      status: json['status'],
      // attributes: jsonDecode(json['attributes']),
      // categoryIds: jsonDecode(json['category_ids']),
      // choiceOptions: jsonDecode(json['choice_options']),
      discount: json['discount'],
      discountType: json['discount_type'],
      taxType: json['tax_type'],
      setMenu: json['set_menu'],
      branchId: json['branch_id'],
      colors: json['colors'],
      popularityCount: json['popularity_count'],
      productType: json['product_type'],
      isLiquor: json['is_liquor'],
      // translations: json['translations'],
    );
  }
}
