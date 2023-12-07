import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newproject/Screens/screen-one.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/userProfile.dart';
import '../navbar/nav.dart';
import 'checkuser.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigateTopage() {
    Timer(Duration(seconds: 3), () async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getBool('isLogged') ==null){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CheckUser()), (route) => false);
  }else{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNav()), (route) => false);
  }
    });
  }

  @override
  void initState() {
    super.initState();
    // gotoLogin();
    navigateTopage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Container(
          child: Center(
            child: Text('SplashScreeen', style: TextStyle(color: Colors.yellow,
                fontWeight: FontWeight.bold,fontSize: 40),),
          ),
        ),
      ),
    );
  }
}
  


