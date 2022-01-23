// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gymhome/models/favorite.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/comparescreen.dart';
import 'package:gymhome/widgets/gymdescrption.dart';

import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/profile.dart';
import 'package:gymhome/widgets/signup.dart';
import 'package:provider/provider.dart';

void main() {
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
                isFavorite: false
                ),
                
                
          ),
          

          
          ChangeNotifierProvider(
            create: (ctx) => cart(),
          ),
        
        
        ],
    
    
    
    child: Consumer<Gymsitems>(
            builder: (ctx, auth, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'd',
                  home: NewHome(),
                  routes: {
                  
                    Comparepage.routeName: (ctx) => Comparepage(),
                    GymDescrption.routeName : (ctx) =>GymDescrption()

               
                    // Sigsa.routeName: (ctx) => Sigsa(),
                    // Editadd.routeNamed: (ctx) => Editadd(),
                    // Searchforitems.routeNamed: (ctx) => Searchforitems()
                  },
                )));
  }
}