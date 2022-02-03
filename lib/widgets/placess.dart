import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/widgets/help.dart';
import 'package:gymhome/widgets/pic.dart';

import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Place'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Addplace.routeName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<great>(context, listen: false).Fetchandgetdata(),
        builder: (ctx, snap) => Consumer<great>(
          child: Center(
            child: Text('No image yet'),
          ),
          builder: (ctx, greatpla, ch) => ListView.builder(
              itemCount: greatpla.items.length,
              itemBuilder: (ctx, ind) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(greatpla.items[ind].imgae),
                    ),
                    title: Text(greatpla.items[ind].title),
                  )),
        ),
      ),
    );
  }
}
