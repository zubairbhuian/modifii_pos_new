import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/order/models/order_model.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_textfield.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class CustomOrderDialogOptions extends StatefulWidget {
  final String productType;
  final bool? isLiquor;
  const CustomOrderDialogOptions(
      {super.key, required this.productType, this.isLiquor});

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
                  const MyCustomText(
                    'Product Name',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
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
                  const MyCustomText(
                    'Price',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
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
                      LengthLimitingTextInputFormatter(8),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        //description
        const MyCustomText(
          'Description',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 4),
        CustomTextField(
          controller: _descriptionController,
          maxLines: 10,
          isFilled: true,
        ),
        const SizedBox(height: 26),
        //quantity row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: MyCustomText(
                'Quantity',
                fontSize: 24,
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
                    width: 60,
                    height: 60,
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
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PrimaryBtnWithChild(
                    onPressed: () {
                      updateOrderQuantity(true);
                    },
                    width: 60,
                    height: 60,
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
                  fontSize: 24,
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
                  isLiquor: widget.isLiquor ?? false,
                  isCustomProduct: true,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  // type: widget.productType,
                  price: num.parse(_priceController.text),
                  quantity: quantity,
                  kitchenNote: "");
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
            width: 200,
            height: 80,
            // padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 100),
            text: 'Add',

            textColor: Colors.white,
            textMaxSize: 40,
            textMinSize: 30,
          ),
        ),
      ],
    );
  }
}
