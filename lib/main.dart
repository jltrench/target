import 'package:flutter/material.dart';
import 'package:target_sistemas/routes/routes.dart';
import 'package:target_sistemas/screens/login_screen.dart';
import 'package:target_sistemas/screens/texting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Target Sistemas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        Routes.login: (context) => const LoginScreen(),
        Routes.texting: (context) => const TextingScreen(),
      },
    );
  }
}
