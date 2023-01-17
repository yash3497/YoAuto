import 'package:flutter/material.dart';


class WalletTransaction extends StatefulWidget {
  const WalletTransaction({Key? key}) : super(key: key);

  @override
  State<WalletTransaction> createState() => _WalletTransactionState();
}

class _WalletTransactionState extends State<WalletTransaction> {


      String date = " August 11th 2022";

      String time = "8.30 ";

      String amPm = " am";






   



  Container makeContOne ( String date,String time, String amPm,){
     return Container(

        margin: const EdgeInsets.only(right: 12,left: 12,top: 15,),

        width: 400,
       height: 75,

       
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(15),
           boxShadow: [
             BoxShadow(
                 color: Color.fromRGBO(0, 0, 0, 0.1).withOpacity(0.1),

                 blurRadius: 1,
               spreadRadius: 2,
               offset: Offset(1, 1.5)



                 )
           ]
         
       ),
       
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [

                 Text("$date",style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600
                 ),),
                 Text("₹ XX",
                   style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.w600
                   ),)

               ],

             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                       Text(" $time $amPm"),
                      Text("Ride",)
               ],

             ),
           )
         ],
       ),

     );
  }

      Container makeContTwo ( String date,String time, String amPm,){
        return Container(

          margin: EdgeInsets.only(right: 12,left: 12,top: 15,),

          width: 400,
          height: 75,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),

              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1).withOpacity(0.1),

                    blurRadius: 1,
                    spreadRadius: 2,
                    offset: Offset(1, 1.5)



                )
              ]

          ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text("$date",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                    Text("₹ XXX",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),)

                  ],

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(" $time $amPm"),
                    Text("Money Added",style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.w500
                    ),)
                  ],

                ),
              )
            ],
          ),

        );
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 203, 32, 1),

           leading:IconButton(
           padding: EdgeInsets.only(left: 15),
          onPressed: (){

          },
          icon: Icon(Icons.arrow_back,
            color: Colors.black,size: 35,

          ),
        ),
          title: Text("Wallet Transaction",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black
              ),),

      ),


      backgroundColor: Color.fromRGBO(230, 228, 224, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              makeContOne("$date", "$time", "$amPm" ),
              makeContOne("$date", "$time", "$amPm" ),
              makeContOne("$date", "$time", "$amPm" ),
              makeContTwo("$date", "$time", "$amPm" ),
              makeContOne("$date", "$time", "$amPm" ),
              makeContOne("$date", "$time", "$amPm" ),
              makeContOne("$date", "$time", "$amPm" ),
              makeContTwo("$date", "$time", "$amPm" ),
              makeContOne("$date", "$time", "$amPm" ),









            ],

          ),
        ),
      ),
    );
  }
}
