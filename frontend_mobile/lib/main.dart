// import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/AddFlower.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {  },
      child: MaterialApp(
     title: 'My Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ), 
      initialRoute: AddFlower.routeName,
      routes: {
        AddFlower.routeName:(context) => const AddFlower(),

      },
      ),
    );
    
  }
}