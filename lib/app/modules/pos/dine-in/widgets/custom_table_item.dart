import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_inkwell.dart';
import 'package:get/get.dart';

class CustomTableItem extends StatelessWidget {
  final bool isHeader;
  final String name;
  final String sl;
  final String qty;
  final String price;
  final String discount;
  final String tax;
  final String totalPrice;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final dynamic Function()? onTap;
  const CustomTableItem(
      {super.key,
      this.isHeader = false,
      this.sl = "",
      this.name = "",
      this.qty = "",
      this.price = "",
      this.discount = "",
      this.tax = "",
      this.totalPrice = "",
      this.onTap,
      this.isSelected = true,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomInkWell(
      onTap: isHeader == true ? null : onTap,
      child: Container(
        //padding
        padding: EdgeInsets.symmetric(vertical: isHeader == true ? 0 : 6),
        // bg color
        color: isHeader
            ? theme.disabledColor.withOpacity(0.5)
            : isSelected
                ? StaticColors.blueColor.withOpacity(.1)
                : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // item
            SizedBox(
              width: 30,
              child: Text(
                isHeader == true ? "No" : sl,
                style: isHeader == true
                    ? theme.textTheme.labelMedium
                    : theme.textTheme.bodyLarge,
              ),
            ).marginAll(10),
            // item (Checkbox)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Checkbox(value: isSelected, onChanged: onChanged),
            ),
            // item 3
            Expanded(
              flex: 2,
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Items" : name,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.titleSmall,
                ),
              ).marginAll(10),
            ),
            // item  4
            Expanded(
              child: SizedBox(
                child: Center(
                  child: Text(
                    isHeader == true ? "Qty" : qty,
                    style: isHeader == true
                        ? theme.textTheme.labelMedium
                        : theme.textTheme.bodyLarge,
                  ),
                ),
              ).marginAll(10),
            ),
            // item 5
            Expanded(
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Price" : price,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                ),
              ).marginAll(10),
            ),
            // item 6
            Expanded(
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Discount" : discount,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                ),
              ).marginAll(10),
            ),
            // item 7
            Expanded(
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Tax" : tax,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                ),
              ).marginAll(10),
            ),
            // item 8
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  // width: 100,
                  child: Text(
                    isHeader == true ? "Total Price" : totalPrice,
                    style: isHeader == true
                        ? theme.textTheme.labelMedium
                        : theme.textTheme.bodyLarge,
                  ),
                ).marginAll(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
