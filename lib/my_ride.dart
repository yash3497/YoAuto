// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyRide extends StatefulWidget {
  const MyRide({Key? key}) : super(key: key);

  @override
  State<MyRide> createState() => _MyRideState();
}

class _MyRideState extends State<MyRide> {
  int _currentPos = 0;

  Container makeCont(String paymentFrom, int kmTravelled, String date) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 30),
      height: 400,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(1, 5))
          ]),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " $kmTravelled Km travelled",
                  style: TextStyle(
                      color: Color.fromRGBO(165, 165, 165, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                ),
                Text(
                  "₹ XX",
                  style: TextStyle(
                      color: Color.fromRGBO(165, 165, 165, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dropped",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "$paymentFrom",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 30,
              width: 350,
              child: Divider(
                  thickness: 2, color: Color.fromRGBO(165, 165, 165, 1))),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.green,
              ),
            ),
            child: Stepper(
              onStepTapped: (index) {
                setState(() {
                  _currentPos = index;
                });
              },
              steps: [
                Step(
                  isActive: _currentPos >= 0,
                  title: Text(
                      '107, Modi Heights, Phase I, Ratu Rd, Ranchi, Jharkhand 834001, India'),
                  content: Text(''),
                ),
                Step(
                  title: Text(
                      'Kushwaha complex, Booty More Rd, Ranchi, Jharkhand 834009, India'),
                  content: Text(''),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$date",
                  style: TextStyle(
                    color: Color.fromRGBO(165, 165, 165, 1),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 203, 32, 1),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "My Rides",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      backgroundColor: Color.fromRGBO(230, 228, 224, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            makeCont("Wallet", 6, "05/07/2022 "),
            makeCont(" UPI", 10, "04/07/2022 "),
            makeCont(" Wallet", 2, "01/07/2022 "),
          ],
        ),
      ),
    );
  }
}
