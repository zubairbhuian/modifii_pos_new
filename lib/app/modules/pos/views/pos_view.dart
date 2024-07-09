import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/views/pages/table_order/table_order_page.dart';
import 'package:flutter_base/app/modules/pos/views/pages/tables/tables_page.dart';
import 'package:flutter_base/app/widgets/app_drawer.dart';
import 'package:flutter_base/app/widgets/appbar.dart';
import 'package:get/get.dart';
import '../controllers/pos_controller.dart';
import 'pages/pos/pos_page.dart';
import 'pages/takeout/takeout_page.dart';

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
            PosPage(),
            TableOrderPage(),
            TablesPage(),
            TakeOutPage(),
          ],
        ),
      ),
    );
  }
}
