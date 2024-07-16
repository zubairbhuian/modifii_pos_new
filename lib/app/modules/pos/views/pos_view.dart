import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/order/views/order_view.dart';
import 'package:flutter_base/app/modules/pos/takeout/views/takeout_view.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/views/dine_in_order_view.dart';
import 'package:flutter_base/app/modules/pos/dine-in/views/dine_in_view.dart';
import 'package:flutter_base/app/widgets/app_drawer.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:get/get.dart';
import '../controllers/pos_controller.dart';

class PosView extends GetView<PosController> {
  const PosView({super.key});
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(
        isLeading: false,
      ),
      // drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (value) {},
          children: const [
            // TableOrderPage(),
            OrderView(),
            DineInOrderView(),
            DineInView(),
            TakeOutView(),
          ],
        ),
      ),
    );
  }
}
