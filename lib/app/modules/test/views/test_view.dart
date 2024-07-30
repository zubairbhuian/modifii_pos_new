import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestView'),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010, 1),
              lastDate: DateTime(2050, 12),
            ).then((date) {
              // controller.startDate.text =
              //     DateFormat('MM/dd/yyyy').format(date!);
            });
          },
          child: const Text(
            'TestView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
