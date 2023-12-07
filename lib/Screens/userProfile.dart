import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:newproject/Screens/screen-one.dart';
import 'package:newproject/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../testing/checkuser.dart';
import '../testing/edit.dart';
import 'screen_tow.dart';
class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  var phonelen;
  var countrycode;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController  = TextEditingController();
  final TextEditingController phoneController  = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    ageController.dispose();
    phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
       child: SingleChildScrollView(
         child: Container(
           color: Colors.white,
           padding: const EdgeInsets.symmetric(horizontal: 32),
           width: double.infinity,
           child: Column(
             children: [
               const SizedBox(height: 88,),
               TextFormField(
                 keyboardType: TextInputType.name,
                 controller: usernameController,
                 decoration: InputDecoration(
                   hintText: 'Enter your username',
                 ),
               ),
               const SizedBox(height: 24,),
               TextFormField(
                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                 keyboardType: TextInputType.number,
                 controller: ageController,
                 decoration: InputDecoration(
                   hintText: 'Enter your age',
                 ),
               ),
               const SizedBox(height: 24,),
               // TextFormField(
               //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
               //   keyboardType: TextInputType.number,
               //   controller: phoneController,
               //   decoration: InputDecoration(
               //     hintText: 'Enter your PhoneNumber',
               //   ),
               // ),
               IntlPhoneField(
                 controller: phoneController,
                 onCountryChanged:(value) {
                   countrycode= value.code;
                   phonelen =value.minLength;
                   print(value);
                 },
                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                 decoration: InputDecoration(
                   labelText: 'Phone Number',
                   border: OutlineInputBorder(
                     borderSide: BorderSide(),
                   ),
                 ),
                 initialCountryCode: 'IN',
                 onChanged: (phone) {
                   print(phone.completeNumber);
                 },
               ),
               const SizedBox(height: 14,),
               GestureDetector(
                 onTap: (){
                   if(
                   usernameController?.text == ""||
                       ageController?.text ==""||
                       phoneController?.text ==""||
                       phoneController?.text.length != phonelen){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Enter all details")));
                   }else{
                     var newuser =UserModel(userName:usernameController.text,
                         userAge:int.parse(ageController!.text),
                         userPhoneNumber: phoneController.text ,
                         createDate: DateTime.now());
                     FirebaseFirestore.instance.collection('collections').
                     add(newuser.toJson()).then((value) async {

                       var a=await value.get().then((valu){

                         value.update({
                           'ref':     valu.reference,
                         });
                         value.update({
                           'uid': valu.id,
                         });
                       } );

                     }
                     );
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("successfully added")));
                     phoneController.clear();
                     usernameController.clear();
                     ageController.clear();
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserList()));
                   }

                 },
                 child: Container(
                   child: const Text('Add New User'),
                   width: double.infinity,
                   alignment: Alignment.center,
                   padding: const EdgeInsets.symmetric(vertical: 12),
                   decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(4)
                     ),
                   ),
                       color: Colors.blue
                   ),
                 ),
               ),
               const SizedBox(height: 12,),
               Padding(
                 padding: const EdgeInsets.only(left: 100,top: 50),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserList()));
                   },
                   child: Row(
                     children: [
                       Container(
                         width: 100,
                         height: 50,
                         color: Colors.black,
                         child: Center(child: Text('View',style: TextStyle(color: Colors.white),)),

                       ),
                       SizedBox(width: 20,),
                       GestureDetector(
                         onTap: () async {
                           final SharedPreferences prefs = await SharedPreferences.getInstance();
                           await prefs.remove('isLogged');
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckUser()));
                         },
                         child: Container(
                           width: 70,
                           height: 50,
                           color: Colors.black,
                           child: Center(child: Text('LogOut',style: TextStyle(color: Colors.white),)),

                         ),
                       ),
                     ],

                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
      ),
    );
  }
}
