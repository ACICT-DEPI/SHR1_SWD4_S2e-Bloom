import 'package:bloom/ui/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
//final showHome = prefs.getBool('showHome') ?? false;
  await Firebase.initializeApp();
  runApp(const MyApp(/*showHome : showHome*/));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6a9c89)),
        useMaterial3: true,
      ),
      home: const Splash(),
      // home:  showHome ? Splash() : OnboardingScreen(),
    );
  }
}


