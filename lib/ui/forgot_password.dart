import 'package:bloom/ui/widgets/custom_button.dart';
import 'package:bloom/ui/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:bloom/constants.dart';
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
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email address must not be empty";
                    } else if (!value.contains('@')) {
                      return "Invalid email address, must contain @ symbol";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                 const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                 child: Button(
                  itext:  'Reset Password',
                  bgColor: Constants.primaryColor,
                  containerWidth: size.width,
                 ),
                // Container(
                //   width: size.width,
                //   decoration: BoxDecoration(
                //     color: Constants.primaryColor,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                //   child: const Center(
                //     child: Text(
                //       'Reset Password',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 18.0,
                //       ),
                //     ),
                //   ),
                // ),
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
                        text: 'Have an Account? ',
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
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
    );
  }
}
