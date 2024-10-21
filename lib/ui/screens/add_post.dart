import 'dart:io';

import 'package:bloom/constants.dart';
import 'package:bloom/models/post_model.dart';
import 'package:bloom/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
     UserModel? userData;

      File? postImage ;
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source : ImageSource.gallery);

    setState(() {
         if (pickedFile != null ) {
      postImage = File(pickedFile.path);
    } else {
      print("No image selected");
    }
    });
  }

  void uploadPostImage({
    required String text,
    required String time,
  }){
    
   //FirebaseStorage.

  }

    void  CreateNewPost(
      {  
   
    required String text,
    required String time,
     String? postImage,
      }) 
      {

        PostModel model = PostModel(
          userName: userData!.name!, 
          userImage: userData!.image!, 
          userid: userData!.userid!, 
          text: text, 
          time: time, 
          image: postImage??"");

    FirebaseFirestore firestore = FirebaseFirestore.instance;

     firestore.collection('posts')
     .doc("1")
     .set(model.toMap())
     .then((value) {
      
     }). 
     catchError((error) {
     Fluttertoast.showToast(
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 100,
                            backgroundColor: Colors.red[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
     });
  }


    void initState() {
// TODO: implement initState
    super.initState();
    UserModelProvider().getUserData().then((user) {
      setState(() {
        userData = user;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post" , style: Constants.style1,),
        foregroundColor: Constants.primaryColor,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {} , 
            child: Text("Add Post", style: Constants.style2.copyWith(color: Constants.primaryColor)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 30 , left: 20 , right: 20),
        child: Column(
          children: [
             Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Constants.primaryColor,
                            backgroundImage: const AssetImage("assets/plants/5915a8419ddae5a091c77078360f3a3c.jpg"),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child:
                                Text("name", style: Constants.style3),
                          ),
                        ],
                      ),

                        Expanded(
                          child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "What is in your mind ... ",
                                border: InputBorder.none,
                              ),
                            ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_rounded , color:  Constants.primaryColor,),
                                  SizedBox(width: 5,),
                                  Text("Add Photo" , style : TextStyle( color : Constants.primaryColor),),
                                ],
                              ),
                            ),
                          ],
                        )
          ],
        ),
      ),

    );
  }
}