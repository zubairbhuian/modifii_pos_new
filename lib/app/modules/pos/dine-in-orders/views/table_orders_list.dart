import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/controllers/dine_in_order_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/widgets/order_table_header.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/no_data_found.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import '../../../../utils/static_colors.dart';
import '../../../../widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/my_custom_text.dart';
import '../../controllers/orders_controller.dart';
import '../widgets/order_table_data_row.dart';
import '../widgets/order_table_item.dart';

class TableOrdersList extends GetView<DineInOrderController> {
  const TableOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<DineInOrderController>(builder: (controller) {
            return MyCustomText(
              'All Table Orders         ${controller.pagination?.total}',
              fontSize: 18,
              fontWeight: FontWeight.w800,
            );
          }),
          const SizedBox(height: 24.0),
          _dateRange(context),
          const SizedBox(height: 24.0),
          _orderStatus(theme),
          const SizedBox(height: 24.0),
          _searchAndExportRow(),
          const SizedBox(height: 24.0),
          _orderTable(theme, context),
        ],
      ),
    );
  }

  Widget _orderTable(ThemeData theme, BuildContext context) {
    return Column(
      children: [
        const OrderTableHeader(),
        GetBuilder<DineInOrderController>(builder: (controller) {
          return Column(
            children: List.generate(
              controller.orderList.length,
              (index) {
                var order = controller.orderList[index];
                return OrderTableItem(
                  order: order,
                  no: "${index + 1}",
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _searchAndExportRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomTextField(
              controller: controller.search,
              hintText: 'Search by Order ID, Order Status or Auth Code'),
        ),
        const SizedBox(width: 12.0),
        Expanded(
            child: PrimaryBtn(
          onPressed: () async {
            if (controller.search.text.isNotEmpty) {
              PopupDialog.showLoadingDialog();
              await controller.getAllOrders();
              PopupDialog.closeLoadingDialog();
            } else {
              PopupDialog.showErrorMessage("Search field is empty");
            }
          },
          text: 'Search',
          textColor: Colors.white,
        )),
        const SizedBox(width: 12.0),
        Expanded(child: Obx(() {
          return Row(
            children: [
              PrimaryBtn(
                onPressed: () async {
                  controller.onChangeOrderType(true);
                  PopupDialog.showLoadingDialog();
                  await controller.getAllOrders();
                  PopupDialog.closeLoadingDialog();
                },
                text: "Dine-in",
                textColor: Colors.white,
                color: StaticColors.purpleColor,
                borderColor: controller.isdineInSelected.value
                    ? StaticColors.orangeColor
                    : Colors.transparent,
                isOutline: true,
                borderWidth: 2,
              ),
              const SizedBox(width: 12.0),
              PrimaryBtn(
                onPressed: () async {
                  controller.onChangeOrderType(false);
                  PopupDialog.showLoadingDialog();
                  await controller.getAllOrders(
                      orderType: "Takeout".toUpperCase());
                  PopupDialog.closeLoadingDialog();
                },
                text: "Takeout",
                textColor: Colors.white,
                color: StaticColors.blueColor,
                borderColor: !controller.isdineInSelected.value
                    ? StaticColors.orangeColor
                    : Colors.transparent,
                isOutline: true,
                borderWidth: 2,
              ),
            ],
          );
        })),
        const SizedBox(width: 12.0),
        const Expanded(child: SizedBox()),
        const SizedBox(width: 12.0),
        Expanded(
          child: PrimaryBtnWithChild(
            padding: const EdgeInsets.symmetric(vertical: 20),
            onPressed: () {
              //TODO
            },
            isOutline: true,
            borderColor: StaticColors.orangeColor,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.download,
                  size: 20,
                  color: StaticColors.orangeColor,
                ),
                SizedBox(width: 14),
                MyCustomText(
                  'Export',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: StaticColors.orangeColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateRange(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyCustomText(
          'Select date range',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Expanded(
            //   flex: 2,
            //   child: GetBuilder<TablesController>(builder: (c) {
            //     return MyDropdownBtn(
            //       data: c.branches,
            //       selectedValue: c.selectedBranch,
            //       onChanged: c.updateSelectedBranch,
            //     );
            //   }),
            // ),
            const SizedBox(width: 14),
            Expanded(
              flex: 2,
              child: CustomTextField(
                controller: controller.startDate,
                extraLabel: 'Start Date',
                hintText: 'mm/dd/yyyy',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010, 1),
                    lastDate: DateTime(2050, 12),
                  ).then((date) {
                    controller.startDate.text =
                        DateFormat('MM/dd/yyyy').format(date!);
                    controller.serverStartDate.text =
                        DateFormat('yyyy-MM-dd').format(date);
                  });
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 2,
              child: CustomTextField(
                controller: controller.endDate,
                extraLabel: 'End Date',
                hintText: 'mm/dd/yyyy',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010, 1),
                    lastDate: DateTime(2050, 12),
                  ).then((date) {
                    controller.endDate.text =
                        DateFormat('MM/dd/yyyy').format(date!);
                    controller.serverEndDate.text =
                        DateFormat('yyyy-MM-dd').format(date);
                    // TablesController.to.updateEndDate(date);
                  });
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 1,
              child: PrimaryBtn(
                onPressed: () {
                  controller.endDate.clear();
                  controller.startDate.clear();
                  controller.serverEndDate.clear();
                  controller.serverStartDate.clear();
                },
                text: 'Clear',
                color: Colors.white,
                textColor: Colors.black87,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 1,
              child: PrimaryBtn(
                onPressed: () async {
                  if (controller.serverStartDate.text.isNotEmpty &&
                      controller.serverEndDate.text.isNotEmpty) {
                    PopupDialog.showLoadingDialog();
                    await controller.getAllOrders(
                        endDate: controller.serverEndDate.text,
                        startDate: controller.serverStartDate.text);
                    PopupDialog.closeLoadingDialog();
                  } else {
                    PopupDialog.showErrorMessage(
                        "StartDate and EndDate are required");
                  }
                },
                text: 'Show Data',
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderStatus(ThemeData theme) {
    return GetBuilder<DineInOrderController>(builder: (controller) {
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: List.generate(controller.orderStatusList.length, (index) {
          return InkWell(
            onTap: () async {
              PopupDialog.showLoadingDialog();
              await controller.getAllOrders(
                  orderStatus:
                      controller.orderStatusList[index].status.toUpperCase());
              PopupDialog.closeLoadingDialog();
            },
            child: Container(
              color: theme.dividerColor,
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCustomText(
                    controller.orderStatusList[index].status,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  MyCustomText(
                    controller.orderStatusList[index].count.toString(),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [

    //         const SizedBox(width: 25),
    //         _labelWithValue(label: 'Cooking', value: 33, theme: theme),
    //         const SizedBox(width: 25),
    //         _labelWithValue(label: 'Ready to Serve', value: 33, theme: theme),
    //       ],
    //     ),
    //     const SizedBox(height: 25.0),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         _labelWithValue(label: 'Completed', value: 33, theme: theme),
    //         const SizedBox(width: 25),
    //         _labelWithValue(label: 'Canceled', value: 33, theme: theme),
    //         const SizedBox(width: 25),
    //         _labelWithValue(label: 'Running', value: 33, theme: theme),
    //       ],
    //     ),
    //   ],
    // );
  }
}
