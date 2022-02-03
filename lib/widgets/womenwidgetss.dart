import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/provider/womengymitems.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:provider/provider.dart';

class WomenWidgtess extends StatefulWidget {
  const WomenWidgtess({ Key? key }) : super(key: key);

  @override
  _WidgtessState createState() => _WidgtessState();
}

class _WidgtessState extends State<WomenWidgtess> {
  @override
  Widget build(BuildContext context) {
     final Gym = Provider.of<Gyms>(context);
       final prodactDate = Provider.of<WomenGymsitems>(context);
    return ClipRRect(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                  
                  
                  
                  child: GridTile(
                    child: GestureDetector(
                      
                      onTap: (){Navigator.of(context).pushNamed(GymDescrption.routeName,arguments:Gym.id );},
                      child: Card(  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10), child: Column(children: [
                        
                        
                        Column(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stack(children: <Widget>[Image.network(Gym.imageUrl, fit: BoxFit.cover,), Row(
                              children: [
                                Container( margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5), height: 40, width: 40, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),  child:  Consumer<Gyms>(
              builder: (ctx, prod, _) => IconButton(
                onPressed: () {
                  Gym.FavoiritStatus();
            
                },
                icon: Icon(
                  Gym.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),),
            // heart(Gym: Gym),
            
                              SizedBox(width: 220,),Container( height: 40, width: 40, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),  child:Consumer<Gyms>(
              builder: (ctx, prod, _) => IconButton(onPressed: (){ Gym.CompareStatus();}, icon: Icon(  Gym.iscompared ? Icons.compare_outlined : Icons.compare_arrows))) )],
                            ),Column(mainAxisAlignment:MainAxisAlignment.end,
                              children: [
                                // Center(child: GridTileBar(   backgroundColor: Colors.black87,title:  Text('Fitness Time'),)),
                              ],
                            )], ),
                          ],
                        ) , Row(children: [Column(children: [Row(
                          children: [
                            Text('4.5', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 8,),
                            Icon(Icons.star) 
                          ],
                        ) , Text('Based on 320 Reviews')],) ,  SizedBox(width: 120,),Column(children: [Text('330 SAR', style: TextStyle(fontWeight: FontWeight.bold),) , Row(
                          children: [
                            Text('55 KM',style: TextStyle(fontWeight: FontWeight.bold)),
                               SizedBox(width: 0,),
                             Icon(Icons.directions_walk) , 
                          ],
                        )],)],)  ],),),
              //       ), footer: GridTileBar(
              // backgroundColor: Colors.black87,
              // title: Text('T'),
                 ), ),
              ),);
  }
}