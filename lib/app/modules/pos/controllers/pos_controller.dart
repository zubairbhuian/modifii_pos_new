import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/orders_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/models/category_model.dart';
import 'package:flutter_base/app/modules/pos/models/order_place_model.dart';
import 'package:flutter_base/app/modules/pos/models/product_model.dart';
import 'package:flutter_base/app/utils/logger.dart';
import 'package:flutter_base/app/utils/urls.dart';
import 'package:get/get.dart';
import '../../../widgets/popup_dialogs.dart';

class PosController extends GetxController {
  static PosController get to => Get.find();

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

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxInt selectedCategoryIndex = (-1).obs;
  void updateSelectedCategoryIndex(int value) {
    selectedCategoryIndex.value = value;
  }

  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> mainProductList = <ProductModel>[].obs;
  RxBool isProductPage = false.obs;

  RxBool isLoadingCategory = false.obs;
  getCategory({String? type, int? offset, int? limit}) async {
    isLoadingCategory.value = true;
    Map<String, dynamic>? queryParameters = {
      "type": type,
      "offset": offset,
      "limit": limit
    };
    try {
      var res =
          await Dio().get(URLS.categories, queryParameters: queryParameters);
      if (res.statusCode == 200) {
        categoryList.assignAll((res.data["data"] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList());
      }
      isLoadingCategory.value = false;

      // kLogger.e(categoryList.length);
    } catch (e) {
      kLogger.e('Error from %%%% get categori %%%% => $e');
    }
  }

  //** Get all product **
  RxBool isLoadingProduct = false.obs;
  getProduct({String? type, int? offset, int? limit, int? categoryIds}) async {
    isLoadingProduct.value = true;
    productList.clear();
    categoryId = categoryIds;
    Map<String, dynamic>? queryParameters = {
      "product_type": type,
      "offset": offset,
      "limit": limit ?? 800,
      "category_ids": categoryIds
    };
    try {
      var res =
          await Dio().get(URLS.products, queryParameters: queryParameters);
      if (res.statusCode == 200) {
        productList.assignAll((res.data["products"] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList());
        mainProductList.assignAll((res.data["products"] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList());

        /// Save fetched posts to Hive for future use
        // await MyHive.saveAllProducts(productList);

        isLoadingProduct.value = false;
      }
      // kLogger.e(productList);
    } catch (e) {
      kLogger.e('Error from %%%% get categori %%%% => $e');
    }
  }

  //** find product categoryId**
  findProductsByCategoryId(String categoryId) {
    productList.assignAll(mainProductList
        .where((product) => product.categoryIds!
            .expand((category) => [category.id])
            .contains(categoryId))
        .toList());
  }

  TextEditingController kitchenNoteTEC = TextEditingController();
  void addKitchenNote() {
    cartList.last.kitchenNote = kitchenNoteTEC.text.trim();
    update();
    cartListScrollToBottom();
    kitchenNoteTEC.clear();
  }

  TextEditingController itemSearchTEC = TextEditingController();
  void searchItemList(String? value) {
    if (value != null || value != '') {
      productList.value = mainProductList.where((item) {
        return item.name.toLowerCase().contains(value ?? '');
      }).toList();
    }
    update();
  }

  void clearSearchItem() {
    itemSearchTEC.clear();
    productList.value = mainProductList.where((item) {
      return item.name.toLowerCase().contains('');
    }).toList();
    update();
  }

  // List<String> orderTypes = ['TO GO', "DON'T MAKE", 'RUSH'];
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
  void checkHasVariations(List<Variation> variations) {
    if (variations.isEmpty) {
      hasVariations = false;
    } else {
      hasVariations = true;
      productVariations = variations;
    }
  }

  List<Variation> productVariations = [];
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

  //** Add cart item  **
  onAddCartItem(Cart item) {
    cartList.add(item);
    // for (var cart in cartList) {
    //   kLogger.i(cart);
    // }
    getTotalPrice();
    kitchenNoteTEC.clear();

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

  void clearCartList() {
    TablesController.to.clearSelections();
    cartList.clear();
    getTotalPrice();
    clearSearchItem();
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
    if (TablesController.to.selectedGuestNumbers != null) {
      if (int.parse(TablesController.to.selectedGuestNumbers!) >= 6) {
        cartGratuityAmount.value = cartSubTotalPrice * 0.18;
      }
    }

    cartTotalAmount.value = cartSubTotalPrice.value +
        cartGSTAmount.value +
        cartPSTAmount.value +
        cartGratuityAmount.value;
  }

  //** Remove cart item with index **
  onRemoveCartItemWithIndex(int index) {
    // Check if the index is within bounds
    if (index >= 0 && index < cartList.length) {
      cartList.removeAt(index);
    }
    getTotalPrice();
    update();
  }

  //** Quantity Update **
  void quantityUpdateWithCartListIndex(int index, {required bool isIncriment}) {
    if (cartList[index].quantity < 10 && isIncriment) {
      cartList[index].quantity = cartList[index].quantity + 1;
    } else if (cartList[index].quantity > 1 && !isIncriment) {
      cartList[index].quantity = cartList[index].quantity - 1;
    }
    getTotalPrice();
    update();
  }

//place order
  void postPlaceOrder() async {
    if (cartList.isEmpty) {
      PopupDialog.showErrorMessage("Please add item!");
      return;
    }
    if (!TablesController.to.isTableOrBarSelected()) {
      PopupDialog.showErrorMessage("Please select Table or Bar!");
      return;
    }
    if (TablesController.to.selectedGuestNumbers == null) {
      PopupDialog.showErrorMessage("Please select Number of Guests!");
      return;
    }

    List<Map<String, dynamic>> cartItems = [];

    for (var cart in cartList) {
      cartItems.add(cart.toJson());
    }
    Map<String, dynamic> data = {
      "cart": cartItems,
      "table_id":
          num.parse(TablesController.to.selectedTable?.id.toString() ?? ''),
      "bar_id": num.parse(TablesController.to.selectedBar?.id.toString() ?? ''),
      "server_id": 1,
      "branch_id": 1,
      "number_of_people": TablesController.to.selectedGuestNumbers,
      "payment_status": "unpaid",
      "payment_method": "pay_after_eating",
      "order_amount": cartTotalAmount.toStringAsFixed(2),
      "gratuity_amount": 0,
      "gst_amount": cartGSTAmount.toStringAsFixed(2),
      "pst_amount": cartPSTAmount.toStringAsFixed(2),
      "order_note": kitchenNoteTEC.text,
    };
    try {
      kLogger.i(data);
      PopupDialog.showLoadingDialog();
      var res = await Dio().post(
        URLS.placeOrder,
        data: data,
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        PopupDialog.showSuccessDialog("Order placed successfully!");
        TablesController.to.getTables();
        OrdersController.to.getOrders();
      } else if (res.statusCode == 403) {
        PopupDialog.showErrorMessage("Failed to place order!");
      }
      kLogger.i("response: ${res.data}");
      PopupDialog.closeLoadingDialog();
    } catch (e) {
      kLogger.e('Error from %%%% login %%%% => $e');
      PopupDialog.closeLoadingDialog();
    }
  }

  @override
  void onInit() {
    // getCategory();
    // getProduct();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
