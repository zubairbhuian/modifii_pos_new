// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/dine-in/models/table_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_place_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/product_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/variation_model.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../widgets/popup_dialogs.dart';
import '../order/models/main_category_model.dart';

class PosController extends GetxController {
  static PosController get to => Get.find();
  // for table number
  TextEditingController tableController = TextEditingController();
  TextEditingController guestController = TextEditingController();
  // for Focus
  final FocusNode tableFocusNode = FocusNode();
  final FocusNode guestFocusNode = FocusNode();

  void changeFocusToGuest() {
    tableFocusNode.unfocus();
    FocusScope.of(Get.context!).requestFocus(guestFocusNode);
  }

  void updateTableName(TableModel table) {
    tableController = TextEditingController(text: table.tableName);
    myOrder.tableId = table.id;
    changeFocusToGuest();
    update();
  }

  //** change page **
  PageController pageController = PageController();
  RxBool isShowPos = false.obs;
  onchangePage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    if (index == 0) {
      isShowPos.value = false;
    } else {
      isShowPos.value = true;
    }
  }

  RxBool isShowOrders = true.obs;
  int? categoryId;

  // RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxInt selectedCategoryIndex = (-1).obs;
  void updateSelectedCategoryIndex(int value) {
    selectedCategoryIndex.value = value;
  }

  RxBool isProductPage = false.obs;

  // get main and sub category
  var categoryList = <MainCategoryModel>[].obs;
  RxBool isLoadingCategory = false.obs;
  Future getCategoryList() async {
    //     Map<String, dynamic> data = {
    //   "title": titleController.text,
    //   "type": selectedCategory // VEG, NON_VEG, DRINKS
    // };
    try {
      var res = await BaseController.to.apiService.dio.get(URLS.mainCategories);
      if (res.statusCode == 200) {
        categoryList.assignAll((res.data["data"] as List)
            .map((e) => MainCategoryModel.fromJson(e))
            .toList());

        kLogger.e(categoryList.length);
      }
    } catch (e) {
      kLogger.e('Error from %%%% get category %%%% => $e');
    }
  }

  //** find product by name**
  final searchController = TextEditingController();
  //** Get all product **
  bool isLoadingProduct = false;
  List<ProductModel> productList = [];
  List<ProductModel> mainProductList = [];

  Future getProductList() async {
    //     Map<String, dynamic> data = {
    //   "title": titleController.text,
    //   "type": selectedCategory // VEG, NON_VEG, DRINKS
    // };
    var res = await BaseController.to.apiService.makeGetRequest(URLS.products);

    if (res.statusCode == 200) {
      mainProductList.assignAll((res.data["data"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList());

      productList = [...mainProductList];
      update();
      Logger().i(mainProductList.length);
      Logger().i(productList.length);
    }
  }

  void findProductsByName(String name) async {
    // Log the lengths of the lists
    // Logger().e("M=> ${mainProductList.length}");
    // Logger().e("S=> ${productList.length}");

    // If the search name is empty, show the full main product list
    if (name.isEmpty) {
      productList.assignAll(mainProductList);
    } else {
      // Filter the products by name
      List<ProductModel> filteredProducts = mainProductList
          .where((product) =>
              product.name.toLowerCase().contains(name.toLowerCase()))
          .toList();

      Logger().d(name);

      // Assign the filtered products to the productList observable
      productList.assignAll(filteredProducts);
    }

    // Update the UI
    update();
  }

  //** find product categoryId**
  void findProductsByCategoryId(String categoryId) {
    List<ProductModel> filteredProducts = mainProductList
        .where((product) => product.subCategory.id.contains(categoryId))
        .toList();
    if (filteredProducts.isEmpty) {
      productList = [];
    } else {
      productList.assignAll(filteredProducts);
    }
    searchController.clear();
    update();
  }

  TextEditingController kitchenNoteTEC = TextEditingController();
  void addKitchenNote() {
    myOrder.carts.last.kitchenNote = kitchenNoteTEC.text.trim();
    update();
    cartListScrollToBottom();
    kitchenNoteTEC.clear();
  }

  // ++++++ Add Extra info for order  +++++++
  // zubair => Add Extra info for order
  List<String> serveFirstList = ["APPETIZERS 1st", "ALL-TOGETHER"];
  List<String> selectedserveFirstList = [];
  onServeFirst(String value) {
    if (myOrder.carts.isNotEmpty) {
      selectedserveFirstList.clear();
      if (selectedserveFirstList.contains(value)) {
        selectedserveFirstList.remove(value);
      } else {
        selectedserveFirstList.add(value);
        myOrder.carts.last.serveFirst = value;
      }
      update();
      cartListScrollToBottom();
    }
  }

  List<String> heatList = ['MILD', 'MEDIUM', 'HOT', 'EXTRA HOT'];
  List<String> selectedHeatList = [];

  onHeat(String value) {
    if (myOrder.carts.isNotEmpty) {
      selectedHeatList.clear();
      if (selectedHeatList.contains(value)) {
        selectedHeatList.remove(value);
      } else {
        selectedHeatList.add(value);
        myOrder.carts.last.heat = value;
      }
      update();
      cartListScrollToBottom();
    }
  }

  List<String> othermodifierList = ["TO GO", "DON'T MAKE", "RUSH"];
  List<String> selectedOthermodifierList = [];
  onOthermodifier(String value) {
    if (myOrder.carts.isNotEmpty) {
      if (selectedOthermodifierList.contains(value)) {
        selectedOthermodifierList.remove(value);
        if (value == "TO GO") {
          myOrder.carts.last.toGo = "";
        } else if (value == "DON'T MAKE") {
          myOrder.carts.last.dontMake = "";
        } else if (value == "RUSH") {
          myOrder.carts.last.rush = "";
        }
      } else {
        selectedOthermodifierList.add(value);
        if (value == "TO GO") {
          myOrder.carts.last.toGo = value;
        } else if (value == "DON'T MAKE") {
          myOrder.carts.last.dontMake = value;
        } else if (value == "RUSH") {
          myOrder.carts.last.rush = value;
        }
      }
      update();
      cartListScrollToBottom();
    }
  }

  void resetModifierSelections() {
    orderQuantity = 1;
    selectedProductVariationValue = null;
    selectedHeatList.clear();
    selectedOthermodifierList.clear();
    selectedserveFirstList.clear();
    kitchenNoteTEC.clear();
    update();
  }

  // zubair => Add Extra info for order

  bool isDrink = true;
  void checkIsDrink(String productType) {
    isDrink = productType == 'drinks';
    update();
  }

  bool hasVariations = false;
  void checkHasVariations(List<VariationModel> variations) {
    if (variations.isEmpty) {
      hasVariations = false;
    } else {
      hasVariations = true;
      productVariations = variations;
    }
  }

  List<VariationModel> productVariations = [];
  int? selectedProductVariationValue;
  void setSelectedProductVariationValue(int index) {
    selectedProductVariationValue = index;
    update();
  }

  int orderQuantity = 1;
  num orderTotalPrice = 0;
  void updateOrderQuantity(bool isIncrease, num price) {
    if (isIncrease && orderQuantity < 10) {
      orderQuantity++;
      orderTotalPrice = price * orderQuantity;
      update();
    } else if (!isIncrease && orderQuantity > 1) {
      orderQuantity--;
      orderTotalPrice = price / orderQuantity;
      update();
    }
  }

  //** Order Process **ff
  // **======+=======**
  //** Order Process **

// zubair ==== + +++++++
// zubair ==== + +++++++
  OrderModel myOrder = OrderModel();

  onPlaseOrder(
      {String orderType = "DINE_IN",
      String orderStatus = "CONFIRMED",
      String paymentStatus = "UNPAID"}) async {
    if (guestController.text.isEmpty) {
      PopupDialog.showErrorMessage("Guest required");
    } else if (tableController.text.isEmpty) {
      PopupDialog.showErrorMessage("Table required");
    } else if (myOrder.carts.isEmpty) {
      PopupDialog.showErrorMessage("Minimum one order is required");
    } else {
      myOrder.orderType = orderType;
      myOrder.orderStatus = orderStatus;
      myOrder.paymentStatus = paymentStatus;
      PopupDialog.showLoadingDialog();
      var res = await BaseController.to.apiService
          .makePostRequest(URLS.placeOrder, myOrder.toJson());
      PopupDialog.closeLoadingDialog();
      if (res.statusCode == 201) {
        clearCartList();
        PopupDialog.showSuccessDialog(res.data["message"]);
        myOrder.employeeId = '66a27bac841c686681819833';
      }
    }
  }

  //** Add cart item  **
  onAddCartItem(CartModel item) {
    myOrder.carts.add(item);
    calculateTotalPrice();
    //scroll listview to end
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartListScrollController.animateTo(
        cartListScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    update();
  }

  //** Remove cart item with index **
  onRemoveCartItemWithIndex(int index) {
    // Check if the index is within bounds
    if (index >= 0 && index < myOrder.carts.length) {
      myOrder.carts.removeAt(index);
    }
    calculateTotalPrice();
    update();
  }

  //** Quantity Update **
  void quantityUpdateWithCartListIndex(int index, {required bool isIncriment}) {
    if (myOrder.carts[index].quantity < 10 && isIncriment) {
      myOrder.carts[index].quantity = myOrder.carts[index].quantity + 1;
    } else if (myOrder.carts[index].quantity > 1 && !isIncriment) {
      myOrder.carts[index].quantity = myOrder.carts[index].quantity - 1;
    }
    calculateTotalPrice();
    update();
  }

  calculateTotalPrice() {
    // for subtotal
    num totalPrice = 0;
    for (var item in myOrder.carts) {
      num discountedPrice = item.price - item.discountAmount;
      totalPrice += discountedPrice * item.quantity;
    }
    myOrder.subTotal = totalPrice;
    // for gratuityAmount
    if (guestController.text.isNotEmpty) {
      if (int.parse(guestController.text) >= 6) {
        myOrder.totalGratuity = myOrder.subTotal * .18;
      } else {
        myOrder.totalGratuity = 0;
      }
    }
    //for gst
    myOrder.totalGst = myOrder.subTotal * .05;
    //for pst
    num pst = 0;
    for (var item in myOrder.carts) {
      if (item.isLiquor) {
        pst += (item.price * item.quantity) * .10;
      }
    }
    myOrder.totalPst = pst;
    // for Total
    myOrder.totalOrderAmount = myOrder.subTotal +
        myOrder.totalGst +
        myOrder.totalPst +
        myOrder.totalGratuity;
    update();
  }

// zubair ==== + +++++++
// zubair ==== + +++++++ ^^^

  List<Cart> cartList = <Cart>[];
  final ScrollController cartListScrollController = ScrollController();
  void cartListScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartListScrollController.animateTo(
        cartListScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void clearCartList() {
    myOrder = OrderModel();
    resetModifierSelections();
    guestController.clear();
    tableController.clear();
    update();
  }

  RxDouble cartSubTotalPrice = 0.0.obs;
  RxDouble cartSubTotalLiquorPrice = 0.0.obs;
  RxDouble cartGSTAmount = 0.0.obs;
  RxDouble cartGratuityAmount = 0.0.obs;
  RxDouble cartPSTAmount = 0.0.obs;
  RxDouble cartTotalAmount = 0.0.obs;
  void getTotalPrice() {
    cartSubTotalPrice.value = 0;
    cartSubTotalLiquorPrice.value = 0;
    cartGratuityAmount.value = 0;
    for (var cart in cartList) {
      cartSubTotalPrice.value += (cart.price * cart.quantity);
    }
    for (var cart in cartList.where((e) => e.isLiquor! == 1).toList()) {
      cartSubTotalLiquorPrice.value += (cart.price * cart.quantity);
    }
    cartGSTAmount.value = cartSubTotalPrice * 0.05;
    cartPSTAmount.value = cartSubTotalLiquorPrice * 0.10;
    // if (TablesController.to.selectedGuestNumbers != null) {
    //   if (int.parse(TablesController.to.selectedGuestNumbers!) >= 6) {
    //     cartGratuityAmount.value = cartSubTotalPrice * 0.18;
    //   }
    // }

    cartTotalAmount.value = cartSubTotalPrice.value +
        cartGSTAmount.value +
        cartPSTAmount.value +
        cartGratuityAmount.value;
  }

// //place order
//   void postPlaceOrder() async {
//     if (cartList.isEmpty) {
//       PopupDialog.showErrorMessage("Please add item!");
//       return;
//     }
//     if (!TablesController.to.isTableOrBarSelected()) {
//       PopupDialog.showErrorMessage("Please select Table or Bar!");
//       return;
//     }
//     if (TablesController.to.selectedGuestNumbers == null) {
//       PopupDialog.showErrorMessage("Please select Number of Guests!");
//       return;
//     }

//     List<Map<String, dynamic>> cartItems = [];

//     for (var cart in cartList) {
//       cartItems.add(cart.toJson());
//     }
//     Map<String, dynamic> data = {
//       "cart": cartItems,
//       "table_id":
//           num.parse(TablesController.to.selectedTable?.id.toString() ?? ''),
//       "bar_id": num.parse(TablesController.to.selectedBar?.id.toString() ?? ''),
//       "server_id": 1,
//       "branch_id": 1,
//       "number_of_people": TablesController.to.selectedGuestNumbers,
//       "payment_status": "unpaid",
//       "payment_method": "pay_after_eating",
//       "order_amount": cartTotalAmount.toStringAsFixed(2),
//       "gratuity_amount": 0,
//       "gst_amount": cartGSTAmount.toStringAsFixed(2),
//       "pst_amount": cartPSTAmount.toStringAsFixed(2),
//       "order_note": kitchenNoteTEC.text,
//     };
//     try {
//       kLogger.i(data);
//       PopupDialog.showLoadingDialog();
//       var res = await Dio().post(
//         URLS.placeOrder,
//         data: data,
//       );
//       if (res.statusCode == 200 || res.statusCode == 201) {
//         PopupDialog.showSuccessDialog("Order placed successfully!");
//         TablesController.to.getTables();
//         OrdersController.to.getOrders();
//       } else if (res.statusCode == 403) {
//         PopupDialog.showErrorMessage("Failed to place order!");
//       }
//       kLogger.i("response: ${res.data}");
//       PopupDialog.closeLoadingDialog();
//     } catch (e) {
//       kLogger.e('Error from %%%% login %%%% => $e');
//       PopupDialog.closeLoadingDialog();
//     }
//   }

  @override
  void onInit() {
    searchController
        .addListener(() => findProductsByName(searchController.text));
    guestController.addListener(() {
      calculateTotalPrice();
      if (guestController.text.isNotEmpty) {
        myOrder.numberOfPeople = int.parse(guestController.text);
      }
    });

    super.onInit();
  }

  @override
  void onReady() async {
    myOrder.employeeId = '66a27bac841c686681819833';
    PopupDialog.showLoadingDialog();
    await getCategoryList();
    await getProductList();
    PopupDialog.closeLoadingDialog();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    tableFocusNode.dispose();
    guestController.dispose();
    super.onClose();
  }
}

enum OrderType {
  DINE_IN,
  TAKE_OUT,
  DELIVERY,
}

enum OrderStatus { COMPLETED, CONFIRMED, DELIVERED, CANCELED }

enum PaymentStatus {
  PAID,
  UNPAID,
}
