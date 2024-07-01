import 'package:flutter/material.dart';
import 'package:flutter_base/app/utils/my_func.dart';
import '../../../../../../widgets/my_custom_text.dart';

class TableAvailabilityHeader extends StatelessWidget {
  const TableAvailabilityHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const MyCustomText(
          ' Table Availability',
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(width: 10.0),
        ColorTextRow(
          color: MyFunc.getTableColorWithStatus(1),
          text: 'Available',
        ),
        ColorTextRow(
          color: MyFunc.getTableColorWithStatus(2),
          text: 'Walk-In Booking',
        ),
        ColorTextRow(
          color: MyFunc.getTableColorWithStatus(3),
          text: 'Cooking/Serving',
        ),
        ColorTextRow(
          color: MyFunc.getTableColorWithStatus(4),
          text: 'Online Booking',
        ),
        ColorTextRow(
          color: MyFunc.getTableColorWithStatus(5),
          text: 'Combined Tables',
        ),
        ColorTextRow(
          color: MyFunc.getTableColorWithStatus(6),
          text: 'Hold Tables',
        ),
      ],
    );
  }
}

class ColorTextRow extends StatelessWidget {
  const ColorTextRow({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 8,
            backgroundColor: color,
          ),
          const SizedBox(width: 3.0),
          MyCustomText(
            text,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
