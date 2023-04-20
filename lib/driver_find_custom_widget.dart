import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';



class DriverHomePage extends StatelessWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: ElevatedButton(onPressed: (){
           showDialog(context: context, builder: (BuildContext context){
           return   DriverSearching();
           });
         }, child: Text(
           "Show Dialog"
         )),
       ),
    );
  }
}


class DriverSearching extends StatefulWidget {
  const DriverSearching({Key? key}) : super(key: key);

  @override
  State<DriverSearching> createState() => _DriverSearchingState();
}

class _DriverSearchingState extends State<DriverSearching> {
  int _timeRemaining = 10*60; // 10 minutes

  String imagePath = "assets/images/search.gif";
  String message = "Looking For Driver In Your Area";


  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--; // decrement time remaining by 1 second
        } else {
          setState(() {
            imagePath = "assets/images/sademoji.png";
            message = "Sorry, No Driver is available in Your Area Now";
            timer.cancel();

          });; // stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    int minutes = _timeRemaining ~/ 60;
    int seconds = _timeRemaining % 60;

    return AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 50),
      icon: Image.asset(imagePath,height: 120,width: 120,), // networkIssue
      title: Column(
        children: [
          Text(message,
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900]
            ),
          ),
          Text("$minutes:${seconds.toString().padLeft(2, '0')}",
          style: TextStyle(
            fontSize: 30,
            color: Colors.red[800]
          ),),
        ],
      ),
    );
  }
}
