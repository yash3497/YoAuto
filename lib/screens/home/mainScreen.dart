// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:yoauto_task/backend/services/locationServices.dart';
import 'package:yoauto_task/my_ride.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:yoauto_task/screens/wallet/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  int _selectedIndex = 0;

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          children: [HomeScreen(), MyRide(), WalletScreen()],
        ),
        bottomNavigationBar: SalomonBottomBar(
          unselectedItemColor: Colors.grey,
          margin: EdgeInsets.all(5),
          itemPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          items: <SalomonBottomBarItem>[
            SalomonBottomBarItem(
              title: Text("Home"),
              icon: Icon(
                Icons.home_outlined,
                size: 36,
              ),
            ),
            SalomonBottomBarItem(
              title: Text("My Rides"),
              icon: Icon(
                Icons.history,
                size: 36,
              ),
            ),
            SalomonBottomBarItem(
              title: Text("Wallet"),
              icon: Icon(
                Icons.wallet,
                size: 36,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green.shade800,
          onTap: bottomTapped,
        ),
      ),
    );
  }
}
