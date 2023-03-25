import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';


class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {

  //const images

  static const googlepay = "assets/images/googlepay.png";
  static const phonepay = "assets/images/phonePay.png";
  static const razorpay = "assets/images/razorPay.png";
  static const paytm = "assets/images/paytm.png";




  @override
  Widget build(BuildContext context) {



     //List of Images

     List img = [googlepay,phonepay,razorpay,paytm];

     //List of names

    const name = ["Google Pay","PhonePay","RazorPay","Paytm"];







    return Scaffold(
      appBar: AppBar(
        title: "Select Payment Method".text.black.size(20).make(),
        elevation: 0,
        backgroundColor: yellow,
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back_rounded,size: 30,color: Colors.black,)),
      ),

      backgroundColor: Colors.white10,

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 30),
                  child: "Please Select Your Payment Method".text.color(lightGreen).size(20).semiBold.make(),
                )),
              30.heightBox,

            Expanded(
                child:ListView.builder(

                    itemCount: 4,
                    itemBuilder: (context,index){

                  return    Card(

                              elevation: 10,

                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                title: Row(

                                  children: [
                                    Image.asset(img[index],height: 60,width: 100,),
                                    10.widthBox,
                                    name[index].text.size(20).italic.make(),

                                  ],
                                ),
                                trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,color: darkGreen,size: 30,)),
                              ),
                            )    ;
                }))















          ],
        ),
      ),

    );
  }
}
