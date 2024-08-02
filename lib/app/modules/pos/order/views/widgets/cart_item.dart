import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/custom_inkwell.dart';
import '../../../../../widgets/my_custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.title,
    required this.serveFirst,
    required this.togo,
    required this.dontMake,
    required this.rush,
    required this.heat,
    required this.note,
    required this.amount,
    required this.quantity,
    this.onRemove,
    this.onDecrement,
    this.onIncrement,
  });

  final String title;
  final String serveFirst;
  final String togo;
  final String dontMake;
  final String rush;
  final String heat;
  final String note;
  final num amount;
  final num quantity;
  final VoidCallback? onRemove;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCustomText(
                      title,
                      fontWeight: FontWeight.bold,
                      maxLines: 2,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 4),
                    _modifiers(theme, serveFirst),
                    _modifiers(theme, togo),
                    _modifiers(theme, dontMake),
                    _modifiers(theme, rush),
                    _modifiers(theme, heat, title: "HEATE: "),
                  ],
                ),
              ),

              const SizedBox(width: 4),
              // btns
              Row(
                children: [
                  PrimaryBtnWithChild(
                    onPressed: onDecrement!,
                    width: 29,
                    height: 29,
                    padding: const EdgeInsets.all(4),
                    child: const Center(
                        child: Icon(
                      Icons.remove,
                      size: 16,
                    )),
                  ),
                  Container(
                    width: 40,
                    height: 28,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: theme.hintColor)),
                    child: Center(
                      child: MyCustomText(
                        quantity.toString(),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  PrimaryBtnWithChild(
                    onPressed: onIncrement!,
                    width: 29,
                    height: 29,
                    padding: const EdgeInsets.all(4),
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      size: 16,
                    )),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // amount
              SizedBox(
                width: 70,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    child: Text(
                      "\$${amount.toStringAsFixed(2)}",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4.0),
              CustomInkWell(
                onTap: onRemove,
                child: Icon(
                  Icons.delete,
                  color: theme.colorScheme.error,
                  size: 22,
                ),
              ),
            ],
          ),
          _modifiers(theme, note,
              maxLines: 5, isItalic: true, title: "NOTE : "),
        ],
      ),
    );
  }

  Widget _modifiers(ThemeData theme, String value,
      {int maxLines = 2, bool isItalic = false, String? title}) {
    return Visibility(
      visible: value.contains(':') ? value.length > 6 : value != '',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
        child: Text.rich(
            maxLines: maxLines,
            style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
            TextSpan(text: title, children: [
              TextSpan(
                text: value.trim(),
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
              ),
            ])),
      ),
    );
  }
}
