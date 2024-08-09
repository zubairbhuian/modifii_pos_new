import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            // showDatePicker(
            //   context: context,
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime(2010, 1),
            //   lastDate: DateTime(2050, 12),
            // ).then((date) {
            //   // controller.startDate.text =
            //   //     DateFormat('MM/dd/yyyy').format(date!);
            // });
          },
          child: Switch(
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
            },
            value: isActive,
          ),
        ),
      ),
    );
  }
}
