import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/addgym.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/ownergrid.dart';
import 'package:provider/provider.dart';

class OwnerHome extends StatefulWidget {
  static const rounamed = '/shshs';
  
  const OwnerHome({ Key? key }) : super(key: key);

  @override
  _WidgtessState createState() => _WidgtessState();
}

class _WidgtessState extends State<OwnerHome> {
    bool _ShowOnly  = false ;
  @override
  Widget build(BuildContext context) {
     final Gym = Provider.of<Gyms>(context);
    final gymsdata =  Provider.of<Gymsitems>(context, listen: false).fetchAndSetProducts();
       final prodactDate = Provider.of<Gymsitems>(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('OwnerHOME', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white, elevation: 0,actions: <Widget>[ IconButton(onPressed: (){Navigator.of(context).pushNamed(NewHome.rounamed);} , icon: Icon(Icons.more_vert,color: Colors.black,),)], ),
      body: Ownergrids(_ShowOnly) ,
                  floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.of(context).pushNamed(Editadd.routeName);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      
    );
  }
}