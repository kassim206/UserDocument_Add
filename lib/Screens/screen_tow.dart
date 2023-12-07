import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newproject/model/usermodel.dart';
import 'package:newproject/Screens/screen-one.dart';
class UserList extends StatefulWidget {
  const UserList({super.key});
  @override
  State<UserList> createState() => _UserListState();
}
class _UserListState extends State<UserList> {
  // List ageunder=[20,21,22,23,24,25,26,27,28,29,30];
Stream<List<UserModel>> userList(){
  return FirebaseFirestore.instance.collection('collections')
       // .limit()
      // .where('age',whereIn: ageunder)
      .snapshots()
      .map((event) => event.docs.map((e) => UserModel.fromJson(e.data())).toList());
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.yellow,
        child: StreamBuilder(
          stream: userList(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if(snapshot.hasData){
           List<UserModel>? user= snapshot.data;
           print(user!.length);
           return ListView.builder(
             itemCount: user.length,
             itemBuilder: (BuildContext context, int index) {
               return ScreenOne(user: user,index: index,);
             },
           );
            }
            else{
              return CircularProgressIndicator();
            }
          }
        ),

              ),
      ),
    );
  }
}
