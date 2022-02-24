import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/addgym.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:provider/provider.dart';

class OwnerHome extends StatefulWidget {
  static const rounamed = '/shshs';

  const OwnerHome({Key? key}) : super(key: key);

  @override
  _WidgtessState createState() => _WidgtessState();
}

class _WidgtessState extends State<OwnerHome> {
  bool _ShowOnly = false;
  @override
  Widget build(BuildContext context) {
    final Gym = Provider.of<Gyms>(context);

    final prodactDate = Provider.of<Gymsitems>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'HOME',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ProductGrid(_ShowOnly),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('Waiting');
          Navigator.of(context).pushNamed(AddGymInfo.routeName);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
