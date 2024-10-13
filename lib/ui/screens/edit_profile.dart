import 'package:bloom/constants.dart';
import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:bloom/ui/widgets/custom_textform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
   EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  late TextEditingController ageController;

  late TextEditingController genderController;


    Future editUserInfo(
      {required String name,
      required String phone,
      required String email,
      required String age,
      required String gender,
      required String userid,
      required String image,
      }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('users').doc(userid).update({
      'name': name,
      'phone': phone,
      'email': email,
      'age': age,
      'gender': gender,
      'image' : image,
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
  }



  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile" , style: Constants.style1,),
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
                        CustomTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email address must not be empty";
                            } else if (!value.contains('@')) {
                              return "Unveiled email address , must contains @ symbol";
                            }
                            return null;
                          },
                          labelText: "Email Address",
                          prefixIcon: const Icon(Icons.alternate_email),
                        ),
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
                    SizedBox(height :30),
                     GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)  
                            .then((value) {
                              FirebaseAuth.instance.currentUser!.sendEmailVerification();
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
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                          print(error.toString());
                        });
                        editUserInfo(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          age: ageController.text,
                          gender: genderController.text, 
                          userid: FirebaseAuth.instance.currentUser!.uid,
                          image: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                        );
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

