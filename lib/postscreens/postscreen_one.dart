import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:newproject/model/mediaModel.dart';
import 'package:image_picker/image_picker.dart';

class PostHome extends StatefulWidget {
  const PostHome({super.key});

  @override
  State<PostHome> createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {
  var addpost;
  update({required ImageSource media}) async {

    ImagePicker imagePicker=ImagePicker();
    XFile? file=await imagePicker.pickImage(source: media);
    var ref=FirebaseStorage.instance.ref().child("kassim/image-${DateTime.now()}");
    UploadTask uploadTask =ref.putFile(File(file!.path));
    uploadTask.then((p0) async =>
    addpost= (await ref.getDownloadURL()).toString()).then((value) {
      print(addpost);
      setState(() {

      });

    });
    // var image=await ref.getDownloadURL();
    // print("====================================================$image");



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              update(media: ImageSource.camera);
            },
            child: Icon(Icons.camera_enhance)),
        title: Center(child: Text("PostAdd")),
        actions: [
          GestureDetector(
              onTap: (){
                update(media: ImageSource.gallery);
              },
              child: Icon(Icons.image))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 70,left: 20,),
          child: Column(
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(addpost??""),fit: BoxFit.cover)),

              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  var newpost =MediaModel(userId: '123',
                      userName: 'kassim',
                      postDescription: 'hey',
                      likesList: [],
                      postUrl: addpost,
                      uploadedTime: DateTime.now());
                  FirebaseFirestore.instance.collection('post')
                      .add(newpost.toJson()).then((value) async {
                    var a=await value.get().then((valu){

                      value.update({
                        'ref': valu.reference,
                      });
                    } );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(" successfully uploaded")));
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                  ),
                  child: Center(child: Text('Uploud',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
