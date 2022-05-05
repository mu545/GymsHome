// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:gymhome/GymOwnerwidgets/facilities.dart';

import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';

import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';

import 'package:gymhome/provider/gymsitems.dart';

import 'package:gymhome/provider/womengymitems.dart';
import 'package:gymhome/widgets/AddGym.dart';

// import 'package:gymhome/widgets/customer_list.dart';

// import 'package:gymhome/widgets/reviwe.dart';

import 'package:gymhome/widgets/help.dart';

import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/onerdescrption.dart';
import 'package:gymhome/widgets/pic.dart';

import 'package:gymhome/widgets/welcome.dart';

import 'package:provider/provider.dart';

// user data

import 'package:shared_preferences/shared_preferences.dart';

bool? iscustomer;
// Customer? currentc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // MapsInitializer.initialize();
// to read and write user data
  final _userdata = await SharedPreferences.getInstance();
  iscustomer = _userdata.getBool('iscustomer');

  // UserData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get userid
    // String? uid;
    // UserData.getUserId().then((value) => uid = value);
    // bool? iscustomer;
    // UserData.isCustomer().then((value) => iscustomer = value);
    //  get home
    Widget getHome(bool iscustomer) {
      // UserData.isCustomer().then((value) => iscustomer = value);
      // print('uid = ');
      // print(uid);
      // return welcome();
      if (iscustomer)
        return NewHome();
      // return Location();
      else
        return OwnerHome();
    }

    return MultiProvider(
        providers: [
          // ChangeNotifierProvider.value(
          //   value: Review(
          //       uid: '',
          //       name: '',
          //       profileimg: '',
          //       rate: 0.0,
          //       comment: '',
          //       time: ''),
          // ),
          // ChangeNotifierProvider.value(
          //   value: User(),
          // ),
          ChangeNotifierProvider.value(
            value: Gymsitems(),
          ),

          // ChangeNotifierProvider.value(
          //   value: Auth(),
          // ),
          ChangeNotifierProvider.value(
            value: AddGymMethods(),
          ),
          // ChangeNotifierProvider.value(
          //   value: Auth(),
          // ),
          // ChangeNotifierProvider.value(
          //   value: Customer(name: ''),
          // ),
          ChangeNotifierProvider.value(
            value: Gyms(
              id: '',
              title: '',
              price: 0,
              description: '',
              imageUrl: '',
              location: '',
              facilites: '',
            ),
          ),

          ChangeNotifierProvider(
            create: (ctx) => cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => WomenGymsitems(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => great(),
          ),
        ],
        child: Consumer<Gymsitems>(
            builder: (ctx, auth, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  // if uid null then the user should login
                  home: iscustomer == null ? welcome() : getHome(iscustomer!),
                  routes: {
                    NewHome.rounamed: (ctx) => NewHome(
                        // currentc: Customer(
                        //     email: '', name: '', profilePicture: '', uid: ''),
                        ),
                    //     ImageInput.routenamed: (ctx) => ImageInput(),
                    OwnerHome.rounamed: (ctx) => OwnerHome(),
                    //   GymPrice.routenames: (ctx) => GymPrice(),
                    // Comparepage.routeName: (ctx) => Comparepage(),
                    // GymDescrption.routeName: (ctx) => GymDescrption(),
                    OwnerDescrption.routeName: (ctx) => OwnerDescrption(),
                    // Location.routenamed: (ctx) => Location(),
                    //      AddGymInfo.routeName: (ctx) => AddGymInfo(gym:),
                    Facilites.routenames: (ctx) => Facilites(),
                    Addplace.routeName: (ctx) => Addplace(),

                    //  WomenGrid.routNamed :(ctx) =>WomenGrid(),
                    // Sigsa.routeName: (ctx) => Sigsa(),
                    // Editadd.routeNamed: (ctx) => Editadd(),
                    // Searchforitems.routeNamed: (ctx) => Searchforitems()
                  },
                )));
  }
}
