import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: SupportPage(),
  ));
}


class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);


  Container makeConr( String t1 , String t2, ){
      return Container(
         height: 90,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [

            BoxShadow(
                color: Colors.black26.withOpacity(0.5),

                blurRadius: 4,
                )

          ]
        ),

        child: Expanded(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                   Padding(
                     padding: const EdgeInsets.only(left: 16,top: 10),
                     child: Text("$t1",
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w500
                     ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 10.0),
                     child: TextButton(onPressed: (){},
                         child:Text("$t2",
                         style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.w700,
                           color: Colors.green.shade900
                         ),)
                     ),
                   )
                ],
              ),
              
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading:IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.arrow_back,
            color: Colors.black,

          ),
        ),
        title: Text(
          "Support",
          style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.w900),
        ),
        titleSpacing: 20,
        backgroundColor: Colors.yellow.shade600,
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
                   child: Image.asset("lib/images/support.png",
                     fit: BoxFit.fitWidth,),

                 ),
                 color: Colors.yellow[300],
               ),

              Padding(
                  padding: EdgeInsets.all(15),
                 child: Text("Contact Us",
                 style: TextStyle(
                   fontSize: 23,
                   fontWeight: FontWeight.w900
                 ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: makeConr("Email Us at","yoauto.help@gmail.com"),

              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: makeConr("Call Us at","XXXXXXXXXXXXX"),

              ),


            ],
          ),
        ),
      ),

    );
  }
}

