// import 'package:flutter/material.dart';
// import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
// import 'package:flutter_base/app/widgets/custom_btn.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import '../../../widgets/custom_alert_dialog.dart';
// import '../../../widgets/custom_textfield.dart';
// import '../../../widgets/my_custom_text.dart';
// import '../models/product_model.dart';

// class ProductBody extends GetView<PosController> {
//   const ProductBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return _body(theme, context);
//   }

//   //** Header **
//   // Widget _header(ThemeData theme) {
//   //   return Container(
//   //     padding: const EdgeInsets.only(bottom: 20),
//   //     decoration: BoxDecoration(
//   //         border: Border(bottom: BorderSide(color: theme.dividerColor))),
//   //     // height: 115,
//   //     width: double.infinity,
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         // search bar
//   //         SizedBox(
//   //             width: 250,
//   //             child: CustomTextField(
//   //               hintText: "Search Item",
//   //               hintStyle: theme.textTheme.labelLarge?.copyWith(
//   //                   fontWeight: FontWeight.w600, color: theme.dividerColor),
//   //               style: theme.textTheme.labelLarge?.copyWith(
//   //                   fontWeight: FontWeight.w600, color: theme.primaryColorDark),
//   //               prefixIcon: Icon(
//   //                 IconlyBroken.search,
//   //                 color: theme.hintColor,
//   //               ),
//   //             )),
//   //         // 1st
//   //         Row(
//   //           children: [
//   //             PrimaryBtn(
//   //               onPressed: () {
//   //                 controller.getProduct(
//   //                     categoryIds: controller.categoryId, type: "veg");
//   //               },
//   //               color: StaticColors.greenColor,
//   //               child: const Text("Veg"),
//   //             ),
//   //             const SizedBox(width: 10),
//   //             PrimaryBtn(
//   //               onPressed: () {
//   //                 // controller.getCategory(type: 'drinks');
//   //                 controller.getProduct(
//   //                     categoryIds: controller.categoryId, type: "non_veg");
//   //               },
//   //               child: const Text("Non Veg"),
//   //             ),
//   //           ],
//   //         ),
//   //         // 2nd
//   //         Row(
//   //           children: [
//   //             PrimaryBtn(
//   //               onPressed: () {},
//   //               color: StaticColors.blueColor,
//   //               child: const Text("Custom Food"),
//   //             ),
//   //           ],
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }

//   //** Body **
//   Widget _body(ThemeData theme, BuildContext context) {
//     return SingleChildScrollView(child: Obx(() {
//       return StaggeredGrid.count(
//         crossAxisCount: 3,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         children: List.generate(controller.productList.length, (index) {
//           var item = controller.productList[index];
//           return PrimaryBtn(
//             onPressed: () {
//               controller.checkIsDrink(item.productType);
//               controller.orderTotalPrice = item.price.toDouble();
//               controller.orderQuantity = 1;
//               customAlertDialog(
//                 context: context,
//                 child: _dialogOptions(context, item),
//               );
//             },
//             isOutline: true,
//             text: item.name,
//           );
//         }),
//       );
//     }));
//   }

//   SizedBox _dialogOptions(BuildContext context, ProductModel item) {
//     return SizedBox(
//       width: MediaQuery.sizeOf(context).width * 0.4,
//       child: GetBuilder<PosController>(builder: (c) {
//         return Stack(
//           alignment: Alignment.topRight,
//           clipBehavior: Clip.none,
//           children: [
//             //close button
//             const Positioned(
//               top: -35,
//               right: -35,
//               child: Icon(
//                 Icons.cancel,
//                 color: Colors.redAccent,
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 //item name & price
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyCustomText(
//                       item.name,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     MyCustomText(
//                       '\$${item.price}',
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 //description
//                 MyCustomText(
//                   'Description',
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Theme.of(context).hintColor,
//                 ),
//                 const SizedBox(height: 4),
//                 MyCustomText(
//                   item.description == '' ? 'N/A' : item.description,
//                   fontSize: 14,
//                 ),
//                 const SizedBox(height: 14),
//                 //kitchen note
//                 MyCustomText(
//                   'Kitchen Note',
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Theme.of(context).hintColor,
//                 ),
//                 const SizedBox(height: 4),
//                 const CustomTextField(
//                   maxLines: 2,
//                   isFilled: true,
//                 ),
//                 const SizedBox(height: 14),
//                 //order types
//                 Row(
//                   children: [
//                     Expanded(
//                       child: PrimaryBtn(
//                         onPressed: () {
//                           c.toggleOrderTypeSelection(isTogo: true);
//                         },
//                         text: 'TO GO',
//                         isOutline: true,
//                         color: c.isTogoSelected
//                             ? Theme.of(context).primaryColorLight
//                             : Theme.of(context).scaffoldBackgroundColor,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: PrimaryBtn(
//                         onPressed: () {
//                           c.toggleOrderTypeSelection(isDontMake: true);
//                         },
//                         text: "DON'T MAKE",
//                         isOutline: true,
//                         color: c.isDontMakeSelected
//                             ? Theme.of(context).primaryColorLight
//                             : Theme.of(context).scaffoldBackgroundColor,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: PrimaryBtn(
//                         onPressed: () {
//                           c.toggleOrderTypeSelection(isRush: true);
//                         },
//                         text: 'RUSH',
//                         isOutline: true,
//                         color: c.isRushSelected
//                             ? Theme.of(context).primaryColorLight
//                             : Theme.of(context).scaffoldBackgroundColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 //order types 2
//                 Row(
//                   children: List.generate(
//                     c.orderTypes2.length,
//                     (index) => Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                         child: PrimaryBtn(
//                           onPressed: () {
//                             c.setSelectedOrderTypesIndex2(index);
//                           },
//                           text: c.orderTypes2[index],
//                           isOutline: true,
//                           color: c.selectedOrderTypesIndex2 == index
//                               ? Theme.of(context).primaryColorLight
//                               : Theme.of(context).scaffoldBackgroundColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 //order modifiers
//                 Visibility(
//                   visible: !c.isDrink,
//                   child: Row(
//                     children: List.generate(
//                       c.orderModifiers.length,
//                       (index) => Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                           child: PrimaryBtn(
//                             onPressed: () {
//                               c.setSelectedOrderModifiersIndex(index);
//                             },
//                             text: c.orderModifiers[index],
//                             isOutline: true,
//                             color: c.selectedOrderModifiersIndex == index
//                                 ? Theme.of(context).primaryColorLight
//                                 : Theme.of(context).scaffoldBackgroundColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 //quantity row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Expanded(
//                       child: MyCustomText(
//                         'Quantity',
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           PrimaryBtnWithChild(
//                             onPressed: () {
//                               c.updateOrderQuantity(
//                                   false, item.price.toDouble());
//                             },
//                             color: Colors.white,
//                             width: 48,
//                             child: const Icon(
//                               Icons.remove,
//                               size: 24,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 65,
//                             child: Center(
//                               child: MyCustomText(
//                                 c.orderQuantity.toString(),
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                           PrimaryBtnWithChild(
//                             onPressed: () {
//                               c.updateOrderQuantity(
//                                   true, item.price.toDouble());
//                             },
//                             color: Colors.white,
//                             width: 48,
//                             child: const Icon(
//                               Icons.add,
//                               size: 24,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: MyCustomText(
//                           '\$${c.orderTotalPrice.toStringAsFixed(2)}',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 28),
//                 //order button
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: PrimaryBtn(
//                     onPressed: Get.back,
//                     text: 'ADD',
//                     textMaxSize: 22,
//                     textMinSize: 18,
//                     textColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
