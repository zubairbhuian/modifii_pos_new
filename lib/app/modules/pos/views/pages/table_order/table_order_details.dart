import 'package:flutter/material.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';

class TableOrderDetails extends StatelessWidget {
  const TableOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          _overviewRow(),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.background),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyCustomText('Date Time'),
                                SizedBox(height: 8),
                                MyCustomText('Authorization Code: 123333'),
                              ],
                            ),
                            const Spacer(),
                            const SizedBox(width: 12),
                            PrimaryBtn(
                              onPressed: () {},
                              text: 'Print Check',
                              color: StaticColors.blueLightColor,
                              textColor: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            PrimaryBtn(
                              width: 250,
                              onPressed: () {},
                              text: 'Print Items for Kitchen/Bar',
                              color: StaticColors.greenColor,
                              textColor: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            PrimaryBtn(
                              onPressed: () {},
                              text: 'Discount',
                              color: StaticColors.blueColor,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      _itemsListTable(theme),
                      const SizedBox(height: 22),
                      PrimaryBtn(
                        onPressed: () {},
                        text: 'Split Order',
                        textColor: Colors.white,
                      ),
                      const Divider(height: 50),
                      _prices(context)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.background),
                ),
                padding: const EdgeInsets.all(8),
                child: const Column(
                  children: [
                    MyCustomText('Order setup'),
                    SizedBox(height: 12),
                    MyCustomText('Change Order Status'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Align _prices(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.33,
        child: const Column(
          children: [
            Row(
              children: [
                MyCustomText('Subtotal:'),
                Spacer(),
                MyCustomText('\$16.00'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                MyCustomText('GST:'),
                Spacer(),
                MyCustomText('\$16.00'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                MyCustomText('Tip:'),
                Spacer(),
                MyCustomText('\$16.00'),
              ],
            ),
            Divider(height: 30),
            Row(
              children: [
                MyCustomText('Total:', fontSize: 18),
                Spacer(),
                MyCustomText('\$16.00', fontSize: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _overviewRow() {
    return const Row(
      children: [
        MyCustomText('Order: #100202'),
        SizedBox(width: 28),
        MyCustomText('Item: 2'),
        SizedBox(width: 28),
        MyCustomText('Table: 23'),
        SizedBox(width: 28),
        MyCustomText('Guest: 3'),
        SizedBox(width: 28),
        MyCustomText('Server: Haveli'),
        SizedBox(width: 28),
        MyCustomText('Order Type: Dine'),
      ],
    );
  }

  Column _itemsListTable(ThemeData theme) {
    const double titleFontSize = 16;
    const double contentFontSize = 14;

    //title Row
    return Column(
      children: [
        Container(
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
              Expanded(
                  child: MyCustomText(
                'SL',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  flex: 3,
                  child: MyCustomText(
                    'Items',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Qty',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Price',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Discount',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Tax',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Total Price',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
            ],
          ),
        ),
        ...List.generate(
          2,
          (index) => _itemsTableContentRow(contentFontSize),
        ),
      ],
    );
  }

  Widget _itemsTableContentRow(double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
              child: MyCustomText(
            'SL',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              flex: 3,
              child: MyCustomText(
                'Items',
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            'Qty',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            'Price',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            'Discount',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            'Tax',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(width: 4.0),
          Expanded(
              child: MyCustomText(
            'Total Price',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          )),
        ],
      ),
    );
  }
}
