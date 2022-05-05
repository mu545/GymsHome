import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:transparent_image/transparent_image.dart';

class EditGymInfo extends StatelessWidget {
  EditGymInfo({
    Key? key,
    required this.gym,
  }) : super(key: key);
  final GymModel gym;
  TextEditingController _nameTEC = TextEditingController();
  TextEditingController _DesTEC = TextEditingController();

  Widget title(String title) {
    return Container(
      child: Text(
        '$title',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: colors.blue_base),
      ),
    );
  }
  //

  Widget PriceView(String duration, String price) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: colors.blue_smooth),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text('$duration'), Text('$price')],
          ),
        ),
      ),
    );
  }

  Widget viewImages() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: colors.blue_smooth)),
      height: 200,
      child: Container(
        height: 50,
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: gym.images!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(3),
                child: Image.network(
                  gym.images![index],
                  fit: BoxFit.cover,
                ),
              );
            }),
      ),
    );
  }

  // FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //Future? _getData() => _fireStore.collection("gyms").doc(gymId).get();
  // GymModel _gymProfile =
  //   GymModel([], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Edit gym'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 10),
          child: Card(
            elevation: 3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 1500,
                child: Column(
                  children: [
                    title('Gym Name'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(
                        "${gym.name}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 17),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    title('Gym Description:'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(
                        "${gym.description}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 17),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    title('Gym Display Picture'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: Image.network(gym.imageURL ?? '',
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    title('Gym Images'),
                    SizedBox(
                      height: 8,
                    ),
                    viewImages(),
                    SizedBox(
                      height: 15,
                    ),
                    title('Gym Prices'),
                    SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        PriceView('One Day', gym.priceOneDay.toString()),
                        PriceView('One Month', gym.priceOneDay.toString()),
                        PriceView('Three Months', gym.priceOneDay.toString()),
                        PriceView('Six Months', gym.priceOneDay.toString()),
                        PriceView('One Year', gym.priceOneDay.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
