import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class MonthlyPass extends StatefulWidget {
  const MonthlyPass({super.key});

  @override
  State<MonthlyPass> createState() => _MonthlyPassState();
}

class _MonthlyPassState extends State<MonthlyPass> {
  List<DateTime?> _dates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        title: Text("Buy Weekly Pass"),
      ),
      body: Column(children: [
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
          ),
          value: _dates,
          onValueChanged: (dates) => _dates = dates,
        )
      ]),
    );
  }
}
