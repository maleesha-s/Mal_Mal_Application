// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Disease/modle/Disease.dart';
import 'package:frontend_mobile/screens/Disease/service/DiseaseService.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseAdd.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseUpdate.dart';
import 'package:frontend_mobile/screens/Welcome/welcome.dart';

class DiseaseView extends StatefulWidget {
  static const String routeName = '/viewDisease';
  const DiseaseView({Key? key}) : super(key: key);

  @override
  State<DiseaseView> createState() => _ViewState();
}

class _ViewState extends State<DiseaseView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.of(context).pushNamed(Welcome.routeName);
      } else if (_selectedIndex == 2) {
        //route --> Jonty
      } else if (_selectedIndex == 3) {
        Navigator.of(context).pushNamed(DiseaseView.routeName);
      }
    });
  }

  late Future<List<Disease>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = DiseaseService().getAllDisease();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'All Diseases';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('All Diseases'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DiseaseAdd.routeName);
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Disease>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                // ignore: avoid_unnecessary_containers
                itemBuilder: (_, index) => Container(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(172, 242, 247, 204),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(58), // Image radius
                            child: Image.asset(
                              'assets/images/rose.jpg',
                              fit: BoxFit.cover,
                              height: 900,
                            ),
                          ),
                        ),
                        Text(
                          // ignore: unnecessary_string_interpolations
                          "${snapshot.data![index].diseaseName}",
                          // ignore: prefer_const_constructors
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // ignore: unnecessary_string_interpolations
                        Text(
                          // ignore: unnecessary_string_interpolations
                          "${snapshot.data![index].antidote}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 22, 22, 22),
                          ),
                        ),
                        // ignore: unnecessary_string_interpolations
                        Text("${snapshot.data![index].description}",
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 138, 137, 135),
                            )),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 150.0, top: 20.0),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Update screen
                            ElevatedButton(
                              child: const Text('Update'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DiseaseUpdate(snapshot.data![index]),
                                    // Pass the arguments as part of the RouteSettings. The
                                    // DetailScreen reads the arguments from these settings.
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 102, 233, 109),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 50.0)),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 150.0, top: 20.0),
                            ),

                            // Delete button
                            ElevatedButton(
                              child: const Text('Remove'),
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DiseaseView()));
                                  futurePost = DiseaseService().deleteDisease(
                                          snapshot.data![index].id)
                                      as Future<List<Disease>>;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 235, 85, 85),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 50.0)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
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
      ),
    );
  }
}
