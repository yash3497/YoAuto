import 'package:flutter/material.dart';

class HomeScreenTwo extends StatefulWidget {
  @override
  _HomeScreenTwoState createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar'),
      ),
      body: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.yellow.withOpacity(0.5)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 300,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0,1)
                            )
                          ],
                         color: Colors.white
                       ),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 16,
                              height: 16,

                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),

                            Text('XYZ Road, Ranchi Univer',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                            SizedBox(width: 8),
                            Icon(Icons.mic,size: 30,color: Colors.green,)
                          ],
                        ),
                      ),

                       SizedBox(
                         height: 30,
                       ),

                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0,1)
                              )
                            ],
                            color: Colors.white
                        ),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 16,
                              height: 16,

                              decoration: BoxDecoration(
                                color: Colors.yellow[600],
                                shape: BoxShape.circle,
                              ),
                            ),

                            Text('Enter Destination',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 17
                            ),),
                            SizedBox(width: 8),
                            Icon(Icons.mic,size: 30,color: Colors.yellow[600],)
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: Icon(Icons.home_outlined,size: 45,color: Colors.black87),
            label: "Home",

          ),
          BottomNavigationBarItem(



            icon: Icon(Icons.location_on_outlined,size: 45,color: Colors.black87,),
            label: "Current Ride"

          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.wallet,size: 45,color: Colors.black87,),
            label: "Wallet"



          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black12,
        onTap: _onItemTapped,
      ),
    );
  }
}
