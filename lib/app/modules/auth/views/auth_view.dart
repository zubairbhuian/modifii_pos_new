import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:flutter_base/app/widgets/my_scale_animation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'startup_view.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: !controller.isShowSplashScreen.value
              ? _authView(context, theme)
              : _splashView(context),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          // replacement: _splashView(context),
          // child: _authView(context, theme),
        ),
      ),
    );
  }

  Center _splashView(BuildContext context) {
    return Center(
      child: MyScaleAnimation(
        startSize: 0,
        endSize: MediaQuery.sizeOf(context).width * 0.75,
        duration: 2000,
        child: SvgPicture.asset(
          'assets/images/splash/yogo_logo.svg',
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.background,
            BlendMode.srcIn,
          ),
        ),
      ),
      // child: Image.asset(
      //   'assets/images/splash/yogo_logo.jpeg',
      //   width: MediaQuery.sizeOf(context).width * 0.6,
      // ),
    );
  }

  Obx _authView(BuildContext context, ThemeData theme) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          StartupView(
            onTap: () => controller.toggleStartup(false),
            isOnTop: controller.isStartup.value,
          ),
          AnimatedOpacity(
            opacity: controller.isStartup.value ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: controller.isStartup.value,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.27,
                height: MediaQuery.sizeOf(context).height * 0.85,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ConfigController.to.isLightTheme
                            ? const Color(0xffEFEFEF)
                            : const Color(0xff2A2A2A),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // password display
                        _passwordDisplay(theme),
                        const SizedBox(height: 4),
                        // keybord area
                        _customKeybord(theme),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordDisplay(ThemeData theme) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: theme.canvasColor,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(
        //   color: theme.colorScheme.background,
        //   width: 1.75,
        // )
        border: Border.all(
          color: const Color(0xffEBEBEB),
          width: .5,
        ),
      ),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              controller.passwordLength.value,
              (index) => CircleAvatar(
                    backgroundColor:
                        index + 1 > controller.password.value.length
                            ? Colors.transparent
                            : theme.colorScheme.background,
                    radius: 10,
                  )),
        ),
      ),
    );
  }

  Widget _customKeybord(ThemeData theme) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 3,
      crossAxisSpacing: 3,
      children: List.generate(
          controller.numberList.length,
          (index) => SizedBox(
                width: 100,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    controller.toggleStartup(false);
                    AudioPlayer().play(AssetSource('audio/tap_sound_1.mp3'));
                    if (controller.numberList.length - 1 == index) {
                      // log in
                      controller.login();
                    } else if (controller.numberList[index] == "*") {
                      // remove number
                      controller.removePassword();
                    } else {
                      // add number
                      controller.addPassword(controller.numberList[index]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    // ****** style ******
                    textStyle: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 36),
                    backgroundColor: controller.numberList[index] == "*"
                        ? controller.numberList.length - 1 == index
                            ? const Color(0xff118A00)
                            : const Color(0xffFD571A)
                        : theme.canvasColor,
                    foregroundColor: theme.dividerColor,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // ****** Border color *******
                    side: const BorderSide(
                      color: Color(0xffEBEBEB),
                      width: .5,
                    ),
                  ),
                  child: controller.numberList[index] == "*"
                      ? controller.numberList.length - 1 == index
                          ? const Icon(FontAwesomeIcons.check,
                              color: Colors.white, size: 36)
                          : const Icon(FontAwesomeIcons.deleteLeft,
                              color: Colors.white, size: 36)
                      : MyCustomText(
                          controller.numberList[index],
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                ),
              )),
    );
  }
}
