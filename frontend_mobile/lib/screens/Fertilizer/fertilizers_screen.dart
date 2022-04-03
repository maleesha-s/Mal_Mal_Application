import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend_mobile/providers/fertilizer_provider.dart';
import 'package:frontend_mobile/screens/Fertilizer/Widgets/fertilizer_tile_widget.dart';
import 'package:frontend_mobile/screens/Fertilizer/Widgets/snack_bar.dart';
import 'package:frontend_mobile/screens/Fertilizer/add_edit_fertilizer_screen.dart';
import 'package:frontend_mobile/screens/Fertilizer/view_fertilizer.dart';
import 'package:provider/provider.dart';

class FertilizersScreen extends StatefulWidget {
  const FertilizersScreen({Key? key}) : super(key: key);
  static const String routeName = '/fertilizers';
  @override
  State<FertilizersScreen> createState() => _FertilizersScreenState();
}

class _FertilizersScreenState extends State<FertilizersScreen> {
  late bool loading;
  @override
  void initState() {
    loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Fertilizers fertilizers = Provider.of<Fertilizers>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditFertilizerScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      // drawer: const AppDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                'Fertilizers',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<Fertilizers>(context, listen: false)
                  .fetchFertilizers(),
              builder: (ctx, dataSnapshot) {
                if (fertilizers.fertilizers.isEmpty) {
                  return Center(
                    child: Text(
                      'No Fertilizers To Load',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                }
                return Consumer<Fertilizers>(
                  builder: (ctx, fertilizerData, child) => ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: fertilizerData.getFertilizers().length,
                    itemBuilder: (ctx, i) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        deleteFertilizerDialog(
                            fertilizerData.getFertilizers()[i].id);
                      },
                      child: GestureDetector(
                        onTap: () async {
                          Provider.of<Fertilizers>(context, listen: false)
                              .fetchFertilizer(
                                  fertilizerData.getFertilizers()[i].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ViewFertilizerScreen(),
                            ),
                          );
                        },
                        child: FertilizerTile(
                          fertilizerData.getFertilizers()[i],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  deleteFertilizerDialog(id) {
    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          elevation: 0.0,
          title: Row(
            children: const [
              Icon(
                Icons.delete,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Delete Fertilizer"),
            ],
          ),
          content: const Text(
            'Are you sure you want to do this ?',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey[600]),
                )),
            TextButton(
                onPressed: () {
                  deleteFertilizer(id);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ))
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  deleteFertilizer(fertilizerID) async {
    await Provider.of<Fertilizers>(context, listen: false)
        .deleteFertilizer(fertilizerID)
        .then(
      (result) {
        Navigator.pop(context);
        if (result is String) {
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(result));
        } else {}
      },
      onError: (message) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(message));
      },
    );
  }
}
