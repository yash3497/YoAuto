import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Notifications"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('Users').doc(uid).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("No Notifications"),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                var notifications = snapshot.data!['notifications'][index];
                var msg = notifications['msg'];
                var isOpened = notifications['isOpened'];
                return ListTile(
                  leading: Icon(Icons.notifications),
                  minLeadingWidth: 10,
                  tileColor: isOpened ? Colors.white : Colors.yellow,
                  title: Text(msg),
                ).p(12);
              },
            );
          }),
    );
  }
}
