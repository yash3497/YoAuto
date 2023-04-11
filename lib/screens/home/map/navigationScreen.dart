import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/home/map/mapScreen.dart';
import 'package:yoauto_task/screens/home/map/navigation/inform.dart';

import '../book_ride_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.amber.shade300,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: MapScreen(),
      floatingActionButton: InkWell(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: CircleAvatar(
          backgroundColor: Vx.red500,
          radius: isOpen ? 30 : 30,
          child: Center(
            child: Icon(
              isOpen ? Icons.cancel_outlined : Icons.dangerous_rounded,
              size: isOpen ? 38 : 60,
            ),
          ),
        ),
      ),
      bottomSheet: isOpen
          ? Container(
              height: context.screenHeight / 4.5,
              width: context.screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Column(
                children: [
                  Text(
                    "Something Strange?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).pOnly(top: 20),
                  InkWell(
                    onTap: (() {
                      Get.to(InformUsScreen());
                    }),
                    child: Container(
                        height: 50,
                        width: context.screenWidth / 1.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Inform Us",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )).pOnly(top: 30),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Click here to report issue",
                          style: TextStyle(color: Colors.red),
                        ),
                      ))
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
