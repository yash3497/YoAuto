import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_ui/constants/colors.dart';





// widget for notification ui

Widget notificatioUi ({String? title,}){
   return  Card(
     elevation: 8,
     child: Padding(
       padding: const EdgeInsets.all(15.0),
       child: ListTile(

         title: Row(

           children: [
             Icon(Icons.notifications_rounded,color: yellow,size: 30,),
             5.widthBox,
             title!.text.semiBold.size(17).make(),
             10.widthBox,


           ],

         ),
       ),
     ),
   );
}


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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

        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.mark_chat_read_rounded,size: 35,color: darkGreen,))
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              notificatioUi(
                title: "Booking Confirmed",
              ),
              notificatioUi(
                title: "Booking Cancelled",
              ),
              notificatioUi(
                title: "Payment Successful"
              ),
              notificatioUi(
                title: "Payment Cancelled"
              ),

            ],
          ),
        ),
      ),
    );
  }
}


