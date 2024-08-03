import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/controllers/dine_in_controller.dart';
import 'package:flutter_base/app/modules/pos/views/widgets/top_menu.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../widgets/table_availability_header.dart';
import '../widgets/table_body.dart';

class DineInView extends GetView<DineInController> {
  const DineInView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const TopMenu(),
        const SizedBox(height: 16),
        const TableAvailabilityHeader(),
        const SizedBox(height: 12.0),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! dine-in
              const Expanded(
                flex: 3,
                child: TableBody(
                  isScrollable: false,
                ),
              ),
              const SizedBox(width: 30),
              // ! takeout
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title("Takeout".toUpperCase()),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          // width: 200,
                          child: StaggeredGrid.count(
                            crossAxisCount: 6,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            children: List.generate(20, (index) {
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
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // cart area
            ],
          ),
        ),
      ],
    );
  }

  Container _title(String title) {
    return Container(
      height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      color: StaticColors.blackLightColor,
      child: MyCustomText(
        title,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
