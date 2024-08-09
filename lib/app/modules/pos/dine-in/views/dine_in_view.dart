import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/views/widgets/top_menu.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../widgets/table_availability_header.dart';
import '../widgets/table_body.dart';

class DineInView extends GetView<DineInController> {
  const DineInView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    DineInController.to.getTableCategories();
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopMenu(),
        SizedBox(height: 16),
        TableAvailabilityHeader(),
        SizedBox(height: 12.0),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! dine-in
              Expanded(
                flex: 3,
                child: TableBody(
                  isScrollable: false,
                ),
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
      ],
    );
  }
}
