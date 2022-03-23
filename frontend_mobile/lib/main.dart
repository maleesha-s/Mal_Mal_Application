import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/SignUp/signup.dart';
import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:frontend_mobile/screens/Profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mal Mal Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Login.routeName,
      routes: {
        Login.routeName:(context) => const Login(),
        Signup.routeName:(context) => const Signup()
      },

    );
  }
}

