import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';
import 'package:intl/intl.dart';

class MyTime extends StatefulWidget {
  const MyTime({super.key});

  @override
  State<MyTime> createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (value) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('E, MMMM d, y').format(time);

    List<String> times = [
      DateFormat('hh').format(time),
      DateFormat('mm').format(time),
      DateFormat('ss').format(time),
      DateFormat('a').format(time),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // MyCustomText(
        //   formattedTime,
        //   fontSize: 54,
        //   fontWeight: FontWeight.w600,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: times.length - 1,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 75,
                    width: 85,
                    child: Center(
                      child: MyCustomText(
                        times[index],
                        fontSize: 54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, indes) {
                  return const Center(
                    child: MyCustomText(
                      ':',
                      fontSize: 54,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 5),
            MyCustomText(
              times.last,
              fontSize: 54,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        MyCustomText(
          formattedDate,
          fontSize: 40,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
