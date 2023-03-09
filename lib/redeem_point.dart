import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'constants/colors.dart';


class RedeemPoint extends StatefulWidget {
  const RedeemPoint({Key? key}) : super(key: key);

  @override
  State<RedeemPoint> createState() => _RedeemPointState();
}

class _RedeemPointState extends State<RedeemPoint> {

    int coins = 1000;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back,size: 32,color: Colors.black,)),
          title: "Redeem Coins".text.bold.black.make(),
          backgroundColor: yellow,






       ),
       backgroundColor: Color.fromRGBO(230, 228, 224, 1),

      body: SingleChildScrollView(
        child: Column(
           children: [
             Container(

               width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.only(bottom: 15),
                 child: Image.asset("lib/images/redeem.png",
                    height: 200,

                  ),

               ),
               color: yellow,
             ),
             20.heightBox,

             Center(
               child: "$coins Coins".text.size(30).bold.color(darkGreen).make(),
             ),
             50.heightBox,

             Container(
               child: Row(

                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                 children: [
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       "₹50 Amazon Coupon".text.size(15).black.make(),
                       3.heightBox,
                       "500 coin".text.black.bold.size(18).make(),
                     ],
                   ),

                   GestureDetector(
                     onTap: (){

                     },
                     child: Container(
                       child: Padding(
                         padding: const EdgeInsets.only(top: 5),
                         child: "Redeem".text.align(TextAlign.center).size(20).white.bold.make(),
                       ),
                     ).box.height(40).width(120).color(custGreen).rounded.shadow3xl.make(),
                   ),

                 ],
               ),
             ).box.height(90).width(MediaQuery.of(context).size.width*0.9).px16.white.rounded.shadow2xl.make(),

           ],
        ),
      ),


    );
  }
}
