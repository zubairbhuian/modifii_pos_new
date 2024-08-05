import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/modules/clockIn/controllers/clock_in_controller.dart';
import 'package:flutter_base/app/modules/pos/controllers/pos_controller.dart';
import 'package:flutter_base/app/modules/pos/dine-in/views/order_details_view.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/utils/static_colors.dart';
import 'package:flutter_base/app/widgets/custom_alert_dialog.dart';
import 'package:flutter_base/app/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/popup_dialogs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import 'custom_inkwell.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final bool hasHomeButton;
  final bool hasButtonsRow;
  final bool hasLogoutBtn;
  final double? preferredHeight;
  final Color? backgroundColor;
  final bool centerTitle;
  final Widget? title;
  final bool isPrimary;

  const CustomAppBar({
    super.key,
    this.centerTitle = false,
    this.isLeading = true,
    this.hasHomeButton = true,
    this.hasLogoutBtn = true,
    this.preferredHeight,
    this.backgroundColor,
    this.hasButtonsRow = true,
    this.title,
    this.isPrimary = true,
  });
// Specify the desired height of the AppBar
  @override
  Size get preferredSize =>
      Size.fromHeight(isPrimary == true ? preferredHeight ?? 65 : 60);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 24,
      elevation: 0,
      centerTitle: centerTitle,
      leadingWidth: 80,

      backgroundColor: backgroundColor ?? theme.canvasColor,
      // foregroundColor: kTextColor,
      // titleTextStyle: kTitleLarge.copyWith(color: const Color(0xff2F2F2F)),
      // appbar leading
      leading: !isPrimary
          ? CustomInkWell(
              onTap: () => Get.back(),
              child: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 28,
              ),
            ).marginOnly(right: 20)
          : null,
      title: title,
      flexibleSpace: isPrimary
          ? SizedBox(
              // decoration: BoxDecoration(
              //     border: Border(bottom: BorderSide(color: theme.dividerColor))),
              width: double.infinity,
              child: Column(
                children: [
                  // topbar
                  _topBar(theme, context),
                  // Visibility(
                  //   visible: hasButtonsRow,
                  //   child: _buttons(theme),
                  // ),
                ],
              ),
            )
          : null,
    );
  }

  //** Buttons **
  Widget _topBar(ThemeData theme, BuildContext context) {
    ConfigController configController = ConfigController.to;
    ClockInController clockInController = ClockInController.to;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<PosController>(builder: (c) {
            return Row(
              children: [
                if (isLeading)
                  CustomInkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 28,
                    ),
                  ).marginOnly(right: 20),
                if (c.isUpdateView)
                  CustomInkWell(
                    onTap: () {
                      Get.to(() => const OrderDetailsView());
                    },
                    child: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 28,
                    ),
                  ).marginOnly(right: 20),
                if (hasHomeButton)
                  CustomInkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      width: 200,
                      'assets/icons/yogo.svg',
                      colorFilter: ColorFilter.mode(
                        configController.isLightTheme
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ).marginOnly(right: 20),
              ],
            );
          }),
          Row(
            children: [
              CustomInkWell(
                onTap: configController.toggleTheme,
                child: SvgPicture.asset(
                  'assets/icons/theme.svg',
                  height: 45,
                  colorFilter: ColorFilter.mode(
                      configController.isLightTheme
                          ? Colors.black
                          : Colors.white,
                      BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 18),
              Visibility(
                visible: clockInController.timer?.isActive ?? false,
                child: Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 65,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              clockInController.showClockInTimer().length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 28,
                              width: 32,
                              child: Center(
                                child: MyCustomText(
                                  clockInController.showClockInTimer()[index],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, indes) {
                            return const Center(
                              child: MyCustomText(
                                ':',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    PrimaryBtn(
                      onPressed: () {
                        PopupDialog.customDialog(
                            width: 500,
                            // height: 500,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Do you want to clock out?',
                                    style: theme.textTheme.headlineMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  // const MyCustomText(
                                  //   'Do you want to clock out?',
                                  //   fontSize: 26,
                                  //   maxLines: 2,
                                  //   fontWeight: FontWeight.w700,
                                  // ),
                                  const SizedBox(height: 28),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: PrimaryBtn(
                                            onPressed:
                                                clockInController.clockOut,
                                            text: 'Yes',
                                            textColor: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Expanded(
                                          child: PrimaryBtn(
                                            onPressed: Get.back,
                                            text: 'Cancel',
                                            color: StaticColors.blackLightColor,
                                            textColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      },
                      text: 'Clockout',
                      textColor: Colors.white,
                      color: StaticColors.redColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Visibility(
                visible: hasLogoutBtn,
                child: PrimaryBtn(
                  onPressed: () async {
                    await ClockInController.to.clockOut();
                    BaseController.to.logout();
                  },
                  text: 'Logout',
                  textColor: Colors.white,
                  color: StaticColors.redColor,
                ),
              ),
            ],
          ),

          // InkWell(
          //   onTap: () {},
          //   splashFactory: NoSplash.splashFactory,
          //   child: const Icon(
          //     Icons.menu,
          //     size: 40,
          //   ),
          // )
        ],
      ),
    );
  }
}
