// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../authentication/email_login_page.dart';
import 'editableTextField.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _address =
      TextEditingController(text: "XXXXXXX XXXXXX XXXXX XXXX XXX XX X");
  TextEditingController _email =
      TextEditingController(text: "doejhon123@email.com");
  TextEditingController _dob = TextEditingController(text: "XX/XX/XXXX");
  TextEditingController _gender = TextEditingController(text: "Male");
  bool isEnable = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: height / 3.8,
                width: width,
                color: const Color(0xFFFFCB20),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    //Action Buttons//
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.black,
                            )),
                        isEnable
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isEnable = !isEnable;
                                  });
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 32,
                                  color: Colors.black,
                                ))
                            : SizedBox()
                      ],
                    ),
                    //----------------//
                    //-------Profile-Image-Placeholder-----------//
                    const Icon(
                      Icons.person,
                      size: 164,
                      color: Colors.black26,
                    ),
                    //---------------------------------------------//
                    //------UserName-------//
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            "John Doe",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          //------Phone-No-----//
                          subtitle: Text(
                            "+xxxxxxxxx",
                            style: TextStyle(fontSize: 22, color: Colors.green),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //--------------Form----------//
              EditableTextField(
                controller: _address,
                label: "Address",
                initialValue: "XXXXXXX XXXXXX XXXXX XXXX XXX XX X",
                prefixIcon: const Icon(Icons.location_pin),
                isEnable: isEnable,
              ),
              EditableTextField(
                controller: _email,
                label: "Email",
                initialValue: "doejohn@email.com",
                prefixIcon: const Icon(Icons.email),
                isEnable: isEnable,
              ),
              EditableTextField(
                controller: _dob,
                label: "Date of Birth",
                initialValue: "xx/xx/xxxx",
                prefixIcon: const Icon(Icons.calendar_month),
                isEnable: isEnable,
              ),
              EditableTextField(
                controller: _gender,
                label: "Gender",
                initialValue: "Male",
                prefixIcon: const Icon(Icons.person),
                isEnable: isEnable,
              ),
              //------Logout-Button---------//
              SizedBox(
                height: height / 40,
              ),
              Visibility(
                visible: isEnable,
                child: InkWell(
                  onTap: (() async {
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => LoginPage())));
                    Fluttertoast.showToast(msg: "Logged Out, See You Soon :)");
                  }),
                  child: Container(
                      height: height / 12,
                      width: width,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: width / 20,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              //------------Save-Button--------------//
              Visibility(
                visible: !isEnable,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEnable = !isEnable;
                        });
                      },
                      child: Container(
                        height: height / 12,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
