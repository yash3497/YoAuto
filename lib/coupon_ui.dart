import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'constants/colors.dart';
import 'package:dotted_border/dotted_border.dart';


class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {




  List<Map<String, dynamic>> all = [
    {'code': 'A001', 'name': 'Get 50% off', 'desc': 'Get 50% off on your ride'},
    {'code': 'A002', 'name': 'Get 20% off', 'desc': 'Get 20% off on your ride'},
    {'code': 'A003', 'name': 'Get 5% off', 'desc': 'Get 5% off on your ride'},
    {'code': 'A004', 'name': 'Flat 20%', 'desc': 'flat 20% off on your next ride'},
    {'code': 'A005', 'name': 'Flat Rs. 100 off', 'desc': 'get Rs.100 off on your ride'},
    {'code': 'A006', 'name': 'Flat Rs. 150 off', 'desc': 'Get Rs.100 off on your ride'},
    {'code': 'A007', 'name': 'Get 50% + 50% discount', 'desc': 'Get a Chance to win 100% off'},
    {'code': 'A008', 'name': '25% off', 'desc': '25% off on your next 2 ride'},
  ];


  // widget of Coupon Card
  Widget CouponCardWidget({String? code, String? offpercent, String? explain}){
    return Card(
      color: Colors.white,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            offpercent!.text.color(yellow).bold.size(22).shadow(1, 0, 1, Colors.black54).align(TextAlign.start).make(),

            ListTile(
              title: explain!.text.size(16).color(Colors.green).make(),
              trailing: TextButton(onPressed: (){}, child: "Apply".text.bold.size(20).color(lightGreen).make()),
              subtitle:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DottedBorder(
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: code!.text.semiBold.color(Colors.black87).size(15).make(),
                        )),
                  ),
                  " ".text.make(),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white10,
        appBar: AppBar(
          title: "Coupons".text.black.bold.size(27).make(),
          elevation: 0,
          backgroundColor: yellow,
          centerTitle: true,
          leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back_rounded,size: 30,color: Colors.black,)),
        ),

       body: Padding(
           padding: const EdgeInsets.all(10),
           child: Column(

                   mainAxisAlignment: MainAxisAlignment.center,

                   children: [
                      TextField(
                         decoration: InputDecoration(
                           hintText: "Enter Coupon Code",
                           suffixText: "Apply",
                           suffixStyle: TextStyle(
                             color: lightGreen,
                             fontWeight: FontWeight.w700,
                             fontSize: 18
                           )
                         ),
                      ),
                     25.heightBox,

                     "Available Coupons".text.size(25).semiBold.color(Colors.green[800]).center.make(),
                     30.heightBox,

                     Expanded(
                       child: ListView.builder(
                           itemCount: 7,
                           itemBuilder: (context,index){
                         return CouponCardWidget(
                           offpercent: all[index]['name'],
                           code: all[index]['code'],
                           explain: all[index]['desc']
                         );
                       }),
                     )



                   ],


           ),
         ),

    );
  }
}
