import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/GymOwnerwidgets/EditGymInfo.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/profile_model.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/locationmap.dart';

import '../provider/customer.dart';

class compareCard extends StatefulWidget {
  final String userid;
  final GymModel gymInfo;
  final String price;
  // final bool fav;
  // final bool compare;
  const compareCard(
      {Key? key,
      required this.gymInfo,
      required this.userid,
      // required this.compare,
      // required this.fav,
      required this.price})
      : super(key: key);

  @override
  State<compareCard> createState() => _compareCardState();
}

class _compareCardState extends State<compareCard> {
  GeoPoint? userLocation;
  List<dynamic> listFav = [];
  List<dynamic> listCompare = [];
  // bool? isFav = false;
  // bool? isCompare = false;

  // bool iconClr(type) {
  //   list.clear();
  //   var user = FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(widget.userid)
  //       .get();
  //   user.then((value) {
  //     list = value[type];
  //     print(list);

  //     if (list.contains(widget.gymInfo.gymId)) {
  //       if (type == 'Likes') {
  //         isFav = true;
  //         return isFav;
  //       } else {
  //         isCompare = true;
  //         return isCompare;
  //       }

  //       // return isFav;
  //     } else {
  //       if (type == 'Likes') {
  //         isFav = false;
  //         return isFav;
  //       } else {
  //         isCompare = false;
  //         return isCompare;
  //       }
  //     }
  //   });

  //   if (type == "Likes") {
  //     return isFav;
  //   } else {
  //     return isCompare;
  //   }
  // }

  // bool colorsCompare() {
  //   list.clear();
  //   var user = FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(widget.userid)
  //       .get();
  //   user.then((value) {
  //     list = value['compare'];
  //     print(list);
  //     if (list.contains(widget.gymInfo.gymId)) {
  //       setState(() {
  //         isCompare = true;
  //       });
  //       // return isFav;
  //     } else {
  //       setState(() {
  //         isCompare = false;
  //       });
  //       //  return isFav;
  //     }
  //   });

  //   return isCompare;
  //   //return false;
  // }

  getListFav() {
    listFav.clear();
    var gym = FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gymInfo.gymId)
        .get();
    print(widget.gymInfo.gymId);
    gym.then((value) {
      listFav = value['Likes'];
      handelFavs(listFav);
      // print(list);
    });
    setState(() {});
  }

  getListCompare() {
    listCompare.clear();
    var gym = FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gymInfo.gymId)
        .get();
    print(widget.gymInfo.gymId);
    gym.then((value) {
      listCompare = value['compare'];
      handelCompare(listCompare);
      // print(list);
    });
    setState(() {});
  }

  handelCompare(List list) {
    if (list.contains(widget.userid)) {
      list.remove(widget.userid);
      print('REMOVED FROM LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'compare': FieldValue.arrayRemove([widget.userid])
      });
    } else {
      list.add(widget.userid);
      print('ADD TO LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'compare': FieldValue.arrayUnion([widget.userid])
      });
    }
    setState(() {
      widget.gymInfo.compare = list;
    });
  }

  handelFavs(List list) {
    if (list.contains(widget.userid)) {
      list.remove(widget.userid);
      print('REMOVED FROM LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'Likes': FieldValue.arrayRemove([widget.userid])
      });
    } else {
      list.add(widget.userid);
      print('ADD TO LIST $list');
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(widget.gymInfo.gymId)
          .update({
        'Likes': FieldValue.arrayUnion([widget.userid])
      });
    }
    setState(() {
      widget.gymInfo.Likes = list;
    });
  }

  String distance = 'Loading...';
  String price = '';
  String showPrice() {
    switch (widget.price) {
      case 'One Day':
        setState(() {
          price = widget.gymInfo.priceOneDay.toString() + ' SAR';
        });
        return price;
      case 'One Month':
        setState(() {
          price = widget.gymInfo.priceOneMonth.toString() + ' SAR';
        });
        return price;
      case 'Three Months':
        setState(() {
          price = widget.gymInfo.priceThreeMonths.toString() + ' SAR';
        });
        return price;
      case 'Six Months':
        setState(() {
          price = widget.gymInfo.priceSixMonths.toString() + ' SAR';
        });
        return price;
      case 'One Year':
        setState(() {
          price = widget.gymInfo.priceOneYear.toString() + ' SAR';
        });
        return price;
      default:
        return '';
    }
  }

  void getDistance() async {
    // final Position locdata = await Geolocator.getCurrentPosition();
    // GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    final _dis = await Placelocation.calculateDistance(
        widget.gymInfo.location!, userLocation!);
    if (mounted)
      setState(() {
        distance = _dis;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
    // list.clear();
    // var gym = FirebaseFirestore.instance
    //     .collection('gyms')
    //     .doc(widget.gymInfo.gymId)
    //     .get();
    // print(widget.gymInfo.gymId);
    // gym.then((value) {
    //   list = value['Likes'];

    //   print(list);
    // });
    // isFav = widget.fav;
    // isCompare = widget.compare;
    // getDistance();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var oneDay = widget.gymInfo.priceOneDay.toString();
    var oneMonth = widget.gymInfo.priceOneMonth.toString();
    var threeMonths = widget.gymInfo.priceThreeMonths.toString();
    var sixMonths = widget.gymInfo.priceSixMonths.toString();
    var oneYear = widget.gymInfo.priceOneYear.toString();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GymDescrption(
                  price: widget.price,
                  gym: widget.gymInfo,
                  userid: widget.userid,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.36,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.network(
                        widget.gymInfo.imageURL ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          getListFav();
                        },
                        child: Icon(
                          widget.gymInfo.Likes!.contains(widget.userid)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 42,
                          color: widget.gymInfo.Likes!.contains(widget.userid)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          getListFav();
                        },
                        child: Icon(
                          Icons.favorite_border,
                          size: 43,
                          color: Color.fromARGB(35, 0, 0, 0),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      // top: 10,
                      child: InkWell(
                        onTap: () {
                          getListCompare();
                        },
                        child: Icon(
                          Icons.compare_arrows,
                          size: 42,
                          color: widget.gymInfo.compare!.contains(widget.userid)
                              ? colors.green_base
                              : colors.black100,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Text(
                    widget.gymInfo.name ?? '',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        widget.gymInfo.avg_rate.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      size: 35,
                      color: colors.yellow_base,
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    distance,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          oneDay != '0.0' ? oneDay : '--',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          oneMonth != '0.0' ? oneMonth : '--',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          threeMonths != '0.0' ? threeMonths : '--',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          sixMonths != '0.0' ? sixMonths : '--',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          oneYear != '0.0' ? oneYear : '--',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    // Text(widget.gymInfo.priceOneMonth.toString()),
                    // Text(widget.gymInfo.priceThreeMonths.toString()),
                    // Text(widget.gymInfo.priceSixMonths.toString()),
                    // Text(widget.gymInfo.priceOneYear.toString())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
