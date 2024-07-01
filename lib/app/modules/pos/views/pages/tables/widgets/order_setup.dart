import 'package:flutter/material.dart';

class OrderSetup extends StatelessWidget {
  const OrderSetup({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
    );
  }
}
