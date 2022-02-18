import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';

import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/widgetss.dart';

import 'package:provider/provider.dart';
//import 'package:shop_example/Models/Product.dart';

class CompareGrid extends StatelessWidget {
  final bool shoecompare;

  CompareGrid(this.shoecompare);

  @override
  Widget build(BuildContext context) {
    final prodactDate = Provider.of<Gymsitems>(context);
    final Gym = Provider.of<Gyms>(context);
    final Gymid = Provider.of<Gyms>(context).id;
    final cartpro = Provider.of<cart>(
      context,
    );
    final prodctitem =
        shoecompare ? prodactDate.compareitems : prodactDate.items;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            'Compare gyms',
            style: TextStyle(color: Colors.black),
          )),
          elevation: 0,
        ),
        body: shoecompare
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prodctitem.length,
                  itemBuilder: (ctx, ind) => ChangeNotifierProvider.value(
                      value: prodctitem[ind],
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 510,
                                  width: 150,
                                  child: Card(
                                      child: Column(
                                    children: [
                                      Container(
                                          width: 130,
                                          height: 100,
                                          child: Image.network(Gym.imageUrl)),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text('Fitness Time'),
                                      SizedBox(
                                        height: 80,
                                      ),
                                      Text('330 SAR'),
                                      SizedBox(
                                        height: 80,
                                      ),
                                      Text('55 KM'),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text('4.5'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          child: IconButton(
                                              onPressed: () {
                                                cartpro.remove(Gymid);
                                              },
                                              icon: Icon(Icons.delete))),
                                    ],
                                  )))
                            ],
                          ),
                        ],
                      )),
                ),
              )
            : Text(
                'No Gym',
              ));
  }
}
