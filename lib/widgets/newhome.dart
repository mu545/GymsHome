import 'dart:ffi';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  // Customer? currentc;
  String? uid;
  int _selectedIndex = 0;
  // final SharedPreferences _userdata = await SharedPreferences.getInstance();
  // late Customer c;
  List<Widget>? _list;
  String? name;
  // void getUid() async {
  //   // SharedPreferences _userdata = await SharedPreferences.getInstance();

  //   setState(() {
  //     // uid = _userdata.getString('uid');
  //     // name = _userdata.getString('name');
  //   });
  //   print('name$name');
  //   // print('uid$uid');
  // }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((userdata) {
      setState(() {
        uid = userdata.getString('uid');
      });
      print('uid$uid');
    }).whenComplete((() {
      getlist();
    }));

    // if (mounted) getlist();
  }

  void getlist() {
    setState(() {
      _list = [
        NewWidgetHome(
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
  final String userid;
  NewWidgetHome({
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
  String genderChoosed = 'Men';
  List<GymModel> _gymsList = [];
  // List<GymModel> _gymsListSorted = [];
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
    print('uid' + widget.userid);
    print('by$by');
    switch (by) {
      case 0:
        sortByLocation().whenComplete(() {
          setState(() {
            isloading = false;
          });
        });
        break;
      case 1:
        setState(() {
          isloading = true;
          sortBy = 1;
        });
        break;
      case 2:
        setState(() {
          isloading = true;
          sortBy = 2;
        });
        break;
      default:
    }
  }

  Future<void> sortByLocation() async {
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

        dis1 = await Placelocation.distanceInKM(gym1);
        dis2 = await Placelocation.distanceInKM(gym2);
        if (dis1 > dis2) {
          GymModel tmp = _gymsList[j];
          _gymsList[j] = _gymsList[j + 1];
          _gymsList[j + 1] = tmp;
        }
      }
    }
    print('list' +
        _gymsList[0].location!.latitude.toString() +
        '->' +
        _gymsList[1].location!.latitude.toString());
    // setState(() {});
    // _gymsListSorted = _gymsList;
  }

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
              PopupMenuButton(
                icon: Icon(Icons.sort),
                onSelected: (value) {
                  setState(() {
                    isloading = true;
                    isSort = true;
                  });
                  sortByWhat(value);
                },
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      enabled: true,
                      child: Text("By location"),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text("By Rate"),
                      enabled: false,
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("By price"),
                      enabled: false,
                      value: 2,
                    )
                  ];
                },
              ),
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
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    ElevatedButton(
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
          SizedBox(
            height: 10,
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
                      // else if (isSort) {
                      //   if (sortBy == 'SortByLocation') {
                      //     sortByLocation().whenComplete(() {
                      //       setState(() {
                      //         isloading = false;
                      //       });
                      //     });
                      //   }
                      // }

                      //

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
                                return GymCardCustomer(
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
                      return Center(child: CircularProgressIndicator());
                  },
                )

                      // Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       children: [
                      //         if (_gymsListSorted.isNotEmpty)
                      //           ListView.builder(
                      //             controller:
                      //                 ScrollController(keepScrollOffset: true),
                      //             shrinkWrap: true,
                      //             itemCount: _gymsListSorted.length,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return GymCardCustomer(
                      //                 price: priceChoosed,
                      //                 gymInfo: _gymsListSorted[index],
                      //                 userid: widget.userid,
                      //               );
                      //             },
                      //           ),
                      //         if (isloading)
                      //           Center(child: CircularProgressIndicator()),
                      //         if (_gymsListSorted.isEmpty)
                      //           Center(
                      //               child: Container(
                      //             margin: EdgeInsets.only(top: 100),
                      //             child: Text(
                      //               'No gyms found',
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ))
                      // ],
                      // ),
                      ))
              // ),
              : (!isloading)
                  ?
                  // sort()
                  Sort(
                      gymsList: _gymsList,
                      priceChoosed: priceChoosed,
                      sortBy: sortBy,
                      userid: widget.userid,
                    )
                  : loading()
        ],
      ),
    );
  }

  Widget loading() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100,
        child: Center(child: CircularProgressIndicator()));
  }
}
