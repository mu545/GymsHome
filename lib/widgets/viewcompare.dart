import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/widgets/comparegrid.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:provider/provider.dart';
  bool _ShowOnly = true;
  
enum Fillter { Favorit, all }
class Viewcompare extends StatefulWidget {
  const Viewcompare({ Key? key }) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Viewcompare> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: CompareGrid(_ShowOnly) 
    );
  }
}