import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gymhome/widgets/db.dart';
import 'package:gymhome/widgets/locationmap.dart';


class great with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void add(String titileimage, File Imagepla) {
    final newpllace = Place(DateTime.now().toString(), titileimage, Imagepla);

    _items.add(newpllace);
    notifyListeners();

    DBhelper.insert('place', {
      'id': newpllace.id,
      'title': newpllace.title,
      'image': newpllace.imgae.path
    });
  }

  Future<void> Fetchandgetdata() async {
    final dataList = await DBhelper.getdata('place');
    _items = dataList
        .map((e) => Place(e['id'], e['title'], File(e['image'])))
        .toList();
    notifyListeners();
  }
}
