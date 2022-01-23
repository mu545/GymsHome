import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Comparepage extends StatefulWidget {
  const Comparepage({Key? key}) : super(key: key);
  static const routeName = '/compareproducts';

  @override
  State<Comparepage> createState() => _ComparepageState();
}

class _ComparepageState extends State<Comparepage> {
  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare products'),
        backgroundColor: Colors.white,

        elevation: 0,
      ),
      body: Row(children: [Column(children: [Container(margin: EdgeInsets.symmetric(horizontal: 10), height: 500, width: 150,  child: Card (   child: Column(
        children: [
          Container( width: 130, height: 100, child: Image.network('')),SizedBox(height: 30,),Text('Fitness Time'), SizedBox(height: 80,),Text('330 SAR'), SizedBox(height: 80,),Text('55 KM'),SizedBox(height: 50,),Text('4.5'),  SizedBox(height: 20,), IconButton(onPressed: (){}, icon: Icon(Icons.delete)) 
        ],
      )))],),Container( 
        margin: EdgeInsets.symmetric(vertical: 190 , horizontal: 5),
        width: 50,
        height: 700,
        child: Column(
          children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.price_check_sharp)),SizedBox(height: 30,) ,  IconButton(onPressed: (){}, icon: Icon(Icons.price_check_sharp)), SizedBox(height: 30,),  IconButton(onPressed: (){}, icon: Icon(Icons.price_check_sharp))
          ],
        ),
      ), SizedBox(width: 7,),Column(children: [Container(margin: EdgeInsets.symmetric(horizontal: 10), height: 500, width: 150,  child: Card (   child: Column(
        children: [
          Container( width: 130, height: 100, child: Image.network('')),SizedBox(height: 30,),Text('Fitness Time'), SizedBox(height: 80,),Text('330 SAR'), SizedBox(height: 80,),Text('55 KM'),SizedBox(height: 50,),Text('4.5'),SizedBox(height: 20,), IconButton(onPressed: (){}, icon: Icon(Icons.delete)) 
        ],
      )))],)],)
    );
  }
}
