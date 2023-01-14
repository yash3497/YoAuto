// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:yoauto_task/backend/services/locationServices.dart';
import 'package:yoauto_task/my_ride.dart';
import 'package:yoauto_task/screens/CurrentRide/current_ride.dart';
import 'package:yoauto_task/screens/home/book_ride_screen.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:yoauto_task/screens/wallet/wallet_screen.dart';
import 'package:yoauto_task/wallet_transaction.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          children: [HomeScreen(), MyRide(), WalletScreen()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 36,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 36,
              ),
              label: "My Rides"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.wallet,
                size: 36,
              ),
              label: "Wallet"),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        onTap: bottomTapped,
      ),
    );
  }
}
