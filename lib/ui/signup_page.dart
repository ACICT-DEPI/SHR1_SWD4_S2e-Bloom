import 'package:bloom/constants.dart';
import 'package:bloom/ui/screens/root_page.dart';
import 'package:bloom/ui/signin_page.dart';
import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:bloom/ui/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passToggle = true;
  bool confirmpassToggle = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController ageController;
  late TextEditingController genderController;

  // late String userid;

  Future addUser(
      {required String name,
      required String phone,
      required String email,
      required String age,
      required String gender,
      required String userid,
      required String image,
      }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('users').doc(userid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'age': age,
      'gender': gender,
      'image' : image,
    });
  }

  Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if(googleUser == null ) {return;};

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);
                           addUser(
                          name: "",
                          phone: "",
                          email: "",
                          age: "",
                          gender: "", 
                          userid: FirebaseAuth.instance.currentUser!.uid,
                          image: "assets\default-avatar-icon-of-social-media-user-vector.jpg",
                        );
      Fluttertoast.showToast(
                            msg: "Signed Up successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.green[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
    Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const RootPage(),
                                type: PageTransitionType.bottomToTop));
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
        backgroundColor: Colors.transparent,
        foregroundColor: Constants.blackColor,
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/signup.png',
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign Up',
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
                    controller: passwordController,
                    isPasswordField: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password must not be empty";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_open),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    isPasswordField: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password must not be empty";
                      } else if (value != passwordController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.lock_open),
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
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                            msg: "Registerd successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.green[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
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
                        addUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          age: ageController.text,
                          gender: genderController.text, 
                          userid: FirebaseAuth.instance.currentUser!.uid,
                          image: "assets\default-avatar-icon-of-social-media-user-vector.jpg",
                        );
                      }
                    },
                    child: Button(
                      itext: "Sign Up",
                      bgColor: Constants.primaryColor,
                      containerWidth: size.width,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                        signInWithGoogle();
                    },
                    child: Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Image.asset('assets/images/google.png'),
                          ),
                          const Text(
                            'Sign Up with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const SignIn(),
                              type: PageTransitionType.bottomToTop));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Arealdy Have an Account? ',
                            style: TextStyle(
                              color: Constants.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Constants.primaryColor,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PassUserData {
  String? userid;
  String? name;
  String? phone;
  String? email;
  String? age;
  String? gender;
  String? image; 
}
