import 'dart:io';

import 'package:bloom/constants.dart';
import 'package:bloom/models/user_model.dart';
import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:bloom/ui/widgets/custom_textform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserModel? userData;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController ageController;
  late TextEditingController genderController;


    File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source : ImageSource.gallery);

    setState(() {
         if (pickedFile != null ) {
      profileImage = File(pickedFile.path);
    } else {
      print("No image selected");
    }
    });
  }

  String profileImageUrl = '' ;

  uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
    .ref()
    .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
    .putFile(profileImage!)
    .then((value) {
      value.ref.getDownloadURL().then((val) { 
        setState(() {
         profileImageUrl = val;
      });} ).catchError((error) {});
     
    })
    .catchError((error) {});
  }

    editUserInfo(
    {
      required String name ,
      required String phone ,
      String? age ,
      String? gender , 
      
    }
   ) {
   setState(() {
     
    if (profileImage != null ) {
      uploadProfileImage();
    } else {

    UserModel model = UserModel(
      name : name,
      phone : phone ,
      age: age ,
      gender:  gender,
      email: userData?.email,
      userid: userData?.userid,
      image: userData?.image,
    );
    
    FirebaseFirestore firestore = FirebaseFirestore.instance;

     firestore.collection('users')
     .doc(userData?.userid)
     .update(model.toMap())
     .then((value) {
     setState(() {
        FirebaseFirestore.instance.collection('users').doc(userData?.userid).get()
                          .then((value) {               
                        Fluttertoast.showToast(
                            msg: "Data Updated successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.green[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                      }).catchError((error) {
                        Fluttertoast.showToast(
                            msg: "Somthing went wrong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                        print(error.toString());
                      });
     });
      
     }).catchError((error) {});
  }
   });
}

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    //emailController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();

    UserModelProvider().getUserData().then((user) {
      setState(() {
        userData = user;
      });
    });
  }


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Constants.style1,
        ),
        foregroundColor: Constants.primaryColor,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Edited Data',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.primaryColor.withOpacity(.5),
                        width: 5.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: profileImage == null ? AssetImage("assets/plants/Id1(1).jpg") : FileImage(profileImage!) ,

                      //backgroundImage:image == null ?  NetworkImage('${userData!.image!}') : FileImage(image) ,
                    ),
                  ),
                  IconButton(onPressed: () {
                    getProfileImage();
                  }, 
                  icon: const Icon(Icons.add_a_photo_outlined))

                  ]
                ),
                CustomTextFormField(
                  controller: nameController,
                  labelText: "Full Name",
                  prefixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name must not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  controller: phoneController,
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone Number must not be empty";
                    } else if (value.length < 11) {
                      return " Phone Number must be 11 digit";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                // CustomTextFormField(
                //   controller: emailController,
                //   keyboardType: TextInputType.emailAddress,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Email address must not be empty";
                //     } else if (!value.contains('@')) {
                //       return "Unveiled email address , must contains @ symbol";
                //     }
                //     return null;
                //   },
                //   labelText: "Email Address",
                //   prefixIcon: const Icon(Icons.alternate_email),
                // ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // if (value!.isEmpty)  {
                    //   return "Age must not be empty";
                    // } return null ;
                  },
                  labelText: "Age",
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  controller: genderController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    // if (value!.isEmpty)  {
                    //   return "Gender must not be empty";
                    // } return null ;
                  },
                  labelText: "Gender",
                  prefixIcon: const Icon(Icons.male),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                

                      // uploadProfileImage();
                      setState(() {
                      editUserInfo(
                      name: nameController.text, 
                      phone: phoneController.text , 
                      age : ageController.text , 
                      gender: genderController.text);

                      });
 
                    }
                  },
                  child: Button(
                    itext: "Update Data",
                    bgColor: Constants.primaryColor,
                    containerWidth: size.width,
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
