import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'constants/colors.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List arr = ['Notification', 'Sound'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:yellow,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed:(){},
            icon: Icon(Icons.arrow_back,size: 34,),
            color: Colors.black)
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: arr.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: darkGreen,
                            width: 3,
                          )),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(arr[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 28,
                                color:Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: LiteRollingSwitch(
                            value: true,
                            colorOn: darkGreen,
                            colorOff: yellow,
                            iconOn: Icons.done,
                            iconOff: Icons.remove_circle_outline,
                            textSize: 20.0,
                            textOnColor: yellow,
                            textOffColor: darkGreen,
                            onSwipe: () {},
                            onDoubleTap: () {},
                            onTap: () {},
                            onChanged: (bool state) {},
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 144, 142, 142),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(0.5, 1))
                    ]),
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 60),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color:yellow,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 144, 142, 142),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(0.5, 2))
                    ]),
                height: 55,
                width: 290,
                child: Center(
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 252, 251, 251),
    );
  }
}