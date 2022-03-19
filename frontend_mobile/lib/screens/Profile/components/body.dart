import 'dart:async';
import 'dart:convert' show jsonDecode, jsonEncode, utf8;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:http/http.dart' as http;
import '../profile.dart';
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
Future<User> fetchUser() async{
  final response = await http
      .get(Uri.parse('http://localhost:8070/users/kithmini_l'));

    if (response.statusCode == 200) {
      final String content =  utf8.decode(response.body.runes.toList());
      final List data = jsonDecode(content);
      return User.fromJson(data[0]);
    } else {
      throw Exception('Failed to load album');
    }
}
class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}
Future<bool> UpdateUser(String userName, String firstName, String lastName, String password) async{
  final response = await http.put(
    Uri.parse('http://localhost:8070/users/update/$userName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstName,
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
    return true;
  } else {
    throw Exception('Failed to add this user.');
  }
}
class _BodyState extends State<Body> {
  late Future<User> futureUser;
  bool res =false;
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerFirstName = TextEditingController();
    final TextEditingController _controllerLastName = TextEditingController();
    final TextEditingController _controllerUserName = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Details"),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {//Text(snapshot.data!.userName);
                _controllerUserName.text = snapshot.data!.userName;
                _controllerFirstName.text = snapshot.data!.firstName;
                _controllerLastName.text = snapshot.data!.lastName;
                _controllerPassword.text = snapshot.data!.password;
                // ignore: unnecessary_new
                return Column(
                  children:  <Widget>[
                    Positioned(
                      top: 5,
                      left: 0,
                      child: Image.asset(
                        "assets/images/profilePic.png",
                        height: 200,
                      ),
                    ),
                    TextField(
                      controller: _controllerUserName,
                      decoration: const InputDecoration(hintText: 'First Name : ',label: Text("User Name"),contentPadding:EdgeInsets.fromLTRB(5, 12, 12, 12) ),
                      readOnly: true,
                    ),
                    TextField(
                      controller: _controllerFirstName,
                      decoration: const InputDecoration(hintText: 'First Name : ',label: Text("First Name"),contentPadding:EdgeInsets.fromLTRB(5, 12, 12, 12) ),
                    ),
                    TextField(
                      controller: _controllerLastName,
                      decoration: const InputDecoration(hintText: 'First Name : ',label: Text("Last Name"),contentPadding:EdgeInsets.fromLTRB(5, 12, 12, 12) ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          res = UpdateUser(_controllerUserName.text,_controllerFirstName.text, _controllerLastName.text, _controllerPassword.text) as bool;
                          res == true ? Navigator.of(context).pushNamed(Profile.routeName) : Navigator.of(context).pushNamed(Login.routeName);
                        });
                      },
                      child: const Text('Create Data'),
                    ),
                  ]
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}