import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/onerdescrption.dart';
import 'package:provider/provider.dart';

class OwnerWidgetss extends StatefulWidget {
  const OwnerWidgetss({ Key? key }) : super(key: key);

  @override
  _WidgtessState createState() => _WidgtessState();
}

class _WidgtessState extends State<OwnerWidgetss> {
  @override
  Widget build(BuildContext context) {
     final Gym = Provider.of<Gyms>(context);
       final prodactDate = Provider.of<Gymsitems>(context);
    return ClipRRect(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                  
                  
                  
                  child: GridTile(
                    child: GestureDetector(
                      
                      onTap: (){Navigator.of(context).pushNamed(OwnerDescrption.routeName,arguments:Gym.id );},
                      child: Card(  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10), child: Column(children: [
                        
                        
                        Column(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stack(children: <Widget>[Image.network(Gym.imageUrl, fit: BoxFit.cover,), Row(
                              children: [
                            
            // heart(Gym: Gym),
            
                           ],
                            ),Column(mainAxisAlignment:MainAxisAlignment.end,
                              children: [
                                // Center(child: GridTileBar(   backgroundColor: Colors.black87,title:  Text('Fitness Time'),)),
                              ],
                            )], ),
                          ],
                        ) ,Column(children: [Row(
                          children: [
                           Text(Gym.title, style: TextStyle(fontWeight: FontWeight.bold),),  SizedBox(width: 280,),  Text(Gym.price.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('SAR')
                          ],
                        ) , ],)],)  ),),
              //       ), footer: GridTileBar(
              // backgroundColor: Colors.black87,
              // title: Text('T'),
                 ), ),
              );
  }
}