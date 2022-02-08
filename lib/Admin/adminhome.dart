import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({ Key? key }) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Admin', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white, elevation: 0,actions: <Widget>[  IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,),)], 
      ),
      body: Column(children: [Row(children: [Center(child: FlatButton(onPressed: (){}, child: Container(height: 100, width: 100, decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)))))],)],),
    );
  }
}