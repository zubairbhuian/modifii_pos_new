// import 'package:flutter/material.dart';
// import '../../order/models/order_model.dart';

// class SplitCheck extends StatelessWidget {
//   const SplitCheck({super.key, required this.order});

//   final OrderModel order;
//   final int index;
//   final int totalCheck;

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);

//     return Container(
//       color: theme.cardColor,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // header
//           Text(
//             'Order: #${order.orderId}-SC${index + 1}',
//             style: theme.textTheme.titleSmall,
//           ),
//           Divider(
//             color: theme.dividerColor.withOpacity(0.4),
//             height: 16,
//           ),
//           Text(
//             'Dine in: Guest ${index + 1}',
//             style: theme.textTheme.titleSmall,
//           ),

//           Divider(
//             color: theme.dividerColor.withOpacity(0.4),
//             height: 16,
//           ),
//           _priceRow(theme,
//               title: "Total Amount",
//               value: "\$${order.totalOrderAmount.toStringAsFixed(2)}"),
//           Divider(
//             color: theme.dividerColor.withOpacity(0.4),
//             height: 16,
//           ),
//           _priceRow(theme,
//               title: "Split Amount",
//               value:
//                   "\$${((order.totalOrderAmount) / c.splitCheckCount).toStringAsFixed(2)}"),
//           Divider(
//             color: theme.dividerColor.withOpacity(0.4),
//             height: 16,
//           ),
//           _priceRow(theme,
//               title: "Total Due",
//               value:
//                   "\$${((order.totalOrderAmount) / c.splitCheckCount).toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           PrimaryBtn(
//             onPressed: () {},
//             text: 'PRINT CHECK',
//             width: double.infinity,
//             textColor: Colors.white,
//             color: StaticColors.blueLightColor,
//           ),
//           const SizedBox(height: 8),
//           PrimaryBtn(
//             onPressed: () {
//               controller.splitPaymentActiveIndex.value = -1;
//               controller.paymentMathodActiveIndex.value = -1;
//               controller.isShowsplitPaymentbtn.value = false;
//               controller.splitPaymentActiveIndex.value = index;
//             },
//             width: double.infinity,
//             text: 'PAY',
//             textColor: Colors.white,
//             color: StaticColors.greenColor,
//           ),
//           const SizedBox(height: 8),
//           // payment method
//           Obx(() {
//             if (controller.splitPaymentActiveIndex.value == index) {
//               return Wrap(
//                   spacing: 8,
//                   runSpacing: 12,
//                   children: List.generate(
//                     controller.paymentMathod.length,
//                     (index) {
//                       var data = controller.paymentMathod[index];
//                       return Obx(() {
//                         return PrimaryBtn(
//                           color: theme.scaffoldBackgroundColor,
//                           onPressed: () {
//                             controller.paymentMathodActiveIndex.value = index;
//                             TableDialogs.makePayment();
//                           },
//                           text: data,
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: theme.colorScheme.background),
//                           borderColor:
//                               controller.paymentMathodActiveIndex.value == index
//                                   ? theme.primaryColor
//                                   : theme.disabledColor,
//                         );
//                       });
//                     },
//                   ));
//             }
//             return const SizedBox();
//           }),
//         ],
//       ),
//     );
//   }
// }
