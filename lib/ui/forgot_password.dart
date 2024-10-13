import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:bloom/ui/signin_page.dart';
import 'package:bloom/ui/widgets/custom_textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloom/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  
  late TextEditingController emailController  = TextEditingController();


    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Constants.blackColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/reset-password.png'),
              const Text(
                'Forgot\nPassword',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: emailController, 
                labelText:'Email Address', 
                prefixIcon:const Icon(Icons.alternate_email),
                keyboardType: TextInputType.emailAddress,
                validator:  (value) {
                    if (value!.isEmpty) {
                      return "Email address must not be empty";
                    } else if (!value.contains('@')) {
                      return "Invalid email address, must contain @ symbol";
                    }
                    return null;
                  },),
                 const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async{
                  if (emailController.text == " ") {
                    // اطلع رسا
                  Fluttertoast.showToast(
                            msg: "Email address must not be empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 50,
                            backgroundColor: Colors.red[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                    return;
                  };
                  try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                  // اطلعله 
                     Fluttertoast.showToast(
                            msg: "Password Reset Email has been send to your email address , please check your email.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 30,
                            backgroundColor: Colors.green[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const SignIn(),
                          type: PageTransitionType.bottomToTop));
                  } catch(e) {
                  // رساله
                      Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 50,
                            backgroundColor: Colors.red[200],
                            textColor: Colors.grey,
                            fontSize: 16.0);
                  }
                },
                 child: Button(
                  itext:  'Reset Password',
                  bgColor: Constants.primaryColor,
                  containerWidth: size.width,
                 ),
              ),
              const SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //         context,
              //         PageTransition(
              //             child: const SignIn(),
              //             type: PageTransitionType.bottomToTop));
              //   },
              //   child: Center(
              //     child: Text.rich(
              //       TextSpan(children: [
              //         TextSpan(
              //           text: 'Have an Account? ',
              //           style: TextStyle(
              //             color: Constants.blackColor,
              //           ),
              //         ),
              //         TextSpan(
              //           text: 'Login',
              //           style: TextStyle(
              //             color: Constants.primaryColor,
              //           ),
              //         ),
              //       ]),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
