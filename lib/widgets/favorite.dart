import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:provider/provider.dart';

bool _ShowOnly = true;

enum Fillter { Favorit, all }

class Favorite extends StatefulWidget {
  final String userid;
  const Favorite({required this.userid, Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            'Favorite gyms',
            style: TextStyle(color: Colors.black),
          )),
          elevation: 0,
        ),
        body: ProductGrid(_ShowOnly));
  }
}
