import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Flower/ViewFlowers.dart';
import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:frontend_mobile/screens/Profile/profile.dart';

class Welcome extends StatefulWidget {
  static const String routeName='/welcome';
  final String? uName;
  const Welcome({ Key? key, this.uName }) : super(key: key);
  @override
  State<Welcome> createState() => WelcomeBody();
}


class WelcomeBody extends State<Welcome> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        Navigator.of(context).pushNamed(ViewFlowers.routeName);
      }else if(_selectedIndex == 2){
        //route --> Jonty
      }else if(_selectedIndex == 3){
        //route --> Janith
      }
    });
  }

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
                      context, MaterialPageRoute(builder: (context) =>Profile(uName: widget.uName,))),
                  icon: const Icon(Icons.account_circle_outlined,color: Colors.white),
                  
                ) 
              )
            ],
          )
      ),
      body:const Text("data"),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Flowers',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Fertilizers',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Disease',
            backgroundColor: Colors.pink,
            
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}