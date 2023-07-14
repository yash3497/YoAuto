import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/wallet/pass/SelectRangeMap.dart';

class WeeklyPass extends StatefulWidget {
  const WeeklyPass({super.key});

  @override
  State<WeeklyPass> createState() => _WeeklyPassState();
}

class _WeeklyPassState extends State<WeeklyPass> {
  List<DateTime?> _dates = [];

  @override
  Widget build(BuildContext context) {
    // DateTime? startDate = _dates[0];
    // DateTime? endDate = _dates[1];
    // Duration duration = endDate!.difference(startDate!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        title: Text("Buy Weekly Pass"),
      ),
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select Date : ",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ).pOnly(left: 20),
        ),
        SizedBox(
          height: 20,
        ),
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
          ),
          value: _dates,
          onValueChanged: (dates) {
            _dates = dates;
            print(_dates);
          },
        ),
        SizedBox(
          height: 80,
        ),
        InkWell(
          onTap: () => Get.to(SelectRangeMap()),
          child: Container(
            height: context.screenHeight / 12,
            width: context.screenWidth / 1.2,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
