// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base/app/modules/pos/dine-in/views/order_details.dart';
// import 'package:flutter_base/app/modules/pos/dine-in/views/split_order.dart';
// import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_dialog.dart';
// import 'package:flutter_base/app/utils/my_func.dart';
// import 'package:flutter_base/app/utils/static_colors.dart';
// import 'package:flutter_base/app/widgets/custom_btn.dart';
// import 'package:flutter_base/app/widgets/custom_loading.dart';
// import 'package:flutter_base/app/widgets/my_custom_text.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import '../../../../widgets/custom_alert_dialog.dart';
// import '../../controllers/tables_controller.dart';

// class BookedTableOption extends GetView<TablesController> {
//   const BookedTableOption({
//     super.key,
//     required this.controller,
//   });

//   @override
//   final TablesController controller;

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     bool smallHeight = MediaQuery.sizeOf(context).height < 700;
//     return GetBuilder<TablesController>(builder: (c) {
//       if (c.currentOrderData == null) return const CustomLoading();
//       // is there is data
//       return Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.white),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             //Top Row
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // _columnText('Order', '${c.currentOrderData?.id}'),
//                 // _columnText('Server', '${c.currentOrderData?.serverName}'),
//                 // _columnText('Guests', '3'),
//                 // _columnText(
//                 //     'Status',
//                 //     MyFunc.getStatusWithStatusCode(
//                 //         c.currentOrderData?.server?.status)),
//                 _columnText('Customer', 'Walk-In\nCustomer'),
//               ],
//             ),
//             SizedBox(height: smallHeight ? 0 : 14),
//             //Buttons Row
//             Row(
//               children: [
//                 Expanded(
//                   child: PrimaryBtn(
//                     onPressed: () {
//                       Get.to(() => const OrderDetails());
//                       // _bookedTableOptionsDialog(context, isGotoOrder: true);
//                     },
//                     color: StaticColors.greenColor,
//                     textColor: Colors.white,
//                     text: 'Go to Order',
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: PrimaryBtn(
//                     onPressed: () {
//                       // controller.selectedTableId = null;
//                       // controller.selectedBarId = null;
//                       // if (controller.barTableActiveIndex.value > 0) {
//                       //   controller.selectedBarId =
//                       //       controller.currentTableId.value.toString();
//                       //   controller.updateSelectedBarId;
//                       // } else if (controller.dineInTableActiveIndex.value > 0) {
//                       //   Logger().e("di");
//                       //   controller.selectedTableId =
//                       //       controller.currentTableId.value.toString();
//                       //   controller.updateSelectedTableId;
//                       // } else if (controller.halTableActiveIndex.value > 0) {
//                       //   Logger().e("hall");

//                       //   // controller.selectedBarId =
//                       //   //     controller.currentTableId.value.toString();
//                       //   // controller.updateSelectedBarId;
//                       //   // controller.selectedTableId =
//                       //   //     controller.currentTableId.value.toString();
//                       //   // controller.updateSelectedTableId;
//                       // }
//                       // controller.onAddIrem(c.currentOrderData?.details ?? []);
//                     },
//                     color: StaticColors.orangeColor,
//                     textColor: Colors.white,
//                     text: 'Add Items',
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: PrimaryBtn(
//                     onPressed: () {
//                       _bookedTableOptionsDialog(context, isPrintCheck: true);
//                     },
//                     color: StaticColors.blueLightColor,
//                     textColor: Colors.white,
//                     text: 'Print Check',
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: PrimaryBtn(
//                     onPressed: () {
//                       Get.to(() => const SplitOrder());
//                     },
//                     color: StaticColors.purpleColor,
//                     textColor: Colors.white,
//                     text: 'Split Order',
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 PrimaryBtn(
//                   onPressed: () {
//                     controller.isShowTablePaymentbtn.value =
//                         !controller.isShowTablePaymentbtn.value;
//                   },
//                   height: 48,
//                   text: 'Pay',
//                   width: 70,
//                   textColor: Colors.white,
//                   color: StaticColors.greenColor,
//                 ),
//               ],
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(children: [
//                   // payment method
//                   const SizedBox(height: 16),
//                   Obx(() {
//                     if (controller.isShowTablePaymentbtn.value == true) {
//                       return Wrap(
//                           spacing: 8,
//                           runSpacing: 12,
//                           children: List.generate(
//                             controller.paymentMathod.length,
//                             (index) {
//                               var data = controller.paymentMathod[index];
//                               return Obx(() {
//                                 return PrimaryBtn(
//                                   color: theme.scaffoldBackgroundColor,
//                                   onPressed: () {
//                                     controller.paymentMathodActiveIndex.value =
//                                         index;
//                                     // dialog
//                                     TableDialogs.makePayment();
//                                   },
//                                   text: data,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12),
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       color: theme.primaryColorDark),
//                                   borderColor: controller
//                                               .paymentMathodActiveIndex.value ==
//                                           index
//                                       ? theme.primaryColor
//                                       : theme.disabledColor,
//                                       isOutline: true,
//                                 );
//                               });
//                             },
//                           ));
//                     }
//                     return const SizedBox();
//                   }),
//                   const SizedBox(height: 14),
//                   const Divider(),
//                   //Items List
//                   const Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(flex: 1, child: MyCustomText('SL.')),
//                       Expanded(flex: 4, child: MyCustomText('Items')),
//                       Expanded(flex: 1, child: MyCustomText('Qty')),
//                       Expanded(flex: 1, child: MyCustomText('Price')),
//                     ],
//                   ),

//                   const Divider(),
//                   const SizedBox(height: 8),
//                   ...List.generate(
//                     c.currentOrderData?.details.length ?? 0,
//                     (index) {
//                       var data = c.currentOrderData?.details[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: MyCustomText('${index + 1}'),
//                             ),
//                             Expanded(
//                               flex: 4,
//                               child: Row(
//                                 children: [
//                                   AutoSizeText(
//                                     data?.productDetails?.name ?? "",
//                                     maxFontSize: 16,
//                                     minFontSize: 10,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   // const AutoSizeText(
//                                   //   ' (Heat: Medium)',
//                                   //   maxFontSize: 14,
//                                   //   minFontSize: 10,
//                                   //   style: TextStyle(
//                                   //     fontWeight: FontWeight.w400,
//                                   //     fontStyle: FontStyle.italic,
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: MyCustomText("${data?.quantity}"),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: MyCustomText("${data?.price}"),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   //Amounts
//                   const Divider(),
//                   _row(theme,
//                       title: "Subtotal :",
//                       value: "${c.currentOrderData?.addonSubTotal}"),
//                   _row(theme,
//                       title: "GST 5% :",
//                       value: "${c.currentOrderData?.addonGst}"),
//                   const Divider(),
//                   _row(theme,
//                       title: "Total :",
//                       value: "${c.currentOrderData?.addonSubTotal}",
//                       fontSize: 20),
//                   SizedBox(height: smallHeight ? 0 : 14),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Expanded _columnText(String label, String value) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 2.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             MyCustomText(label),
//             MyCustomText(
//               value,
//               fontWeight: FontWeight.w500,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // row
// Widget _row(ThemeData theme,
//     {double? fontSize, required String title, required String value}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//     child: Row(
//       children: [
//         Expanded(
//             child: Text(
//           title,
//           style: theme.textTheme.titleSmall
//               ?.copyWith(fontSize: fontSize ?? 16, fontWeight: FontWeight.w700),
//         )),
//         Text(
//           value,
//           style: theme.textTheme.titleSmall
//               ?.copyWith(fontSize: fontSize ?? 16, fontWeight: FontWeight.w700),
//         ),
//       ],
//     ),
//   );
// }

// //Alert Dialog for booking buttons
// void _bookedTableOptionsDialog(
//   BuildContext context, {
//   bool isGotoOrder = false,
//   bool isAddItem = false,
//   bool isPrintCheck = false,
//   bool isSplitOrder = false,
// }) {
//   if (isSplitOrder) {
//     return customAlertDialog(
//       context: context,
//       child: SizedBox(
//         height: MediaQuery.sizeOf(context).height,
//         width: MediaQuery.sizeOf(context).width,
//         child: Stack(
//           alignment: Alignment.topRight,
//           clipBehavior: Clip.none,
//           children: [
//             // const SplitOrder(),
//             IconButton(
//               onPressed: Get.back,
//               icon: const Icon(
//                 FontAwesomeIcons.circleXmark,
//                 color: Colors.redAccent,
//                 size: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   return customAlertDialog(
//     context: context,
//     child: const Center(
//       child: Icon(Icons.warning, color: Colors.amber),
//     ),
//   );
// }
