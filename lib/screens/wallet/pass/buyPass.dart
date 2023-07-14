import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoauto_task/screens/wallet/pass/month/monthlyPass.dart';
import 'package:yoauto_task/screens/wallet/pass/one/oneDayPass.dart';
import 'package:yoauto_task/screens/wallet/pass/single/singleRoutePass.dart';
import 'package:yoauto_task/screens/wallet/pass/week/weeklyPass.dart';

class BuyPassScreen extends StatefulWidget {
  const BuyPassScreen({super.key});

  @override
  State<BuyPassScreen> createState() => _BuyPassScreenState();
}

class _BuyPassScreenState extends State<BuyPassScreen> {
  List<String> titles = [
    "Weekly Pass",
    "Monthly Pass",
    "Single Route Pass",
    "One Day Pass"
  ];
  List<String> subTitles = [
    "Ride upto 50 KM for one week",
    "Ride upto 100 KM for one month",
    "Ride only on selected route for one month",
    "Ride upto 25 KM for 24Hrs"
  ];
  List routes = [WeeklyPass(), MonthlyPass(), SingleRoutePass(), OneDayPass()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        title: Text("Buy Passes"),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Get.to(routes[index]),
            child: ListTile(
              title: Text(titles[index]),
              subtitle: Text(subTitles[index]),
              leading: Icon(Icons.qr_code),
              minLeadingWidth: 10,
            ),
          );
        },
      ),
    );
  }
}
