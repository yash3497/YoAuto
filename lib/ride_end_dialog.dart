import 'package:flutter/material.dart';



class DialogBox extends StatelessWidget {


  int distance = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          builder: (context) => Center(
         child: MaterialButton(
           child: Text("Route Hisory"),
             height: 50,
             minWidth: 60 ,

             color: Colors.yellow.shade700,
             onPressed: () => showDialog(context: context,
             builder: (BuildContext context){
                AlertDialog dialog = AlertDialog(

                  titlePadding: EdgeInsets.fromLTRB(50, 70, 50, 0),
                



                  title: Text("Ride Ended",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),) ,
                  content: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(" $distance Km traveled",textAlign:TextAlign.center,),
                  ),
                );
                return dialog;
             }
             )

         ),
      )),
    );
  }
}
