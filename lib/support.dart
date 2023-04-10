// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 35,
          ),
        ),
        title: Text(
          "Support",
          style: TextStyle(
              fontSize: 26, color: Colors.black, fontWeight: FontWeight.w900),
        ),
        titleSpacing: 20,
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Image.asset(
                    "assets/images/support_art.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                color: Colors.yellow[600],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      trailing: Icon(Icons.mark_as_unread,size: 30,color: Colors.black,),
                      title: "Email Us At"
                          .text
                          .semiBold
                          .size(17)
                          .color(darkGreen)
                          .make(),

                      subtitle: GestureDetector(
                          onTap: () async {
                            final email = 'yoauto@gmail.com';
                            final Uri launchUri = Uri(
                              scheme: 'mailto',
                              path: email,
                            );
                            await launchUrl(launchUri);
                          },
                          child: "yoauto@gmail.com".text.size(22).black.make()),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      trailing: Icon(Icons.phone_enabled_rounded,size: 30,color: Colors.black,),
                      title: "Call Us At"
                          .text
                          .semiBold
                          .size(17)
                          .color(darkGreen)
                          .make(),
                      subtitle: GestureDetector(
                          onTap: () async {
                            final phoneNumber = '+7260009482';
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: phoneNumber,
                            );
                            await launchUrl(launchUri);
                          },
                          child: "7260009482".text.size(22).black.make()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
