import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
//user class
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

//http request
Future<User> addNewUser(String userName, String firstName, String lastName, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8070/users/addUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userName': userName,
      'firstName':firstName,
      'lastName':lastName,
      'password':password
    }),
  );
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "User Successfully Added!",
        //toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add this user.');
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
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerFirstName = TextEditingController();
    final TextEditingController _controllerLastName = TextEditingController();
    final TextEditingController _controllerUserName = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controllerFirstName,
          decoration: const InputDecoration(hintText: 'First Name : '),
        ),
        TextField(
          controller: _controllerLastName,
          decoration: const InputDecoration(hintText: 'Last Name : '),
        ),
        TextField(
          controller: _controllerUserName,
          decoration: const InputDecoration(hintText: 'User Name : '),
        ),
        TextField(
          controller: _controllerPassword,
          decoration: const InputDecoration(hintText: 'Password : '),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              addNewUser(_controllerUserName.text,_controllerFirstName.text, _controllerLastName.text, _controllerPassword.text);
             });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }
}