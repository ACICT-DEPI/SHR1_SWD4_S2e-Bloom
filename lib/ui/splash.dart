import 'dart:async';
import 'package:bloom/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen())));
  }
    @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        child:
            const Center(child: Text("Bloom" , style: TextStyle(fontSize: 50 , color:Color(0xfff8ede3), fontWeight: FontWeight.bold),)),
      ),
    );
  }
}