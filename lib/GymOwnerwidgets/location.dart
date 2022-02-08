import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/facilities.dart';
import 'package:gymhome/widgets/placeloc.dart';

class Location extends StatefulWidget {
  const Location({ Key? key }) : super(key: key);
  static const routenamed= '/loc' ;

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Add Gym', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white, elevation: 0,actions: <Widget>[ IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,),)], ),
      body: Column(
        children: [
          Container( margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10 ),  height: 420, width: 370 , child: Card(child: Column(children: [Text('Location'),    PlaceLocation() ,SizedBox(height: 70,), 
     
         SizedBox(height: 10,)
   ,   
        ],),)), 
        Container(
           width: 250,height: 40,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
           child: FlatButton(
                          child: Text(
                              'Next', style: TextStyle(color: Colors.white),),
                          onPressed: (){ Navigator.of(context).pushNamed(Facilites.routenames);},
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          
                          textColor: Theme.of(context).primaryColor,
                        ),
         ),  
         Container(
           width: 250,height: 40,
           decoration: BoxDecoration(   borderRadius: BorderRadius.circular(20), color: Colors.white),
           child: FlatButton(
             
                          child: Text(
                              'Cancel', style: TextStyle(color: Colors.blue),),
                          onPressed: (){ },
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.blue,
                  width: 1,
                  style: BorderStyle.solid
                ), borderRadius: BorderRadius.circular(50)),
                        ),
         )],
      ),
    );
  }
}