import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class SingleRoutePass extends StatefulWidget {
  const SingleRoutePass({super.key});

  @override
  State<SingleRoutePass> createState() => _SingleRoutePassState();
}

class _SingleRoutePassState extends State<SingleRoutePass> {
  List<DateTime?> _dates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        title: Text("Buy One Route Pass"),
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
