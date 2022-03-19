import 'package:flutter/material.dart';
import 'components/body.dart';

class Signup extends StatelessWidget {
  static const String routeName='/signup';
  const Signup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}