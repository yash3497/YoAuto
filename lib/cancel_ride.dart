 import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String reason = "cancel" ;



  Container makeCont(String re, int reasonNo) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 0.5,
                  offset: Offset(
                    0,
                    2,
                  ))
            ]),
        height: 65,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$re",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Radio(
                  activeColor: Colors.red,
                  value: '$reasonNo',
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value.toString();
                    });
                  }),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading:IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.arrow_back,
          ),
        ),
        title: Text(
          "Cancel Ride",
          style: TextStyle(
              fontSize: 24,
              color: Colors.red.shade800,
              fontWeight: FontWeight.w900),
        ),
        titleSpacing: 54,
        backgroundColor: Colors.yellow.shade700,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                makeCont("Reason 1",1),
                makeCont("Reason 2",2),
                makeCont("Reason 3",3),
                makeCont("Other (explain in textBox)",4),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 0.5,
                            offset: Offset(
                              0,
                              2,
                            ))
                      ]),
                  height: 150,
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: ("       Write here")),
                    onChanged: (text) {
                      // specify what to do when the user changes the text
                      setState(() {});
                    },
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 0.5,
                                offset: Offset(
                                  0,
                                  2,
                                ))
                          ]),
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Cancellation Charge',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Tooltip(
                                  message:
                                      'This is a description of the text widget',
                                  child: Text(
                                    'Pay Cancellation Charge',
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: const Text(
                                "XX",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 33),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(300, 50),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            shadowColor: Colors.black),
                        onPressed: () {},
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
