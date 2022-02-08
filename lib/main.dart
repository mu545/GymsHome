// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Admin/adminhome.dart';
import 'package:gymhome/GymOwnerwidgets/addgym.dart';
import 'package:gymhome/GymOwnerwidgets/facilities.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';
import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/provider/womengymitems.dart';
import 'package:gymhome/widgets/dsd.dart';
import 'package:gymhome/widgets/edit.dart';

import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/help.dart'; 

import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/onerdescrption.dart';
import 'package:gymhome/widgets/payment.dart';
import 'package:gymhome/widgets/pic.dart';
import 'package:gymhome/widgets/placess.dart';
import 'package:gymhome/widgets/profile.dart';
import 'package:gymhome/widgets/signup.dart';
import 'package:gymhome/widgets/ssss.dart';
import 'package:gymhome/widgets/womengym.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

     Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Gymsitems(),
          ),
          ChangeNotifierProvider.value(
            value: Gyms(
                id: '',
                title: '',
                price: 0,
                description: '',
                imageUrl: '',
                isFavorite: false , 
                location:  '' , 
                facilites:  '' , 
                offer: 0,
                hours : '' ,
                ),
                
                
          ),
          

          
          ChangeNotifierProvider(
            create: (ctx) => cart(),
          ),
          //   ChangeNotifierProvider(
          //   create: (ctx) => WomenGymsitems(),
          // ),
             ChangeNotifierProvider(
            create: (ctx) => great(),
          ),
        
        
        ],
    
    
    
    child: Consumer<Gymsitems>(
            builder: (ctx, auth, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
           
                  home: AdminHome (),
                  routes: {
                    NewHome.rounamed : (ctx) =>NewHome() ,
                    OwnerHome.rounamed : (ctx) => OwnerHome() ,
                  GymPrice.routenames :(ctx) =>GymPrice() ,
                    // Comparepage.routeName: (ctx) => Comparepage(),
                    GymDescrption.routeName : (ctx) =>GymDescrption() ,
                    OwnerDescrption.routeName : (ctx) =>OwnerDescrption() ,
                    Location.routenamed : (ctx) => Location() ,
                    Editadd.routeName:(ctx)=>Editadd() ,
                    Facilites.routenames : (ctx) => Facilites() ,
                    Addplace.routeName: (ctx) => Addplace(),
                    // PaymentScreen.routeName : (ctx) => PaymentScreen() 

            //  WomenGrid.routNamed :(ctx) =>WomenGrid(),
                    // Sigsa.routeName: (ctx) => Sigsa(),
                    // Editadd.routeNamed: (ctx) => Editadd(),
                    // Searchforitems.routeNamed: (ctx) => Searchforitems()
                  },
                )));
  }
}