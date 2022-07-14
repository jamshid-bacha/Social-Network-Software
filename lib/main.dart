import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snapp4/screens/login.dart';
import 'package:snapp4/screens/register.dart';

import 'screens/WelcomeApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInOrRegister(result: false),
      routes: {
        LandingScreen.id: (context) => const LandingScreen(),
        Login.id: (context) => Login(),
      },
    );
  }
}
