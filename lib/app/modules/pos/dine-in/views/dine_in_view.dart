import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:get/get.dart';
import '../widgets/available_table.dart';
import '../widgets/booked_table.dart';
import '../widgets/table_availability_header.dart';
import '../widgets/table_body.dart';

class DineInView extends GetView<DineInController> {
  const DineInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TableAvailabilityHeader(),
        SizedBox(height: 12.0),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TableBody(
                  isScrollable: false,
                ),
              ),
              SizedBox(width: 30),
              // Expanded(
              // flex: 2,
              //   child: Obx(() {
              //     if (controller.currentTableNumber.value == -1) {
              //       return const SizedBox.shrink();
              //     }
              //     return Visibility(
              //       visible:true,
              //       // Available table
              //       replacement: AvailableTableOption(controller: controller),
              //       // Booked table
              //       child: BookedTableOption(controller: controller),
              //     );
              //   }),
              // ),
              // cart area
            ],
          ),
        ),
      ],
    );
  }
}
