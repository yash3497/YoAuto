// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yoauto_task/my_ride.dart';
import 'package:yoauto_task/screens/rewards/ref_earn_Screen.dart';
import 'package:yoauto_task/screens/rewards/rewardScreen.dart';
import 'package:yoauto_task/screens/testScreen.dart';
import 'package:yoauto_task/support.dart';

class CustomDrawerScreen extends StatefulWidget {
  const CustomDrawerScreen({super.key});

  @override
  State<CustomDrawerScreen> createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen> {
  List<Widget> icons = [
    Image.asset("assets/images/Time_light.png"),
    Image.asset("assets/images/GIft.png"),
    Image.asset("assets/images/Trophy_light.png"),
    Image.asset("assets/images/Setting_line.png"),
    Image.asset("assets/images/Info.png"),
    Image.asset("assets/images/support.png"),
  ];
  List<String> titles = [
    "My Rides",
    "Refer & Earn",
    "Rewards",
    "Settings",
    "About",
    "Support"
  ];
  List<Widget> screens = [
    MyRide(),
    RefrEarnScreen(),
    RewardScreen(),
    TestScreen(),
    TestScreen(),
    SupportPage()
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: height / 8,
          width: width,
          color: Colors.amber,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 36,
                    color: Colors.green,
                  ),
                ),
              ),
              title: Text(
                "John Doe",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                "+XX XXXXXXXXX",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),

        //---------------------//
        ListView.builder(
            shrinkWrap: true,
            itemCount: titles.length,
            itemBuilder: (contxt, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => screens[index],
                          transition: Transition.leftToRightWithFade,
                          duration: Duration(milliseconds: 500));
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        height: 45,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        child: Center(child: icons[index]),
                      ),
                      title: Text(
                        titles[index],
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.amber,
                  )
                ],
              );
            })

        //-----Options--------------//
      ]),
    );
  }
}