import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/order/models/product_model.dart';
import 'package:flutter_base/app/modules/pos/order/models/variation_model.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';

class VariationsCard extends StatefulWidget {
  final List<VariationModel> data;
  const VariationsCard({super.key, required this.data});

  @override
  State<VariationsCard> createState() => _VariationsCardState();
}

class _VariationsCardState extends State<VariationsCard> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.data.length,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: PrimaryBtn(
              onPressed: () {
                setState(() {
                  activeIndex = index;
                });
                // c.setSelectedOrderModifiersIndex(index);
              },
              text: widget.data[index].name,
              isOutline: true,
              color: activeIndex == index
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
