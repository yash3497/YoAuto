import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../authentication/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _pageDecider() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const RegisterPage()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageDecider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/icons/logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ).pOnly(right: 20),
      ),
    );
  }
}
