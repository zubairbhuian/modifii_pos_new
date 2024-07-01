import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_inkwell.dart';
import 'package:get/get.dart';

class CustomTableItem extends StatefulWidget {
  final bool isHeader;
  const CustomTableItem({super.key, this.isHeader = false});

  @override
  State<CustomTableItem> createState() => _CustomTableItemState();
}

class _CustomTableItemState extends State<CustomTableItem> {
  bool isSelected = false;
  void onChangeSelection() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomInkWell(
      onTap: widget.isHeader == true ? null : onChangeSelection,
      child: Container(
        //padding
        padding:
            EdgeInsets.symmetric(vertical: widget.isHeader == true ? 0 : 6),
        // bg color
        color: widget.isHeader
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
                widget.isHeader == true ? "SL" : "",
                style: widget.isHeader == true
                    ? theme.textTheme.labelMedium
                    : theme.textTheme.bodyLarge,
              ),
            ).marginAll(10),
            // item (Checkbox)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    onChangeSelection();
                  }),
            ),
            // item 3
            Expanded(
              child: SizedBox(
                // width: 100,
                child: Text(
                  widget.isHeader == true
                      ? "Items"
                      : "Name of the item fsdfsdfsdf",
                  style: widget.isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.titleSmall,
                ),
              ).marginAll(10),
            ),
            // item  4
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  widget.isHeader == true ? "Qty" : "3",
                  style: widget.isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                ),
              ),
            ).marginAll(10),
            // item 5
            Expanded(
              child: SizedBox(
                // width: 100,
                child: Text(
                  widget.isHeader == true ? "Price" : "234",
                  style: widget.isHeader == true
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
                  widget.isHeader == true ? "Discount" : "23",
                  style: widget.isHeader == true
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
                  widget.isHeader == true ? "Tax" : "23",
                  style: widget.isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                ),
              ).marginAll(10),
            ),
            // item 8
            Expanded(
              child: SizedBox(
                // width: 100,
                child: Text(
                  widget.isHeader == true ? "Totel Price" : "13",
                  style: widget.isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                ),
              ).marginAll(10),
            ),
          ],
        ),
      ),
    );
  }
}
