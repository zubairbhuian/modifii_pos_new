import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
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
  void updateTableName(String newName) {
    tableController = TextEditingController(text: newName);
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
    cartList.last.kitchenNote = kitchenNoteTEC.text.trim();
    update();
    cartListScrollToBottom();
    kitchenNoteTEC.clear();
  }

  // ++++++ Add Extra info for order  +++++++
  bool isTogoSelected = false;
  bool isDontMakeSelected = false;
  bool isRushSelected = false;
  void toggleOrderTypeSelection({
    bool isTogo = false,
    bool isDontMake = false,
    bool isRush = false,
  }) {
    if (isTogo) {
      isTogoSelected = !isTogoSelected;
      if (isTogoSelected) {
        cartList.last.togo = 'TO GO';
      } else {
        cartList.last.togo = '';
      }
    }
    if (isDontMake) {
      isDontMakeSelected = !isDontMakeSelected;
      if (isDontMakeSelected) {
        cartList.last.dontMake = "DON'T MAKE";
      } else {
        cartList.last.dontMake = '';
      }
    }
    if (isRush) {
      isRushSelected = !isRushSelected;
      if (isRushSelected) {
        cartList.last.rush = 'RUSH';
      } else {
        cartList.last.rush = '';
      }
    }
    cartListScrollToBottom();
    update();
  }

  List<String> orderServeTypes = ['APPETIZERS 1st', "ALL-TOGETHER"];
  int? selectedOrderServeTypesIndex;
  void setSelectedOrderTypesIndex2(int index) {
    if (selectedOrderServeTypesIndex == index) {
      selectedOrderServeTypesIndex = null;
      cartList.last.serveFirst = "";
    } else {
      selectedOrderServeTypesIndex = index;
      if (index == 0) {
        cartList.last.serveFirst = "APPETIZERS 1st";
      } else {
        cartList.last.serveFirst = "ALL-TOGETHER";
      }
    }
    cartListScrollToBottom();
    update();
  }

  List<String> orderHeatModifiers = ['MILD', 'MEDIUM', 'HOT', 'EXTRA HOT'];
  int? selectedOrderHeatModifiersIndex;
  void setSelectedOrderModifiersIndex(int index) {
    if (selectedOrderHeatModifiersIndex == index) {
      selectedOrderHeatModifiersIndex = null;
      cartList.last.heat = "";
    } else {
      selectedOrderHeatModifiersIndex = index;
      switch (index) {
        case 0:
          cartList.last.heat = "MILD";
          break;
        case 1:
          cartList.last.heat = "MEDIUM";
          break;
        case 2:
          cartList.last.heat = "HOT";
          break;
        case 3:
          cartList.last.heat = "EXTRA HOT";
          break;
        default:
          cartList.last.heat = "";
          break;
      }
    }
    cartListScrollToBottom();
    update();
  }

  void resetModifierSelections() {
    orderQuantity = 1;
    selectedProductVariationValue = null;
    selectedOrderServeTypesIndex = null;
    selectedOrderHeatModifiersIndex = null;
    isTogoSelected = false;
    isDontMakeSelected = false;
    isRushSelected = false;
    kitchenNoteTEC.clear();
    update();
  }

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

  //** Order Process **
  // **======+=======**
  //** Order Process **

// zubair ==== + +++++++
// zubair ==== + +++++++
  OrderModel myOrder = OrderModel();

  onPlaseOrder() {
    update();
    
    /// for test
    // Logger().e("gratuityAmount => ${myOrder.gratuityAmount}");
    // Logger().e("gstAmount => ${myOrder.gstAmount}");
    // Logger().e("pstAmount => ${myOrder.pstAmount}");
    Logger().e("length => ${myOrder.carts.length}");
    // Logger().e("numberOfPeople => ${myOrder.numberOfPeople}");
    // Logger().e("orderAmount => ${myOrder.orderAmount}");
    // Logger().e("paymentMethod => ${myOrder.paymentMethod}");
    // Logger().e("gratuityAmount => ${myOrder.gratuityAmount}");
    // Logger().e("gratuityAmount => ${myOrder.tableId}");
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
        myOrder.gratuityAmount = myOrder.gratuityAmount * .18;
      }
    }
    //for gst
    myOrder.gstAmount = myOrder.subTotal * .05;
    //for pst
    myOrder.pstAmount = 0; //myOrder.subTotal * .1;
    // for Total
    myOrder.orderAmount = myOrder.subTotal +
        myOrder.gstAmount +
        myOrder.pstAmount +
        myOrder.gratuityAmount;
  }

// zubair ==== + +++++++
// zubair ==== + +++++++

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

    super.onInit();
  }

  @override
  void onReady() async {
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
    super.onClose();
  }
}
