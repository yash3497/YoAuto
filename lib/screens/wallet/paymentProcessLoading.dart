import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/wallet/pass/passQR.dart';

class PaymentProcessLoading extends StatefulWidget {
  const PaymentProcessLoading({super.key});

  @override
  State<PaymentProcessLoading> createState() => _PaymentProcessLoadingState();
}

class _PaymentProcessLoadingState extends State<PaymentProcessLoading> {
  _navigateAfterLoad() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => PassQRScreen())));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateAfterLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/payment.gif')
              .pOnly(top: 180, left: 80, right: 80),
          Text(
            "Getting Your Payment Details....",
            style: TextStyle(fontSize: 18),
          ).pOnly(top: 30),
          Text(
            "Please wait",
            style: TextStyle(fontSize: 18),
          ).pOnly(top: 30)
        ],
      ),
    );
  }
}
