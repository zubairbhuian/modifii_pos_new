import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/static_colors.dart';
import '../../../../widgets/my_custom_text.dart';

class OrderTableDataRow extends StatelessWidget {
  const OrderTableDataRow({
    super.key,
    required this.sl,
    required this.tableNo,
    required this.userName,
    this.authCode = "",
    this.orderDateTime = "",
    required this.orderType,
    required this.orderStatus,
    required this.totalAmount,
    required this.paymetStatus,
    this.onOrderDetails,
    this.onPrint,
  });

  final int sl;
  final String tableNo;
  final String userName;
  final String authCode;
  final String orderDateTime;
  final String orderType;
  final String orderStatus;
  final double totalAmount;
  final String paymetStatus;
  final VoidCallback? onOrderDetails;
  final VoidCallback? onPrint;

  @override
  Widget build(BuildContext context) {
    const double titleFontSize = 16;
    const double contentFontSize = 14;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: MyCustomText(
            sl.toString(),
            fontSize: contentFontSize,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            tableNo.toString(),
            fontSize: contentFontSize,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              flex: 1,
              child: MyCustomText(
                userName,
                fontSize: contentFontSize,
              )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            authCode,
            fontSize: contentFontSize,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              flex: 2,
              child: MyCustomText(
                orderDateTime,
                fontSize: contentFontSize,
              )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            orderType,
            fontSize: contentFontSize,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            orderStatus,
            fontSize: contentFontSize,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: Column(
            children: [
              MyCustomText(
                totalAmount.toStringAsFixed(2),
                fontSize: contentFontSize,
              ),
              const SizedBox(height: 4.0),
              MyCustomText(
                paymetStatus,
                fontSize: titleFontSize,
              ),
            ],
          )),
          const SizedBox(width: 4.0),
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: onOrderDetails,
                  icon: const Icon(
                    FontAwesomeIcons.eye,
                    size: 18,
                    color: StaticColors.orangeColor,
                  ),
                ),
                const SizedBox(width: 4.0),
                IconButton(
                  // onPressed: onPrint,
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.print,
                    size: 18,
                    color: StaticColors.greenColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
