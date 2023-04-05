import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';





 //netowork not found dialogbox

Widget NetworkIssueAlert(){
  return  AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 50),






    icon: Icon(CupertinoIcons.wifi_exclamationmark,color: Colors.redAccent,size: 50,),//networkIssue


    title: Text("network problem",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,
        color: Colors.red[800],fontWeight: FontWeight.bold),) ,


  );
}



//location not found dialog box
Widget LocationNotFoundAlert(){
  return  AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 50),







    icon: Icon(CupertinoIcons.location_slash_fill,color: Colors.redAccent,size: 50,),//location not Found



    title: Text("location not found",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,
        color: Colors.red[800],fontWeight: FontWeight.bold),) ,


  );
}



//payment not successful dialog

Widget PaymentFailedAlert(){
  return  AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 50),






    icon: Icon(CupertinoIcons.xmark_shield_fill,color: Colors.redAccent,size: 50,),//payment failed


    title: Text("payment failed",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,
        color: Colors.red[800],fontWeight: FontWeight.bold),) ,


  );
}




// Rider not Found Dialog

Widget RiderNotFound(){
  return  AlertDialog(
    titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 50),






    icon: Icon(CupertinoIcons.person_crop_circle_fill_badge_xmark,color: Colors.redAccent,size: 50,), //rider not found


    title: Text("rider not found",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,
        color: Colors.red[800],fontWeight: FontWeight.bold),) ,


  );
}