import 'dart:convert';

class OrderModel {
  OrderModel({
    required this.id,
    required this.adminId,
    required this.userId,
    required this.serverId,
    required this.isGuest,
    required this.orderAmount,
    required this.gratuityAmount,
    required this.pstAmount,
    required this.couponDiscountAmount,
    required this.couponDiscountTitle,
    required this.paymentStatus,
    required this.orderStatus,
    required this.totalTaxAmount,
    required this.paymentMethod,
    required this.transactionReference,
    required this.deliveryAddressId,
    required this.createdAt,
    required this.updatedAt,
    required this.checked,
    required this.deliveryManId,
    required this.deliveryCharge,
    required this.orderNote,
    required this.couponCode,
    required this.orderType,
    required this.branchId,
    required this.callback,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.extraDiscount,
    required this.extraDiscountType,
    required this.extraDiscountDiscount,
    required this.extraDiscountReason,
    required this.deliveryAddress,
    required this.preparationTime,
    required this.tableId,
    required this.numberOfPeople,
    required this.tableOrderId,
    required this.refundOrderId,
    required this.voidOrderId,
    required this.refundReason,
    required this.totalRefundAmount,
    required this.authorizationCode,
    required this.recieveCash,
    required this.changeCashAmount,
    required this.deliveryDistance,
    required this.addonSubTotal,
    required this.addonGst,
    required this.addonPst,
    required this.addonGratuity,
    required this.addonTotal,
    required this.tipAmount,
    required this.parentOrderId,
    required this.clearedAt,
    required this.bookingType,
    required this.customerName,
    required this.barId,
    required this.deletedAt,
    required this.serveFirst,
    required this.packagingCharge,
    required this.extraPaymentMethod,
    required this.cashTip,
    required this.itemsDiscount,
    required this.discountBy,
    required this.details,
    required this.serverName,
    required this.server,
  });

  final int id;
  final dynamic adminId;
  final dynamic userId;
  final int serverId;
  final num isGuest;
  final num orderAmount;
  final num gratuityAmount;
  final num pstAmount;
  final num couponDiscountAmount;
  final dynamic couponDiscountTitle;
  final String paymentStatus;
  final String orderStatus;
  final num totalTaxAmount;
  final String paymentMethod;
  final dynamic transactionReference;
  final dynamic deliveryAddressId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num checked;
  final dynamic deliveryManId;
  final num deliveryCharge;
  final dynamic orderNote;
  final dynamic couponCode;
  final String orderType;
  final int branchId;
  final dynamic callback;
  final DateTime? deliveryDate;
  final String deliveryTime;
  final String extraDiscount;
  final dynamic extraDiscountType;
  final dynamic extraDiscountDiscount;
  final dynamic extraDiscountReason;
  final dynamic deliveryAddress;
  final num preparationTime;
  final int tableId;
  final num numberOfPeople;
  final int tableOrderId;
  final dynamic refundOrderId;
  final dynamic voidOrderId;
  final dynamic refundReason;
  final num totalRefundAmount;
  final dynamic authorizationCode;
  final dynamic recieveCash;
  final dynamic changeCashAmount;
  final dynamic deliveryDistance;
  final num addonSubTotal;
  final num addonGst;
  final num addonPst;
  final num addonGratuity;
  final num addonTotal;
  final num tipAmount;
  final dynamic parentOrderId;
  final dynamic clearedAt;
  final dynamic bookingType;
  final dynamic customerName;
  final dynamic barId;
  final dynamic deletedAt;
  final dynamic serveFirst;
  final num packagingCharge;
  final dynamic extraPaymentMethod;
  final num cashTip;
  final num itemsDiscount;
  final dynamic discountBy;
  final List<Detail> details;
  final String serverName;
  final Server? server;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"] ?? 0,
      adminId: json["admin_id"],
      userId: json["user_id"],
      serverId: json["server_id"] ?? 0,
      isGuest: json["is_guest"] ?? 0,
      orderAmount: json["order_amount"] ?? 0,
      gratuityAmount: json["gratuity_amount"] ?? 0,
      pstAmount: json["pst_amount"] ?? 0,
      couponDiscountAmount: json["coupon_discount_amount"] ?? 0,
      couponDiscountTitle: json["coupon_discount_title"],
      paymentStatus: json["payment_status"] ?? "",
      orderStatus: json["order_status"] ?? "",
      totalTaxAmount: json["total_tax_amount"] ?? 0,
      paymentMethod: json["payment_method"] ?? "",
      transactionReference: json["transaction_reference"],
      deliveryAddressId: json["delivery_address_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      checked: json["checked"] ?? 0,
      deliveryManId: json["delivery_man_id"],
      deliveryCharge: json["delivery_charge"] ?? 0,
      orderNote: json["order_note"],
      couponCode: json["coupon_code"],
      orderType: json["order_type"] ?? "",
      branchId: json["branch_id"] ?? 0,
      callback: json["callback"],
      deliveryDate: DateTime.tryParse(json["delivery_date"] ?? ""),
      deliveryTime: json["delivery_time"] ?? "",
      extraDiscount: json["extra_discount"] ?? "",
      extraDiscountType: json["extra_discount_type"],
      extraDiscountDiscount: json["extra_discount_discount"],
      extraDiscountReason: json["extra_discount_reason"],
      deliveryAddress: json["delivery_address"],
      preparationTime: json["preparation_time"] ?? 0,
      tableId: json["table_id"] ?? 0,
      numberOfPeople: json["number_of_people"] ?? 0,
      tableOrderId: json["table_order_id"] ?? 0,
      refundOrderId: json["refund_order_id"],
      voidOrderId: json["void_order_id"],
      refundReason: json["refund_reason"],
      totalRefundAmount: json["total_refund_amount"] ?? 0,
      authorizationCode: json["authorization_code"],
      recieveCash: json["recieve_cash"],
      changeCashAmount: json["change_cash_amount"],
      deliveryDistance: json["delivery_distance"],
      addonSubTotal: json["addon_sub_total"] ?? 0,
      addonGst: json["addon_gst"] ?? 0,
      addonPst: json["addon_pst"] ?? 0,
      addonGratuity: json["addon_gratuity"] ?? 0,
      addonTotal: json["addon_total"] ?? 0,
      tipAmount: json["tip_amount"] ?? 0,
      parentOrderId: json["parent_order_id"],
      clearedAt: json["cleared_at"],
      bookingType: json["booking_type"],
      customerName: json["customer_name"],
      barId: json["bar_id"],
      deletedAt: json["deleted_at"],
      serveFirst: json["serve_first"],
      packagingCharge: json["packaging_charge"] ?? 0,
      extraPaymentMethod: json["extra_payment_method"],
      cashTip: json["cash_tip"] ?? 0,
      itemsDiscount: json["items_discount"] ?? 0,
      discountBy: json["discount_by"],
      details: json["details"] == null
          ? []
          : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
      serverName: json["server_name"] ?? "",
      server: json["server"] == null ? null : Server.fromJson(json["server"]),
    );
  }

  @override
  String toString() {
    return "$id, $adminId, $userId, $serverId, $isGuest, $orderAmount, $gratuityAmount, $pstAmount, $couponDiscountAmount, $couponDiscountTitle, $paymentStatus, $orderStatus, $totalTaxAmount, $paymentMethod, $transactionReference, $deliveryAddressId, $createdAt, $updatedAt, $checked, $deliveryManId, $deliveryCharge, $orderNote, $couponCode, $orderType, $branchId, $callback, $deliveryDate, $deliveryTime, $extraDiscount, $extraDiscountType, $extraDiscountDiscount, $extraDiscountReason, $deliveryAddress, $preparationTime, $tableId, $numberOfPeople, $tableOrderId, $refundOrderId, $voidOrderId, $refundReason, $totalRefundAmount, $authorizationCode, $recieveCash, $changeCashAmount, $deliveryDistance, $addonSubTotal, $addonGst, $addonPst, $addonGratuity, $addonTotal, $tipAmount, $parentOrderId, $clearedAt, $bookingType, $customerName, $barId, $deletedAt, $serveFirst, $packagingCharge, $extraPaymentMethod, $cashTip, $itemsDiscount, $discountBy, $details, $serverName, $server, ";
  }
}

class Detail {
  Detail({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.price,
    required this.productDetails,
    required this.variation,
    required this.discountOnProduct,
    required this.discountType,
    required this.discountAmount,
    required this.discountReason,
    required this.quantity,
    required this.taxAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.addOnIds,
    required this.variant,
    required this.addOnQtys,
    required this.addOnTaxes,
    required this.addOnPrices,
    required this.addOnTaxAmount,
    required this.orderStatus,
    required this.productType,
    required this.kitchenNote,
    required this.isAddon,
    required this.printStatus,
    required this.heat,
    required this.toGo,
    required this.dontMake,
    required this.modifier,
    required this.rush,
    required this.isLiquor,
    required this.deletedAt,
    required this.serveFirst,
    required this.discountBy,
  });

  final int id;
  final int productId;
  final int orderId;
  final num price;
  final ProductDetailsClass? productDetails;
  final String variation;
  final num discountOnProduct;
  final String discountType;
  final num discountAmount;
  final dynamic discountReason;
  final num quantity;
  final num taxAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic addOnIds;
  final dynamic variant;
  final dynamic addOnQtys;
  final String addOnTaxes;
  final String addOnPrices;
  final num addOnTaxAmount;
  final String orderStatus;
  final String productType;
  final dynamic kitchenNote;
  final num isAddon;
  final num printStatus;
  final dynamic heat;
  final String toGo;
  final String dontMake;
  final dynamic modifier;
  final String rush;
  final num isLiquor;
  final dynamic deletedAt;
  final String serveFirst;
  final dynamic discountBy;

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json["id"] ?? 0,
      productId: json["product_id"] ?? 0,
      orderId: json["order_id"] ?? 0,
      price: json["price"] ?? 0,
      productDetails:jsonDecode(json["product_details"]) == null ? null : ProductDetailsClass.fromJson(jsonDecode(json["product_details"])) ,
      variation: json["variation"] ?? "",
      discountOnProduct: json["discount_on_product"] ?? 0,
      discountType: json["discount_type"] ?? "",
      discountAmount: json["discount_amount"] ?? 0,
      discountReason: json["discount_reason"],
      quantity: json["quantity"] ?? 0,
      taxAmount: json["tax_amount"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      addOnIds: json["add_on_ids"],
      variant: json["variant"],
      addOnQtys: json["add_on_qtys"],
      addOnTaxes: json["add_on_taxes"] ?? "",
      addOnPrices: json["add_on_prices"] ?? "",
      addOnTaxAmount: json["add_on_tax_amount"] ?? 0,
      orderStatus: json["order_status"] ?? "",
      productType: json["product_type"] ?? "",
      kitchenNote: json["kitchen_note"],
      isAddon: json["is_addon"] ?? 0,
      printStatus: json["print_status"] ?? 0,
      heat: json["heat"],
      toGo: json["to_go"] ?? "",
      dontMake: json["dont_make"] ?? "",
      modifier: json["modifier"],
      rush: json["rush"] ?? "",
      isLiquor: json["is_liquor"] ?? 0,
      deletedAt: json["deleted_at"],
      serveFirst: json["serve_first"] ?? "",
      discountBy: json["discount_by"],
    );
  }

  @override
  String toString() {
    return "$id, $productId, $orderId, $price, $productDetails, $variation, $discountOnProduct, $discountType, $discountAmount, $discountReason, $quantity, $taxAmount, $createdAt, $updatedAt, $addOnIds, $variant, $addOnQtys, $addOnTaxes, $addOnPrices, $addOnTaxAmount, $orderStatus, $productType, $kitchenNote, $isAddon, $printStatus, $heat, $toGo, $dontMake, $modifier, $rush, $isLiquor, $deletedAt, $serveFirst, $discountBy, ";
  }
}

class ProductDetailsClass {
  ProductDetailsClass({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.variations,
    required this.addOns,
    required this.tax,
    required this.availableTimeStarts,
    required this.availableTimeEnds,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
    required this.categoryIds,
    required this.choiceOptions,
    required this.discount,
    required this.discountType,
    required this.taxType,
    required this.setMenu,
    required this.branchId,
    required this.colors,
    required this.popularityCount,
    required this.productType,
    required this.isLiquor,
    required this.translations,
  });

  final int id;
  final String name;
  final String description;
  final String image;
  final num price;
  final String variations;
  final String addOns;
  final num tax;
  final String availableTimeStarts;
  final String availableTimeEnds;
  final num status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String attributes;
  final String categoryIds;
  final String choiceOptions;
  final num discount;
  final String discountType;
  final String taxType;
  final num setMenu;
  final int branchId;
  final dynamic colors;
  final num popularityCount;
  final String productType;
  final num isLiquor;
  final List<dynamic> translations;

  factory ProductDetailsClass.fromJson(Map<String, dynamic> json) {
    return ProductDetailsClass(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      image: json["image"] ?? "",
      price: json["price"] ?? 0,
      variations: json["variations"] ?? "",
      addOns: json["add_ons"] ?? "",
      tax: json["tax"] ?? 0,
      availableTimeStarts: json["available_time_starts"] ?? "",
      availableTimeEnds: json["available_time_ends"] ?? "",
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      attributes: json["attributes"] ?? "",
      categoryIds: json["category_ids"] ?? "",
      choiceOptions: json["choice_options"] ?? "",
      discount: json["discount"] ?? 0,
      discountType: json["discount_type"] ?? "",
      taxType: json["tax_type"] ?? "",
      setMenu: json["set_menu"] ?? 0,
      branchId: json["branch_id"] ?? 0,
      colors: json["colors"],
      popularityCount: json["popularity_count"] ?? 0,
      productType: json["product_type"] ?? "",
      isLiquor: json["is_liquor"] ?? 0,
      translations: json["translations"] == null
          ? []
          : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $image, $price, $variations, $addOns, $tax, $availableTimeStarts, $availableTimeEnds, $status, $createdAt, $updatedAt, $attributes, $categoryIds, $choiceOptions, $discount, $discountType, $taxType, $setMenu, $branchId, $colors, $popularityCount, $productType, $isLiquor, $translations, ";
  }
}

class Server {
  Server({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.image,
    required this.password,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.fcmToken,
    required this.adminRoleId,
    required this.status,
    required this.identityNumber,
    required this.identityType,
    required this.identityImage,
    required this.authenticationPin,
    required this.accessPin,
    required this.enableAccessPin,
    required this.adminName,
    required this.workTime,
  });

  final int id;
  final String fName;
  final String lName;
  final String phone;
  final String email;
  final String image;
  final String password;
  final String rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic fcmToken;
  final int adminRoleId;
  final int status;
  final String identityNumber;
  final String identityType;
  final String identityImage;
  final String authenticationPin;
  final num accessPin;
  final num enableAccessPin;
  final String adminName;
  final String workTime;

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json["id"] ?? 0,
      fName: json["f_name"] ?? "",
      lName: json["l_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      password: json["password"] ?? "",
      rememberToken: json["remember_token"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      fcmToken: json["fcm_token"],
      adminRoleId: json["admin_role_id"] ?? 0,
      status: json["status"] ?? 0,
      identityNumber: json["identity_number"] ?? "",
      identityType: json["identity_type"] ?? "",
      identityImage: json["identity_image"] ?? "",
      authenticationPin: json["authentication_pin"] ?? "",
      accessPin: json["access_pin"] ?? 0,
      enableAccessPin: json["enable_access_pin"] ?? 0,
      adminName: json["admin_name"] ?? "",
      workTime: json["work_time"] ?? "",
    );
  }

  @override
  String toString() {
    return "$id, $fName, $lName, $phone, $email, $image, $password, $rememberToken, $createdAt, $updatedAt, $fcmToken, $adminRoleId, $status, $identityNumber, $identityType, $identityImage, $authenticationPin, $accessPin, $enableAccessPin, $adminName, $workTime, ";
  }
}
