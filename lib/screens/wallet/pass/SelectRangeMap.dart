import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoauto_task/screens/wallet/pass/passQR.dart';
import 'package:yoauto_task/screens/wallet/paymentProcessLoading.dart';

class SelectRangeMap extends StatefulWidget {
  const SelectRangeMap({super.key});

  @override
  State<SelectRangeMap> createState() => _SelectRangeMapState();
}

class _SelectRangeMapState extends State<SelectRangeMap> {
  List<String> titles = [
    "25KM",
    "50KM",
    "100KM",
    "200KM",
  ];
  List<String> subTitles = [
    "Book a radius of 25KM from your current location",
    "Book a radius of 50KM from your current location",
    "Book a radius of 100KM from your current location",
    "Book a radius of 200KM from your current location",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: Text("Select Range"),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Get.to(PaymentProcessLoading()),
            child: ListTile(
              leading: Icon(Icons.radar),
              minLeadingWidth: 10,
              title: Text(titles[index]),
              subtitle: Text(subTitles[index]),
            ),
          );
        },
      ),
    );
  }
}
