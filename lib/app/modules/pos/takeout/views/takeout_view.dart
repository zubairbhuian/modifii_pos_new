import 'package:flutter/material.dart';
import 'package:flutter_base/app/modules/pos/dine-in/widgets/table_availability_header.dart';
import 'package:flutter_base/app/modules/pos/takeout/controllers/takeout_controller.dart';
import 'package:flutter_base/app/modules/pos/views/widgets/top_menu.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:get/get.dart';

class TakeOutView extends GetView<TakeOutController> {
  const TakeOutView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopMenu(),
        const SizedBox(height: 16),
        // title
        const Row(
          children: [
            ColorTextRow(
              color: StaticColors.yellowColor,
              text: 'Unpaid',
            ),
            ColorTextRow(
              color: StaticColors.greenColor,
              text: 'Paid',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
            child: Row(
          children: [
            // unpaid
            SingleChildScrollView(
              child: Column(
                children: List.generate(100, (index) {
                  return PrimaryBtnWithChild(
                    onPressed: () {},
                    color: StaticColors.yellowColor,
                    width: 150,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '100000-p',
                          style: theme.textTheme.labelMedium
                              ?.copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Server',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Haveli',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ).marginOnly(bottom: 12);
                }),
              ),
            ),
            const SizedBox(width: 16),
            // unpaid
            // Expanded(
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //       maxCrossAxisExtent: 110,
            //       crossAxisSpacing: 2,
            //       mainAxisSpacing: 2,
            //     ),
            //     itemCount: 100,
            //     itemBuilder: (context, index) {
            //       return PrimaryBtnWithChild(
            //         onPressed: () {},
            //         color: StaticColors.greenColor,
            //         width: 150,
            //         padding: const EdgeInsets.all(20),
            //         alignment: Alignment.centerLeft,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               '100000-p $index',
            //               style: theme.textTheme.labelMedium
            //                   ?.copyWith(color: Colors.white),
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             const SizedBox(height: 10),
            //             Text(
            //               'Server',
            //               style: theme.textTheme.bodySmall
            //                   ?.copyWith(color: Colors.white),
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             Text(
            //               'Haveli',
            //               style: theme.textTheme.bodySmall
            //                   ?.copyWith(color: Colors.white),
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           ],
            //         ),
            //       ).marginOnly(bottom: 12);
            //     },
            //   ),
            // ),

            SingleChildScrollView(
              child: SizedBox(
                // width: 200,
                child: Column(
                  children: List.generate(100, (index) {
                    return PrimaryBtnWithChild(
                      onPressed: () {},
                      color: StaticColors.greenColor,
                      width: 150,
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '100000-p $index',
                            style: theme.textTheme.labelMedium
                                ?.copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Server',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Haveli',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ).marginOnly(bottom: 12);
                  }),
                ),
              ),
            ),
            // BookedTableOption(controller: controller)
            // Expanded(
            //   // width: 100,
            //   child: Expanded(
            //     child: StaggeredGrid.count(
            //       crossAxisCount: 4,
            //       mainAxisSpacing: 4,
            //       crossAxisSpacing: 4,
            //       children: [
            //         Container(
            //             color: Colors.red,
            //             padding: const EdgeInsets.all(20),
            //             child: const Text("demo")),

            //         // PrimaryBtnWithChild(
            //         //   onPressed: () {},
            //         //   color: StaticColors.greenColor,
            //         //   width: 150,
            //         //   padding: const EdgeInsets.all(20),
            //         //   alignment: Alignment.centerLeft,
            //         //   child: Column(
            //         //     crossAxisAlignment: CrossAxisAlignment.start,
            //         //     children: [
            //         //       Text(
            //         //         '100000-p ',
            //         //         style: theme.textTheme.labelMedium
            //         //             ?.copyWith(color: Colors.white),
            //         //         maxLines: 1,
            //         //         overflow: TextOverflow.ellipsis,
            //         //       ),
            //         //       const SizedBox(height: 10),
            //         //       Text(
            //         //         'Server',
            //         //         style: theme.textTheme.bodySmall
            //         //             ?.copyWith(color: Colors.white),
            //         //         maxLines: 1,
            //         //         overflow: TextOverflow.ellipsis,
            //         //       ),
            //         //       Text(
            //         //         'Haveli',
            //         //         style: theme.textTheme.bodySmall
            //         //             ?.copyWith(color: Colors.white),
            //         //         maxLines: 1,
            //         //         overflow: TextOverflow.ellipsis,
            //         //       ),
            //         //     ],
            //         //   ),
            //         // ).marginOnly(bottom: 12)
            //       ],
            //     ),
            //   ),
            // )
          ],
        )),
      ],
    );
  }
}
