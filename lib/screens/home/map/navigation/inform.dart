import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/backend/database/firebaseDB.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:yoauto_task/widget/custom_btn.dart';

class InformUsScreen extends StatefulWidget {
  const InformUsScreen({super.key});

  @override
  State<InformUsScreen> createState() => _InformUsScreenState();
}

class _InformUsScreenState extends State<InformUsScreen> {
  List<String> titles = [
    "Driver Misbehaving?",
    "Wrong or Strange Route",
    "Over Speeding",
    "Driver asking extra money",
    "Auto-Rikshaw Issue like : Puncture, Out of fuel, etc."
  ];
  List<String> subTitles = [
    "drunked, fighting, arguing, etc",
    "not following given route by us.",
    "breaking the speed limits",
    "asking for extra money after or before ride",
    "Puncture, Out of fuel, etc."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        title: Text("Report Us"),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (() {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: context.screenHeight / 4,
                      width: context.screenWidth / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Material(
                            child: Text(
                              "We are cancel your ride for now, and taking an action on driver asap. Please kindly leave the auto-rikshaw if have any problem contact us now.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ).p(12),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                FirebaseDB().report('driverID', titles[index]);
                                Get.to(HomeScreen());
                              },
                              child: Center(
                                child: Text("OK"),
                              )).pOnly(right: 12, left: 12),
                          TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  "Contact Emergency",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                        ],
                      ),
                    ).pOnly(bottom: context.screenHeight / 2.5);
                  });
            }),
            child: ListTile(
              title: Text(titles[index]),
              subtitle: Text(subTitles[index]),
            ),
          );
        },
      ),
    );
  }
}
