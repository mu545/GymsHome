import 'dart:ffi';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/models/userdata.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/GymCardCustomer.dart';
import 'package:gymhome/widgets/PaymentScreen.dart';

import 'package:gymhome/widgets/favorite.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newSearch.dart';
import 'package:gymhome/widgets/profile.dart';
import 'package:gymhome/widgets/search.dart';
import 'package:gymhome/widgets/viewcompare.dart';
import 'package:gymhome/widgets/womengym.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/customer.dart';
import 'package:gymhome/widgets/newSearch.dart';

import 'Sort.dart';

class NewHome extends StatefulWidget {
  static const rounamed = '/ssssdff';

  const NewHome({Key? key}) : super(key: key);

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  // Customer? currentc;
  String? _uid;
  int _selectedIndex = 0;
  // final SharedPreferences _userdata = await SharedPreferences.getInstance();
  // late Customer c;
  List<Widget>? _list;

  void getUid() async {
    SharedPreferences _userdata = await SharedPreferences.getInstance();
    // String? email = _userdata.getString('email');
    // String? name = _userdata.getString('name');
    // String? profilePicture = _userdata.getString('profilePicture');
    // String? uid = _userdata.getString('uid');
    setState(() {
      _uid = _userdata.getString('uid');
      // currentc = Customer(
      //     email: email ?? '',
      //     profilePicture: '',
      //     uid: uid ?? '',
      //     name: name ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    getUid();
    getlist();
  }

  void getlist() {
    setState(() {
      _list = [
        NewWidgetHome(
          userid: _uid ?? '',
        ),
        Viewcompare(
          userid: _uid ?? '',
        ),
        Sort(
          userid: _uid ?? '',
        ),
        Favorite(
          userid: _uid ?? '',
        ),
        Profile(
          userid: _uid ?? '',
        ),
      ];
    });
  }

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    // init();
    return Scaffold(
      body: Center(child: _list![_selectedIndex]),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              label: 'Sort',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',

              // backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],

          currentIndex: _selectedIndex,
          selectedItemColor: colors.blue_base,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

bool _ShowOnly = false;

class NewWidgetHome extends StatefulWidget {
  //  bool shoefav;
  // Customer? customer;
  final String userid;
  NewWidgetHome({
    required this.userid,
    Key? key,
  }) : super(key: key);

  @override
  State<NewWidgetHome> createState() => _NewWidgetHomeState();
}

class _NewWidgetHomeState extends State<NewWidgetHome> {
  String priceChoosed = 'One Day';
  String genderChoosed = 'Men';
  void genderChoose(gender) {
    switch (gender) {
      case "Men":
        setState(() {
          genderChoosed = "Men";
        });

        break;
      case "Women":
        setState(() {
          genderChoosed = "Women";
        });
        break;
      default:
    }
  }

  void priceChoose(price) {
    switch (price) {
      case "Day":
        setState(() {
          priceChoosed = 'One Day';
        });
        break;
      case "Month":
        setState(() {
          priceChoosed = 'One Month';
        });
        break;
      case "3 Months":
        setState(() {
          priceChoosed = 'Three Months';
        });
        break;
      case "6 Months":
        setState(() {
          priceChoosed = 'Six Months';
        });
        break;
      case "Year":
        setState(() {
          priceChoosed = 'One Year';
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    List<GymModel> _gymsList = [];

    Future? _getData() {
      switch (priceChoosed) {
        case 'One Day':
          return _fireStore
              .collection("gyms")
              .where(
                'isWaiting',
                isEqualTo: false,
              )
              .where('gender', isEqualTo: genderChoosed)
              .where('prices', arrayContains: 'One Day')
              .get();

        case 'One Month':
          return _fireStore
              .collection("gyms")
              .where(
                'isWaiting',
                isEqualTo: false,
              )
              .where('gender', isEqualTo: genderChoosed)
              .where('prices', arrayContains: 'One Month')
              .get();
        case 'Three Months':
          return _fireStore
              .collection("gyms")
              .where(
                'isWaiting',
                isEqualTo: false,
              )
              .where('gender', isEqualTo: genderChoosed)
              .where('prices', arrayContains: 'Three Months')
              .get();
        case 'Six Months':
          return _fireStore
              .collection("gyms")
              .where(
                'isWaiting',
                isEqualTo: false,
              )
              .where('gender', isEqualTo: genderChoosed)
              .where('prices', arrayContains: 'Six Months')
              .get();
        case 'One Year':
          return _fireStore
              .collection("gyms")
              .where(
                'isWaiting',
                isEqualTo: false,
              )
              .where('gender', isEqualTo: genderChoosed)
              .where('prices', arrayContains: 'One Year')
              .get();

        default:
          return _fireStore
              .collection("gyms")
              .where(
                'isWaiting',
                isEqualTo: false,
              )
              .where('gender', isEqualTo: genderChoosed)
              .get();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
            child: Text(
          'HOME',
          style: TextStyle(color: Colors.white, fontFamily: "Epilogue"),
        )),
        backgroundColor: colors.blue_base,
        elevation: 0,
        actions: <Widget>[
          Searchlesss(userID: widget.userid),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                height: 20,
                // width: 180,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      child: ElevatedButton(
                        child: Text(
                          'Men',
                          style: TextStyle(
                              color: genderChoosed == 'Men'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(side: BorderSide.none)),
                            backgroundColor: genderChoosed == 'Men'
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(209, 71, 153, 183))
                                : MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          genderChoose('Men');
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Women',
                        style: TextStyle(
                            color: genderChoosed == 'Women'
                                ? Colors.white
                                : Colors.black,
                            fontSize: 13),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(side: BorderSide.none)),
                          backgroundColor: genderChoosed == 'Women'
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(209, 71, 153, 183))
                              : MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        genderChoose('Women');
                      },
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                height: 20,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      //    minWidth: 50,
                      onPressed: () {
                        priceChoose('Day');
                      },
                      child: Text(
                        'Day',
                        style: TextStyle(
                          color: priceChoosed == 'One Day'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(side: BorderSide.none)),
                          backgroundColor: priceChoosed == 'One Day'
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(209, 71, 153, 183))
                              : MaterialStateProperty.all(Colors.white)),
                    ),
                    ElevatedButton(
                      //     minWidth: 10,
                      onPressed: () {
                        priceChoose('Month');
                      },
                      child: Text(
                        'Month',
                        style: TextStyle(
                          color: priceChoosed == 'One Month'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(side: BorderSide.none)),
                          backgroundColor: priceChoosed == 'One Month'
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(209, 71, 153, 183))
                              : MaterialStateProperty.all(Colors.white)),
                    ),
                    ElevatedButton(
                      //    minWidth: 10,
                      onPressed: () {
                        priceChoose('3 Months');
                      },
                      child: Text(
                        '3 Months',
                        style: TextStyle(
                          color: priceChoosed == 'Three Months'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(side: BorderSide.none)),
                          backgroundColor: priceChoosed == 'Three Months'
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(209, 71, 153, 183))
                              : MaterialStateProperty.all(Colors.white)),
                    ),
                    ElevatedButton(
                      //   minWidth: 10,
                      onPressed: () {
                        priceChoose('6 Months');
                      },
                      child: Text(
                        '6 Months',
                        style: TextStyle(
                          color: priceChoosed == 'Six Months'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(side: BorderSide.none)),
                          backgroundColor: priceChoosed == 'Six Months'
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(209, 71, 153, 183))
                              : MaterialStateProperty.all(Colors.white)),
                    ),
                    ElevatedButton(
                      //   minWidth: 10,
                      onPressed: () {
                        priceChoose('Year');
                      },
                      child: Text(
                        'Year',
                        style: TextStyle(
                          color: priceChoosed == 'One Year'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(side: BorderSide.none)),
                          backgroundColor: priceChoosed == 'One Year'
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(209, 71, 153, 183))
                              : MaterialStateProperty.all(Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: FutureBuilder(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  _gymsList.clear();
                  snapshot.data.docs.forEach((element) {
                    _gymsList.add(GymModel.fromJson(element.data()));
                  });

                  if (_gymsList.isEmpty)
                    return Center(
                        child: Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Text(
                        'No gyms found',
                        textAlign: TextAlign.center,
                      ),
                    ));

                  //
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            controller:
                                ScrollController(keepScrollOffset: true),
                            shrinkWrap: true,
                            itemCount: _gymsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GymCardCustomer(
                                price: priceChoosed,
                                gymInfo: _gymsList[index],
                                userid: widget.userid,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
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
