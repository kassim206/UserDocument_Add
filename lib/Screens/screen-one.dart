import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/usermodel.dart';
import '../testing/edit.dart';
class ScreenOne extends StatefulWidget {
   ScreenOne({required this.index, required this.user});
var index;
   List<UserModel>user;
  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController  = TextEditingController();
  final TextEditingController phoneController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Text(widget.user[widget.index].userName.toString()),
              Text(widget.user[widget.index].userAge.toString()),
              Text(widget.user[widget.index].userPhoneNumber.toString())
            ],
          ),
          trailing: Column(
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditUser(
                      countobj: widget.user[widget.index],

                    )));
                  },
                  child: Icon(Icons.edit)),
              SizedBox(height: 6,),
              GestureDetector(
                  onTap: (){
                    widget.user[widget.index].ref!.delete();
                  },
                  child: Icon(Icons.delete)),
            ],
          )

        ),
      ),
    );
  }
}
