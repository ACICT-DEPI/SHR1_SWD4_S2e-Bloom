import 'package:bloom/ui/screens/signin_page.dart';
import 'package:bloom/ui/screens/signup_page.dart';
import 'package:bloom/ui/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/signin.png', width: size.width * 0.8 , height:size.width * 0.8,),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Welcome to Bloom',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const SignIn(),
                            type: PageTransitionType.bottomToTop));
                  },
                   child: Button(
                    itext: "Sign In",
                    bgColor: Constants.primaryColor ,
                    containerWidth:size.width ,
                   )
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
                 GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const SignUp(),
                            type: PageTransitionType.bottomToTop));
                  },
                   child: Button(
                    itext: "Sign Up",
                    bgColor: Constants.primaryColor ,
                    containerWidth:size.width ,
                   )
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}