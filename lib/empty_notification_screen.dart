import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';


class EmptyNotificationScreen extends StatefulWidget {
  const EmptyNotificationScreen({super.key});


  @override
  State<EmptyNotificationScreen> createState() => _EmptyNotificationScreenState();
}

class _EmptyNotificationScreenState extends State<EmptyNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: "Notification".text.semiBold.black.make(),
        centerTitle: true,
        backgroundColor: yellow,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back_outlined,size: 34,),
          color: Colors.black,

        ),
      ),

      backgroundColor: Colors.white,
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(Icons.hourglass_empty_outlined,size: 32,),
           20.heightBox,
           "no unread notification".text.size(20).color(darkGreen).make(),

         ],
       ),
      ),
    );
  }
}

