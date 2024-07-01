import 'package:flutter_base/app/modules/auth/bindings/auth_binding.dart';
import 'package:flutter_base/app/modules/auth/views/auth_view.dart';
import 'package:flutter_base/app/modules/clockIn/bindings/clock_in_binding.dart';
import 'package:flutter_base/app/modules/clockIn/views/clock_in_view.dart';
import 'package:get/get.dart';

import '../modules/employee/bindings/employee_binding.dart';
import '../modules/employee/views/employee_view.dart';
import '../modules/entryPoint/bindings/entry_point_binding.dart';
import '../modules/entryPoint/views/entry_point_view.dart';
import '../modules/pos/bindings/pos_binding.dart';
import '../modules/pos/views/pos_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/subCategory/bindings/sub_category_binding.dart';
import '../modules/subCategory/views/sub_category_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.POS;

  static final routes = [
    GetPage(
      name: _Paths.ENTRY_POINT,
      page: () => const EntryPointView(),
      binding: EntryPointBinding(),
    ),
    GetPage(
      name: _Paths.POS,
      page: () => const PosView(),
      binding: PosBinding(),
    ),
    GetPage(
      name: _Paths.EMPLOYEE,
      page: () => const EmployeeView(),
      binding: EmployeeBinding(),
    ),
    GetPage(
      name: _Paths.SUB_CATEGORY,
      page: () => const SubCategoryView(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: _Paths.CLOCK_IN,
      page: () => const ClockInView(),
      binding: ClockInBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
  ];
}
