// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:gymhome/models/gyms.dart';
// import 'package:gymhome/provider/gymsitems.dart';
// import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/newSearch.dart';

// import 'package:provider/provider.dart';
// import 'package:search_page/search_page.dart';

class Searchlesss extends StatefulWidget {
  const Searchlesss({Key? key}) : super(key: key);
  @override
  State<Searchlesss> createState() => _SearchlesssState();
}

class _SearchlesssState extends State<Searchlesss> {
  // CollectionReference _firebaseFirestore =
  //     FirebaseFirestore.instance.collection('gyms');

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Gyms>(context).id;

    // final productdata = Provider.of<Gymsitems>(context);

    return FloatingActionButton(
      backgroundColor: Colors.white,
      elevation: 0,
      tooltip: 'Search people',
      onPressed: () => showSearch(context: context, delegate: newSearch()
          // delegate: SearchPage<Gyms>(
          //   onQueryUpdate: (s) => print(s),
          //   items: productdata.items,
          //   searchStyle: TextStyle(color: Colors.purple),
          //   searchLabel: 'Search ',
          //   suggestion: Center(
          //     child: Text(
          //       'Write some characters  ',
          //       style: TextStyle(fontSize: 20, color: Colors.black),
          //     ),
          //   ),
          //   failure: Center(
          //     child: Text('No Gym found :('),
          //   ),
          //   filter: (person) => [
          //     person.title,
          //     person.description,
          //     person.imageUrl,
          //   ],
          //   builder: (person) => ListTile(
          //     onTap: () {
          //       // final productids =
          //       //     ModalRoute.of(context)!.settings.arguments as String;
          //       final product = Provider.of<Gyms>(context, listen: false);
          //       // final produucids = Provider.of<Products>(context, listen: false)
          //       //     .FindbyId(product.id);

          //       Navigator.of(context)
          //           .pushNamed(GymDescrption.routeName, arguments: person.id);
          //     },
          //     leading: CircleAvatar(
          //         child: Padding(
          //       padding: EdgeInsets.all(0),
          //       child: FittedBox(
          //         child: Image.network(person.imageUrl),
          //       ),
          //     )),
          //     title: Text(person.title,
          //         style: TextStyle(fontWeight: FontWeight.bold)),
          //     subtitle: Text(person.description),
          //     trailing: Text(
          //       '\$${person.price}',
          //       style: TextStyle(color: Colors.red),
          //     ),
          //   ),
          // ),
          ),
      child: Icon(
        Icons.search,
        color: Colors.black,
      ),
    );
  }
}
