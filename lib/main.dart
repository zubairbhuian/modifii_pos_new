// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/services/controller/base_controller.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
// import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/config/dark_theme.dart';
import 'package:flutter_base/config/light_theme.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'app/services/base/api_service.dart';
import 'app/services/base/api_service.dart';
import 'app/services/base/dio_interceptor.dart';
import 'app/services/base/preferences.dart';
import 'app/services/bindings/base_binding.dart';
import 'app/routes/app_pages.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  //hive init
  // init hive and adapters

  WindowOptions windowOptions = const WindowOptions(
    // size: Size(1250, 673),
    minimumSize: Size(1350, 700),
    center: true,
    backgroundColor: Colors.transparent,
    // fullScreen: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  //Native Splash
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await Future.delayed(const Duration(seconds: 2));
  // FlutterNativeSplash.remove();

  /// mobile orientation off
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Status Bar Color
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: kPrimaryColor,
  //   statusBarIconBrightness: Brightness.light,
  // ));

  /// Shared Preferences
  await Preferences.init();

  /// Initialize the dio
  final dio = Dio();

  // Initialize the dio instance
  dio.interceptors.add(DioInterceptor());

  /// Add the dio instance to the api service
  final apiService = ApiService(dio: dio);

  /// Add the dio instance to the bindings
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  const MyApp({
    super.key,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ConfigController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter base',
      themeMode:
          ConfigController.to.isLightTheme ? ThemeMode.light : ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,

      initialBinding: BaseBinding(apiService: apiService),
      // initialRoute: AppPages.INITIAL,
      initialRoute: Routes.AUTH,
      getPages: AppPages.routes,
    );
  }
}
