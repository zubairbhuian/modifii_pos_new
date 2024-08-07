import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';

class OrderTableHeader extends StatelessWidget {
  const OrderTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const double titleFontSize = 16;
    const double gap = 2;
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 2,
            color: theme.colorScheme.background,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      margin: const EdgeInsets.only(bottom: 28),
      child: const Row(
        children: [
          SizedBox(
              width: 50,
              child: MyCustomText(
                'No',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Order No.',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Server',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Table',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          SizedBox(
              width: 200,
              child: Center(
                child: MyCustomText(
                  'Date',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Order Type',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              flex: 2,
              child: Center(
                child: MyCustomText(
                  'Order Status',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Tip',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Discount',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Gratuity',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'GST',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'PST',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Refund',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Recall',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          Expanded(
              child: Center(
            child: MyCustomText(
              'Amount',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(width: gap),
          SizedBox(
              width: 100,
              child: Center(
                child: MyCustomText(
                  'Actions',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
    );
  }
}
