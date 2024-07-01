import 'package:flutter/material.dart';
import 'package:flutter_base/app/utils/my_func.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';
import '../../../../../../utils/static_colors.dart';
import '../../../../../../widgets/custom_btn.dart';
import '../../../../controllers/tables_controller.dart';

class TableBody extends GetView<TablesController> {
  const TableBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return _body(theme);
  }

  //** Body **
  Widget _body(ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _title('Bar Area'),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 110,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: controller.allBarsList.length,
              itemBuilder: (context, index) {
                var table = controller.allBarsList[index];
                return Obx(
                  () => Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: controller.barTableActiveIndex.value == index
                          ? StaticColors.blueLightColor
                          : Colors.transparent,
                    ),
                    child: PrimaryBtnWithChild(
                      onPressed: () {
                        controller.onActiveTable(
                            tableType: "Bar Area", index: index, table: table);
                      },
                      height: 75,
                      width: 75,
                      padding: const EdgeInsets.all(10.0),
                      color: MyFunc.getTableColorWithStatus(table.status),
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyCustomText(
                                '${table.number}',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              MyCustomText(
                                '${table.capacity}',
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: table.status == 2,
                            child: const MyCustomText(
                              'username',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: table.status == 2,
                            child: const MyCustomText(
                              '\$34.99',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          /*******Dine IN******** */
          _title('Dine-In Area'),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 110,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: controller.tablesList.length,
              itemBuilder: (context, index) {
                var table = controller.tablesList[index];
                return Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: controller.dineInTableActiveIndex.value == index
                          ? StaticColors.blueLightColor
                          : Colors.transparent,
                    ),
                    child: PrimaryBtnWithChild(
                      onPressed: () {
                        controller.onActiveTable(
                            tableType: "Dine-In Area",
                            index: index,
                            table: table);
                      },
                      height: 75,
                      width: 75,
                      padding: const EdgeInsets.all(10.0),
                      color: MyFunc.getTableColorWithStatus(table.status),
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                      // text: controller.tablesList[index].tableNo,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyCustomText(
                                '${table.number}',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              MyCustomText(
                                '${table.capacity}',
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: table.reservationType != null,
                            child: const MyCustomText(
                              'username',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: table.reservationType != null,
                            child: const MyCustomText(
                              '\$34.99',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          /*******Hall Area******** */
          _title('Hall Area'),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 110,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: controller.hallsList.length,
              itemBuilder: (context, index) {
                var table = controller.hallsList[index];
                return Obx(
                  () => Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: controller.halTableActiveIndex.value == index
                          ? StaticColors.blueLightColor
                          : Colors.transparent,
                    ),
                    child: PrimaryBtnWithChild(
                      onPressed: () {
                        controller.onActiveTable(
                            tableType: "Hall Area", index: index, table: table);
                      },
                      height: 75,
                      width: 75,
                      padding: const EdgeInsets.all(10.0),
                      color: MyFunc.getTableColorWithStatus(table.status),
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                      // text: controller.tablesList[index].tableNo,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyCustomText(
                                '${table.number}',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              MyCustomText(
                                '${table.capacity}',
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const Visibility(
                            visible: false,
                            child: MyCustomText(
                              'username',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const Visibility(
                            visible: false,
                            child: MyCustomText(
                              '\$34.99',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _title(String title) {
    return Container(
      height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: StaticColors.blackLightColor,
      child: Center(
        child: MyCustomText(
          title,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
