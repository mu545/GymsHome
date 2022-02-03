import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/widgetss.dart';
import 'package:gymhome/widgets/womenwidgetss.dart';


import 'package:provider/provider.dart';
//import 'package:shop_example/Models/Product.dart';



class Womegrid extends StatelessWidget {
 final bool shoefav;


    Womegrid(this.shoefav);

  @override
  Widget build(BuildContext context) {
    final prodactDate = Provider.of<Gymsitems>(context);
   
     final prodctitem = shoefav ? prodactDate.favoriteitem : prodactDate.items;
    
       
    return  ListView.builder(
        itemCount: prodctitem.length,
        itemBuilder: (ctx, ind) => ChangeNotifierProvider.value(
          value: prodctitem[ind],
          child: WomenWidgtess(),
        ),
       
      
    );
  }
}
