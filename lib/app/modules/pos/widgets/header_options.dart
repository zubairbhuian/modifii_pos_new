// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../widgets/custom_btn.dart';
// import '../controllers/order_base_controller.dart';

// class HeaderOptions extends StatelessWidget {
//   const HeaderOptions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Theme.of(context).dividerColor),
//         ),
//       ),
//       // height: 115,
//       width: double.infinity,
//       child: GetBuilder<OrderBaseController>(builder: (c) {
//         return Row(
//           children: List.generate(
//             c.headerOptions.length,
//             (index) => Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               child: PrimaryBtn(
//                 onPressed: () {
//                   c.selectedHeaderOption.value = index;
//                 },
//                 color: c.headerOptions[index].values.first,
//                 textColor: Colors.white,
//                 text: c.headerOptions[index].keys.first,
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
