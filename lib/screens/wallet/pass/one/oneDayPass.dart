import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class OneDayPass extends StatefulWidget {
  const OneDayPass({super.key});

  @override
  State<OneDayPass> createState() => _OneDayPassState();
}

class _OneDayPassState extends State<OneDayPass> {
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
