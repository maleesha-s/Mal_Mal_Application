import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Profile/profile.dart';

class Welcome extends StatelessWidget {
  static const String routeName='/welcome';
  final String? uName;
  const Welcome({ Key? key, this.uName }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
            children: <Widget> [
              const Align(
                alignment: Alignment.topLeft,
                child:Text("Dashboard")
              ),
              Align(
                alignment: Alignment.topRight,
                child:IconButton(
                  onPressed: ()=> Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Profile(uName: uName))),
                  icon: const Icon(Icons.account_circle_outlined,color: Colors.white),
                  
                ) 
              )
            ],
          )
      ),
      body: Column(
        children: [
          
        ]
        ),
    );
  }
}