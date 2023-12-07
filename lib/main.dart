import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newproject/pagination/pagenate.dart';
import 'package:newproject/story/home.dart';
import 'package:newproject/testing/splash.dart';

import 'Screens/userProfile.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAzieXGMPpMDRxigOD9Rcetj0NUmyDghuQ",
            appId: "1:780083421710:android:bf4f65524ea4aa4334d25f",
            messagingSenderId: "G-D8B0ELYK9M",
            projectId: "newproject-a6786")
    );
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // w=MediaQuery.of(context).size.width;
    // h=MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testingpurpose',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumbersPage(),
    );
  }
}
