import 'package:flutter/material.dart';
import 'components/body.dart';
class Profile extends StatelessWidget {
  static const String routeName='/profile';
  const Profile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}