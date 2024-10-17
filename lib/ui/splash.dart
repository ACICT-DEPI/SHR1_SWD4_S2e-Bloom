import 'dart:async';
import 'package:bloom/ui/onboarding_screen.dart';
import 'package:bloom/ui/screens/root_page.dart';
import 'package:bloom/ui/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
 
  final showHome;
  const Splash({super.key ,required this.showHome } );

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), () =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>
              (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? const RootPage() : widget.showHome ?  const WelcomScreen() : const  OnboardingScreen()
              )));
  }
    @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        decoration: const BoxDecoration(
          // color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            // opacity: 0.8,
            fit: BoxFit.cover,
          ),
        ),
        child:
            const Center(child: Text("Bloom" , style: TextStyle(fontSize: 50 , color:Color(0xfff8ede3), fontWeight: FontWeight.bold),)),
      ),
    );
  }
}