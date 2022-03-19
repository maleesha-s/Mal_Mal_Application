import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Profile/profile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:frontend_mobile/screens/SignUp/signup.dart';
import 'background.dart';

class User{
  final String userName;
  final String firstName;
  final String lastName;
  final String password;

  const User({required this.userName, required this.firstName, required  this.lastName, required this.password});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password']
    );
  }
}


class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
  
}

class _BodyState extends State<Body> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  void userLogin(String userName, String password) async {
    // final response = await http.post(
    //   Uri.parse('http://localhost:8070/users/login'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'userName': userName,
    //     'password':password
    //   }),
    // );
    // if (response.statusCode == 200) {
    //   dynamic data = jsonDecode(response.body);
    //   Fluttertoast.showToast(
    //       msg:(data![0].userName),
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 5,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    //   return User.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to get this user.');
    // }
    if(_controllerUserName.text=="Maleesha_s" && _controllerPassword.text == "16924"){
      Fluttertoast.showToast(
          msg:"Login Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).pushNamed(Profile.routeName);
    }else{
      Fluttertoast.showToast(
          msg:"Login Failed!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color.fromARGB(255, 54, 244, 76),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/images/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(  
              controller: _controllerUserName,
              decoration: InputDecoration( 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                fillColor: Color.fromARGB(255, 217, 186, 247),
                filled: true,
                hintText: 'Username',  
                labelText: 'Username',
                
              ),  
              
              style: const TextStyle(
                color:Colors.black,
                fontWeight:FontWeight.bold,
                
              ),
              
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              controller: _controllerPassword,
              decoration: InputDecoration( 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                fillColor: const Color(0xFF6F35A5),
                filled: true,
                
                hintText: 'Password',  
                labelText: 'Password',  
              ),  
            ),
            // IconButton(
            //   onPressed: (){
            //     Navigator.of(context).pushNamed(Signup.routeName);
            //   }, 
            //   icon: const Icon(
            //     Icons.app_registration_rounded,
            //     ),
            // ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userLogin(_controllerUserName.text, _controllerPassword.text);
                });
                // Navigator.of(context).pushNamed(Signup.routeName);
              },
              child: const Text('Login'),
            ),

          ]
        )
      ),
    );
  }
}