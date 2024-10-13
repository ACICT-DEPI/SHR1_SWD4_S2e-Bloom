import 'package:bloom/ui/screens/root_page.dart';
import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:bloom/ui/widgets/custom_textform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloom/ui/forgot_password.dart';
import 'package:bloom/ui/signup_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool passToggle = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

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

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

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
                          image: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                        );
       Fluttertoast.showToast(
                            msg: "Signed in successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.green[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const RootPage(), type: PageTransitionType.bottomToTop));
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/signin.png',
                    width: size.width * 0.6, height: size.width * 0.6),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.alternate_email),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email address must not be empty";
                    } else if (!value.contains('@')) {
                      return "Invalid email address, must contain @ symbol";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: passwordController,
                  isPasswordField: true,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.alternate_email),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not be empty";
                    } else if (value.length < 6) {
                      return "Password is too short";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                        Fluttertoast.showToast(
                            msg: "Signed in successfully",
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
                      } catch (error) {
                    Fluttertoast.showToast(
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                        print(error.toString());
                      }
                    }
                  },
                  child: Button(
                    itext: "Sign In",
                    bgColor: Constants.primaryColor,
                    containerWidth: size.width,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const ForgotPassword(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Forgot Password? ',
                            style: TextStyle(color: Constants.blackColor),
                          ),
                          TextSpan(
                            text: 'Reset Here',
                            style: TextStyle(color: Constants.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                          'Sign In with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const SignUp(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'New to Bloom? ',
                            style: TextStyle(color: Constants.blackColor),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(color: Constants.primaryColor),
                          ),
                        ],
                      ),
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
