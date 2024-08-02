import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/controllers/tables_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in-orders/controllers/dine_in_order_controller.dart';
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
    const double titleFontSize = 16;
    // const double contentFontSize = 14;
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
                'No',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Table No.',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  flex: 1,
                  child: MyCustomText(
                    'User Name',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Auth Code',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  flex: 2,
                  child: MyCustomText(
                    'Order Date',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Order Type',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Order Status',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Total Amount',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(width: 4.0),
              Expanded(
                  child: MyCustomText(
                'Actions',
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              )),
            ],
          ),
        ),
        GetBuilder<DineInOrderController>(builder: (controller) {
          return Column(
            children: List.generate(
              controller.orderList.length,
              (index) {
                var order = controller.orderList[index];
                if (controller.orderList.isEmpty) {
                  return Container(
                    width: 200,
                    color: Colors.red,
                    height: 23,
                  );
                }
                return OrderTableDataRow(
                  onOrderDetails: () {
                    // TablesController.to.updateIsShowOrderDetails(true);
                  },
                  onPrint: () {
                    customAlertDialog(
                      contentPadding: const EdgeInsets.all(12),
                      context: context,
                      child: _printReceipt(),
                    );
                  },
                  id: order.id,
                  sl: index + 1,
                  tableNo: order.table?.tableName ?? "",

                  userName: "${order.employee?.firstName}",
                  orderId: "${order.orderId}",
                  orderDateTime: DateFormat('MMM d, yyyy h:mm a')
                      .format(order.createdAt ?? DateTime.now()),

                  // authCode: order.authorizationCode ?? 'null',
                  // orderId: order.id ?? 0,
                  // orderDateTime:
                  //     '${order..toString().split(' ').first} ${order.deliveryTime}',
                  orderType: order.orderType,
                  orderStatus: order.orderStatus,
                  totalAmount: order.totalOrderAmount.toDouble(),
                  paymetStatus: order.paymentStatus,
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _printReceipt() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyCustomText(
                'Print Invoice',
                fontWeight: FontWeight.w600,
              ),
              IconButton(
                  onPressed: Get.back,
                  icon: const Icon(
                    FontAwesomeIcons.xmark,
                    size: 14,
                  ))
            ],
          ),
          GetBuilder<OrdersController>(builder: (c) {
            return Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                  // child: PrimaryBtn(
                  //     onPressed: () {},
                  //     text: 'Customer Copy',
                  //     textColor: Colors.white),
                ),
                const SizedBox(width: 6.0),
                const Expanded(
                  child: SizedBox(),
                  // child: PrimaryBtn(
                  //     onPressed: () {},
                  //     text: 'Marchent Copy',
                  //     textColor: Colors.white),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: PrimaryBtn(
                      onPressed: () async {
                        c.printReceipt();
                      },
                      text: 'Print Both',
                      textColor: Colors.white),
                ),
                const SizedBox(width: 6.0),
              ],
            );
          }),
          Divider(
            color: Colors.grey.shade400,
            height: 30,
          ),
          SvgPicture.asset(
            'assets/images/splash/login_logo.svg',
            height: 100,
          ),
          const MyCustomText(
            '7488 King George Blvd.',
            fontWeight: FontWeight.w600,
            height: 2,
          ),
          const MyCustomText(
            'Unit 350, Surrey, B.C. V3W 0H9',
            fontWeight: FontWeight.w600,
          ),
          const MyCustomText(
            'Phone: 604-706-0109',
            fontWeight: FontWeight.w600,
            height: 3,
          ),
          const Divider(color: Colors.black54),
          const SizedBox(height: 10.0),
          const Row(
            children: [
              Expanded(child: MyCustomText('Order: 100089')),
              SizedBox(width: 10.0),
              Expanded(child: MyCustomText('Jun.04,24;11:04am')),
            ],
          ),
          const SizedBox(height: 6.0),
          const Row(
            children: [
              Expanded(child: MyCustomText('Server: Haveli')),
              SizedBox(width: 10.0),
              Expanded(child: MyCustomText('Station: 1')),
            ],
          ),
          const SizedBox(height: 6.0),
          const Row(
            children: [
              Expanded(child: MyCustomText('Table: 23')),
              SizedBox(width: 10.0),
              Expanded(child: MyCustomText('Guests: 3')),
            ],
          ),
          const SizedBox(height: 6.0),
          const Row(
            children: [
              Expanded(child: MyCustomText('Server: Haveli')),
              SizedBox(width: 10.0),
              Expanded(child: MyCustomText('Station: 1')),
            ],
          ),
          const SizedBox(height: 6.0),
          const Row(
            children: [
              Expanded(child: MyCustomText('Type: Dine-In')),
              SizedBox(width: 10.0),
              Expanded(child: MyCustomText('')),
            ],
          ),
          const SizedBox(height: 16.0),
          const Row(
            children: [
              Expanded(flex: 1, child: MyCustomText('QTY', fontSize: 18)),
              SizedBox(width: 10.0),
              Expanded(flex: 3, child: MyCustomText('Item', fontSize: 18)),
              SizedBox(width: 10.0),
              Expanded(flex: 1, child: MyCustomText('AMT', fontSize: 18)),
            ],
          ),
          const Divider(color: Colors.black54, height: 25),
          const Row(
            children: [
              Expanded(flex: 1, child: MyCustomText('4', fontSize: 18)),
              SizedBox(width: 10.0),
              Expanded(
                  flex: 3,
                  child: MyCustomText('BHINDI DO PYAZA', fontSize: 18)),
              SizedBox(width: 10.0),
              Expanded(flex: 1, child: MyCustomText('\$67.96', fontSize: 18)),
            ],
          ),
          const Divider(color: Colors.black54, height: 25),
          const SizedBox(height: 10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCustomText('Sub total'),
              SizedBox(width: 10.0),
              MyCustomText('\$67.96'),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCustomText('GST 5%'),
              SizedBox(width: 10.0),
              MyCustomText('\$3.40'),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCustomText('Tip'),
              SizedBox(width: 10.0),
              MyCustomText('\$5.00'),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCustomText('Total (PAID)', fontSize: 20),
              SizedBox(width: 10.0),
              MyCustomText('\$76.36', fontSize: 20),
            ],
          ),
          const SizedBox(height: 14.0),
          const Divider(
            color: Colors.black54,
            height: 20,
          ),
          const MyCustomText(
            'Customer Copy',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          const SizedBox(height: 4.0),
          const MyCustomText(
            'Visa Credit Card Sale',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          const Divider(
            color: Colors.black54,
            height: 20,
          ),
          const MyCustomText(
            'Thank you for visiting HAVELI BISTRO',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          const Divider(
            color: Colors.black54,
            height: 20,
          ),
          const MyCustomText(
            'Please review us on Google',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          const Divider(
            color: Colors.black54,
            height: 20,
          ),
          const MyCustomText(
            'GST NUMBER: GST 717783914 RT0001',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ],
      ),
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
              await controller.getOrder();
              PopupDialog.closeLoadingDialog();
            } else {
              PopupDialog.showErrorMessage("Search field is empty");
            }
          },
          text: 'Search',
          textColor: Colors.white,
        )),
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
                    await controller.getOrder(
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
              await controller.getOrder(
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
