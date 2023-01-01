// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../widget/custom_drawerScreen.dart';
import '/widget/widget.dart';

import 'package:velocity_x/velocity_x.dart';

import 'bottomsheet/detailedBottomSheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: CustomDrawerBtn()),
        actions: [CustomBellBtn()],
      ),
      drawer: Drawer(
        elevation: 30,
        child: CustomDrawerScreen(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      )),
      bottomNavigationBar: DetailedBottomSheet(),
    );
  }
}
