// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoauto_task/backend/authentication/authManager.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';

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

  String? phone;

  Future<void> getUserDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = _prefs.getString('phone');
    });
  }

  //-----Logout------//
  Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();

    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();

    Navigator.pop(context, true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => LoginPage())));
    Fluttertoast.showToast(msg: "Logged Out, See You Soon :)");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

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
                            onPressed: () {
                              Get.to(MainScreen());
                            },
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
                    Align(
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
                            phone ?? "+xxxxxxxxx",
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
                  onTap: logout,
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
                      onTap: () async {
                        await AuthManager().updateUserDetails(_address.text,
                            _email.text, _dob.text, _gender.text);
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
