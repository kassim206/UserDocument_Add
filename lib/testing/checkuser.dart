import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/userProfile.dart';
import '../navbar/nav.dart';
class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
    color: Colors.white
          ),
            child: Padding(
              padding: const EdgeInsets.only(top: 95,left: 10,right: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Name'
                    ),
                  ),
                  SizedBox(height: 60,),
                  GestureDetector(
                    onTap: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLogged',true);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNav()), (route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('LogIn',style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){},
                      child: Text('No acc LogIn >>>',style: TextStyle(color: Colors.blueAccent),))
                ],
              ),
            ),
      ),
        ),
    )));
  }
}
