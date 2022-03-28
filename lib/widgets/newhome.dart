import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/GymCardCustomer.dart';
import 'package:gymhome/widgets/empty.dart';
import 'package:gymhome/widgets/favorite.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/profile.dart';
import 'package:gymhome/widgets/search.dart';
import 'package:gymhome/widgets/viewcompare.dart';
import 'package:gymhome/widgets/womengym.dart';
import 'package:provider/provider.dart';

class NewHome extends StatefulWidget {
  static const rounamed = '/ssssdff';
  const NewHome({Key? key}) : super(key: key);

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int _selectedIndex = 0;
  static const List<Widget> _list = [
    NewWidgetHome(),
    Viewcompare(),
    Empty(),
    Favorite(),
    Profile()
  ];
  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _list[_selectedIndex]),
      bottomNavigationBar: Container(
        width: 200,
        child: BottomNavigationBar(
          //  fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_rounded),
              label: 'Compare',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.sort), label: 's'),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',

              // backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              // backgroundColor: Colors.pink,
            ),
            //  BottomNavigationBarItem(
            //   icon: Icon(Icons.school),
            //   label: 'School',
            // ),
            //  BottomNavigationBarItem(
            //   icon: Icon(Icons.school),
            //   label: 'School',
            // ),
          ],

          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

bool _ShowOnly = false;

class NewWidgetHome extends StatelessWidget {
  //  bool shoefav;
  const NewWidgetHome({
    // this.shoefav =false ,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    List<GymModel> _gymsList = [];

    Future? _getData() => _fireStore
        .collection("gyms")
        .where('isWaiting', isEqualTo: false)
        .get();
// final gymitem = shoefav ? prodactDate.favoriteitem : prodactDate.items;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: colors.blue_base,
        elevation: 0,
        actions: <Widget>[
          Searchlesss(),
        ],
      ),
      body: Column(
        children: [
          //  Container(
          //    height: 50,
          //    child: const Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(),
          //         hintText: 'search ',
          //         // icon: Icon(Icons.search)
          //       ),
          //     ),
          // ),
          //  ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                height: 20,
                width: 180,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      child: FlatButton(
                        highlightColor: Colors.blue,
                        hoverColor: Colors.blue,
                        child: Text(
                          'Men',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        color: Colors.white,
                        onPressed: () => ProductGrid(_ShowOnly),
                      ),
                    ),
                    FlatButton(
                      highlightColor: Colors.blue,
                      hoverColor: Colors.blue,
                      child: Text(
                        'Women',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      color: Colors.white,
                      onPressed: () {/** */},
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                height: 20,
                width: 390,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      child: FlatButton(
                        child: Text(
                          'Day',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        color: Colors.white,
                        onPressed: () {/** */},
                      ),
                    ),

                    FlatButton(
                      child: Text(
                        'Month',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      color: Colors.white,
                      onPressed: () {/** */},
                    ),
                    FlatButton(
                      child: Text(
                        '3 Months',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      color: Colors.white,
                      onPressed: () {/** */},
                    ),
                    FlatButton(
                      child: Text(
                        '6 Months',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      color: Colors.white,
                      onPressed: () {/** */},
                    ),
                    // FlatButton(

                    //     child: Text('Month',style: TextStyle(color: Colors.blue , fontSize: 13),),
                    //     color: Colors.white,
                    //     onPressed: () {/** */},

                    // ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: FutureBuilder(
                  future: _getData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      _gymsList.clear();
                      snapshot.data.docs.forEach((element) {
                        _gymsList.add(GymModel.fromJson(element.data()));
                      });
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _gymsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GymCardCustomer(
                                  gymInfo: _gymsList[index],
                                );
                              },
                            )
                          ],
                        ),
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class heart extends StatelessWidget {
//   const heart({
//     Key? key,
//     required this.Gym,
//   }) : super(key: key);

//   final Gyms Gym;

//   @override
//   Widget build(BuildContext context) {
//      final carta = Provider.of<cart>(context);
//     return Consumer<Gyms>(
//         builder: (ctx, prod, _) => IconButton(
//               onPressed: () {
//                 Gym.favoriteproducts();
//                 carta.additem(
//                     Gym.id, Gym.title, Gym.description, Gym.price, Gym.imageUrl);
//               // Scaffold.of(context).showSnackBar(SnackBar(
//               //   content: Text('Product added to the Cart'),
//               //   duration: Duration(seconds: 2),
//               //   action: SnackBarAction(
//               //     label: 'UNDO',
//               //     onPressed: () {
//               //       // carta.removesingleitem(product.id);
//               //     },
//               //   ),
//               // ));
//               },
//               icon: Icon(
//                 Gym.isadd
//                     ? Icons.shopping_cart : Icons.shopping_cart,

//                 color: Colors.green,
//               ),

//             ));
//   }
// }
