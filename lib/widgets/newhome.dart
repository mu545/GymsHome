import 'dart:ffi';
import 'dart:math';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/models/userdata.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/GymCardCustomer.dart';
import 'package:gymhome/widgets/PaymentScreen.dart';

import 'package:gymhome/widgets/favorite.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/locationmap.dart';
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
  // String? name;
  // Customer? currentc;
  String? uid;
  int _selectedIndex = 0;
  // final SharedPreferences _userdata = await SharedPreferences.getInstance();
  // late Customer c;
  List<Widget>? _list;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((userdata) {
      setState(() {
        // name = userdata.getString('name');
        uid = userdata.getString('uid');
      });
    }).whenComplete((() {
      if (mounted) getlist();
    }));

    /// if (mounted) getlist();
  }

  void getlist() {
    setState(() {
      _list = [
        NewWidgetHome(
          // name: name ?? 'no name',
          userid: uid ?? 'no user',
        ),
        Viewcompare(
          userid: uid ?? 'no user',
        ),
        Favorite(
          userid: uid ?? 'no user',
        ),
        Profile(
          userid: uid ?? 'no user',
        ),
      ];
    });
  }

  @override
  //
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
  // String name;
  final String userid;
  NewWidgetHome({
    // required this.name,
    required this.userid,
    Key? key,
  }) : super(key: key);

  @override
  State<NewWidgetHome> createState() => _NewWidgetHomeState();
}

class _NewWidgetHomeState extends State<NewWidgetHome> {
  bool isSort = false;
  bool isloading = false;
  int sortBy = 0;
  String priceChoosed = 'One Day';
  double? price;
  String genderChoosed = 'Men';
  List<GymModel> _gymsList = [];
  // List<dynamic> _favs = [];
  // List<dynamic> _compare = [];
  GeoPoint? userLocation;

  @override
  void initState() {
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    });

    // Future<String> getDistance(GymModel gym) async {
    //   // final Position locdata = await Geolocator.getCurrentPosition();
    //   // GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    //   final _dis =
    //       await Placelocation.calculateDistance(gym.location!, userLocation!);
    //   return _dis;
    // }
    // var userCompares = FirebaseFirestore.instance
    //     .collection('Customer')
    //     .doc(widget.userid)
    //     .get();
    // userCompares.then((value) {
    //   setState(() {
    //     _compare = value['compare'];
    //   });

    //   print(_compare);
    // });
    // var userLikes = FirebaseFirestore.instance
    //     .collection('Customer')
    //     .doc(widget.userid)
    //     .get();

    // userLikes.then((value) {
    //   setState(() {
    //     _favs = value['Likes'];
    //   });

    //   print(_favs);
    // });

    super.initState();
  }

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

  void sortByWhat(Object? by) {
    switch (by) {
      case 0:
        sortByLocation(true).whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      case 1:
        sortByRate(false).whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      case 2:
        sortByPrice(true).whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      case 3:
        sortByRate(true).whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      case 4:
        sortByPrice(false).whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      case 5:
        sortByLocation(false).whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      default:
    }
  }

  Future<void> sortByLocation(bool ascending) async {
    GeoPoint gym1;
    double dis1;
    GeoPoint gym2;

    double dis2;
    for (int i = 0; i < _gymsList.length - 1; i++) {
      for (int j = 0; j < _gymsList.length - 1 - i; j++) {
        gym1 = GeoPoint(
            _gymsList[j].location!.latitude, _gymsList[j].location!.longitude);
        gym2 = GeoPoint(_gymsList[j + 1].location!.latitude,
            _gymsList[j + 1].location!.longitude);

        dis1 = await Placelocation.distanceInKM(gym1, userLocation!);
        dis2 = await Placelocation.distanceInKM(gym2, userLocation!);
        if (ascending) {
          print('Ascending');
          if (dis1 > dis2) {
            GymModel tmp = _gymsList[j];
            _gymsList[j] = _gymsList[j + 1];
            _gymsList[j + 1] = tmp;
          }
        } else {
          print('dscending');
          if (dis1 < dis2) {
            GymModel tmp = _gymsList[j];
            _gymsList[j] = _gymsList[j + 1];
            _gymsList[j + 1] = tmp;
          }
        }
      }
    }

    print(_gymsList);
  }

  Future<void> sortByRate(bool ascending) async {
    if (ascending)
      _gymsList.sort(
          (a, b) => a.avg_rate!.toDouble().compareTo(b.avg_rate!.toDouble()));
    else
      _gymsList.sort(
          (b, a) => a.avg_rate!.toDouble().compareTo(b.avg_rate!.toDouble()));
  }

  Future<void> sortByPrice(bool ascending) async {
    switch (priceChoosed) {
      case "One Day":
        if (ascending)
          _gymsList.sort((a, b) =>
              a.priceOneDay!.toDouble().compareTo(b.priceOneDay!.toDouble()));
        else
          _gymsList.sort((b, a) =>
              a.priceOneDay!.toDouble().compareTo(b.priceOneDay!.toDouble()));
        break;
      case "One Month":
        if (ascending)
          _gymsList.sort((a, b) => a.priceOneMonth!
              .toDouble()
              .compareTo(b.priceOneMonth!.toDouble()));
        else
          _gymsList.sort((b, a) => a.priceOneMonth!
              .toDouble()
              .compareTo(b.priceOneMonth!.toDouble()));
        break;
      case "Three Months":
        if (ascending)
          _gymsList.sort((a, b) => a.priceThreeMonths!
              .toDouble()
              .compareTo(b.priceThreeMonths!.toDouble()));
        else
          _gymsList.sort((b, a) => a.priceThreeMonths!
              .toDouble()
              .compareTo(b.priceThreeMonths!.toDouble()));
        break;
      case "Six Months":
        if (ascending)
          _gymsList.sort((a, b) => a.priceSixMonths!
              .toDouble()
              .compareTo(b.priceSixMonths!.toDouble()));
        else
          _gymsList.sort((b, a) => a.priceSixMonths!
              .toDouble()
              .compareTo(b.priceSixMonths!.toDouble()));
        break;
      case "One Year":
        if (ascending)
          _gymsList.sort((a, b) =>
              a.priceOneYear!.toDouble().compareTo(b.priceOneYear!.toDouble()));
        else
          _gymsList.sort((b, a) =>
              a.priceOneYear!.toDouble().compareTo(b.priceOneYear!.toDouble()));
        break;
    }
  }

  // getListCompare() {
  //   var user = FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(widget.userid)
  //       .get();
  //   user.then((value) {
  //     _compare = value['compare'];
  //     print(_compare);
  //   });
  // }

  // getListLikes() {
  //   var user = FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(widget.userid)
  //       .get();
  //   user.then((value) {
  //     _favs = value['Likes'];
  //     print(_favs);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //   ),
          // )
          PopupMenuButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (_gymsList.isNotEmpty && _gymsList.length > 1) {
                setState(() {
                  isloading = true;
                  isSort = true;
                });

                sortByWhat(value);
              }
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  enabled: true,
                  child: Text("Nearest"),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text("High Rate"),
                  enabled: true,
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Low Price"),
                  enabled: true,
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("Low Rate"),
                  enabled: true,
                  value: 3,
                ),
                PopupMenuItem(
                  child: Text("High Price"),
                  enabled: true,
                  value: 4,
                ),
                PopupMenuItem(
                  child: Text("Furthest"),
                  enabled: true,
                  value: 5,
                )
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Customer')
                        .doc(widget.userid)
                        .get(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        DocumentSnapshot<Object?> _owner = snapshot.data!;
                        String name = _owner['name'];

                        return Text(
                          "Hi' " + name,
                          style: TextStyle(
                              color: colors.blue_base,
                              fontFamily: 'Roboto',
                              fontSize: 22),
                        );
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        color: colors.blue_base,
                      ));
                    }),
              )
            ],
          ),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                              fontSize: 10),
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
                            fontSize: 10),
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
              SizedBox(
                width: screenSize.width / 9,
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
                      onPressed: () {
                        setState(() {
                          isSort = false;
                        });
                        priceChoose('Day');
                      },
                      child: Text(
                        'Day',
                        style: TextStyle(
                          fontSize: 10,
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
                        setState(() {
                          isSort = false;
                        });
                        priceChoose('Month');
                      },
                      child: Text(
                        'Month',
                        style: TextStyle(
                          fontSize: 10,
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
                        setState(() {
                          isSort = false;
                        });
                        priceChoose('3 Months');
                      },
                      child: Text(
                        '3 Months',
                        style: TextStyle(
                          fontSize: 10,
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
                        setState(() {
                          isSort = false;
                        });
                        priceChoose('6 Months');
                      },
                      child: Text(
                        '6 Months',
                        style: TextStyle(
                          fontSize: 10,
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
                        setState(() {
                          isSort = false;
                        });
                        priceChoose('Year');
                      },
                      child: Text(
                        'Year',
                        style: TextStyle(
                          fontSize: 10,
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
          SizedBox(
            height: 10,
          ),
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection("Customer")
          //       .doc(widget.userid)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       {}
          //     }
          //     return Text('');
          //   }, //end then
          // ),
          (!isSort)
              ? Expanded(
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                  future: _getData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              controller:
                                  ScrollController(keepScrollOffset: true),
                              shrinkWrap: true,
                              itemCount: _gymsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                // bool fav =
                                //     _favs.contains(_gymsList[index].gymId);
                                // bool compare =
                                //     _compare.contains(_gymsList[index].gymId);
                                // print('FAV$fav' + index.toString());
                                // print('Compare$compare' + index.toString());
                                return GymCardCustomer(
                                  // fav: fav,
                                  // compare: compare,
                                  price: priceChoosed,
                                  gymInfo: _gymsList[index],
                                  userid: widget.userid,
                                );
                              },
                            )
                          ],
                        ),
                      );
                    } else
                      return loading();
                  },
                )))
              // ),
              : (!isloading)
                  ? Sort(
                      priceChoosed: priceChoosed,
                      userid: widget.userid,
                      gymsList: _gymsList)
                  // ? Expanded(
                  //     child: SingleChildScrollView(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: [
                  //             ListView.builder(
                  //               controller:
                  //                   ScrollController(keepScrollOffset: true),
                  //               shrinkWrap: true,
                  //               itemCount: _gymsList.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 // bool fav =
                  //                 //     _favs.contains(_gymsList[index].gymId);
                  //                 // bool compare =
                  //                 //     _compare.contains(_gymsList[index].gymId);

                  //                 return GymCardCustomer(
                  //                   // fav: fav,
                  //                   // compare: compare,
                  //                   price: priceChoosed,
                  //                   gymInfo: _gymsList[index],
                  //                   userid: widget.userid,
                  //                 );
                  //               },
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   )
                  : loading()
        ],
      ),
    );
  }

  Widget loading() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Center(child: CircularProgressIndicator()));
  }
}
