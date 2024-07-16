import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_place_model.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class CustomOrderDialogOptions extends StatefulWidget {
  final String productType;
  const CustomOrderDialogOptions({super.key, required this.productType});

  @override
  State<CustomOrderDialogOptions> createState() =>
      _CustomOrderDialogOptionsState();
}

class _CustomOrderDialogOptionsState extends State<CustomOrderDialogOptions> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // int variationsActiveIndex = -1;
  // int orderTypeActiveIndex = 0;
  // int orderType2ActiveIndex = 0;
  int quantity = 1;
  num orderTotalPrice = 0;

  //** Calculate Price **
  void onCalculatTotalPrice(String value) {
    if (value.isNotEmpty) {
      orderTotalPrice = num.parse(value) * quantity;
    } else {
      orderTotalPrice = 0;
    }
    setState(() {});
  }

  //** Update quantity **
  void updateOrderQuantity(bool isIncrease) {
    if (_priceController.text.isNotEmpty) {
      if (isIncrease && quantity < 10) {
        quantity++;
        orderTotalPrice = num.parse(_priceController.text) * quantity;
      } else if (!isIncrease && quantity > 1) {
        quantity--;
        orderTotalPrice = num.parse(_priceController.text) * quantity;
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCustomText(
                    'Product Name',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    controller: _nameController,
                    maxLines: 1,
                    isFilled: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCustomText(
                    'Price',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    controller: _priceController,
                    maxLines: 1,
                    isFilled: true,
                    onChange: (value) {
                      onCalculatTotalPrice(value);
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        //description
        MyCustomText(
          'Description',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).hintColor,
        ),
        const SizedBox(height: 4),
        CustomTextField(
          controller: _descriptionController,
          maxLines: 5,
          isFilled: true,
        ),
        const SizedBox(height: 14),
        //quantity row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: MyCustomText(
                'Quantity',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryBtnWithChild(
                    onPressed: () {
                      updateOrderQuantity(
                        false,
                      );
                    },
                    width: 48,
                    child: const Icon(
                      Icons.remove,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 65,
                    child: Center(
                      child: MyCustomText(
                        quantity.toString(),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PrimaryBtnWithChild(
                    onPressed: () {
                      updateOrderQuantity(true);
                    },
                    width: 48,
                    child: const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: MyCustomText(
                  '\$${orderTotalPrice.toStringAsFixed(2)}',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        //order button
        Center(
          child: PrimaryBtn(
            onPressed: () {
              CartModel item = CartModel(
                  id: "custom_food",
                  name: _nameController.text,
                  description: _descriptionController.text,
                  // type: widget.productType,
                  price: num.parse(_priceController.text),
                  quantity: quantity,
                  kitchenNote: ""
                  
                  );
              if (_nameController.text.isEmpty) {
                PopupDialog.showErrorMessage(
                    "Name Field Is Required For ${widget.productType}");
              } else if (_priceController.text.isEmpty) {
                PopupDialog.showErrorMessage(
                    "Price Field Is Required For ${widget.productType}");
              } else if (_descriptionController.text.isEmpty) {
                PopupDialog.showErrorMessage(
                    "Description Field Is Required For ${widget.productType}");
              } else {
                PosController.to.onAddCartItem(item);
                Get.back();
                // PopupDialog.showSuccessDialog("Cart Items Added Successfully");
              }
            },
            text: 'Add',
            textColor: Colors.white,
            textMaxSize: 20,
            textMinSize: 16,
          ),
        ),
      ],
    );
  }
}
