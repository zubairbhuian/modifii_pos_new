import 'package:flutter/material.dart';
import 'package:flutter_base/app/services/controller/config_controller.dart';
import 'package:flutter_base/app/widgets/custom_inkwell.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/employee_controller.dart';

class EmployeeView extends GetView<EmployeeController> {
  const EmployeeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomInkWell(
          onTap: () => Get.back(),
          child: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 28,
          ),
        ).marginOnly(right: 20, left: 20),
        title: const Text('Employee'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            //
          ],
        ),
      ),
    );
  }
}
