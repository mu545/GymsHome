import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isedit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDq2REE_qNK1VtPuYlIy6orJZSsZoo6p8kTQ&usqp=CAU'),
                                  fit: BoxFit.cover)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isedit = true;
                                  });
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Name')),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: isedit
                                    ? TextFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      62, 99, 99, 99)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colors.blue_base),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "Enter your name",
                                          hintStyle: TextStyle(
                                            color: colors.hinttext,
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,

                                        // validator: (value) {
                                        //   if (value!.isEmpty || !value.contains('@')) {
                                        //     return 'Invalid email!';
                                        //   }
                                        // },
                                        // onSaved: (value) {
                                        //   _authData['email'] = value!;
                                        // },
                                      )
                                    : Text("your name")),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Email')),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: isedit
                                    ? TextFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      62, 99, 99, 99)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colors.blue_base),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "Enter your name",
                                          hintStyle: TextStyle(
                                            color: colors.hinttext,
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,

                                        // validator: (value) {
                                        //   if (value!.isEmpty || !value.contains('@')) {
                                        //     return 'Invalid email!';
                                        //   }
                                        // },
                                        // onSaved: (value) {
                                        //   _authData['email'] = value!;
                                        // },
                                      )
                                    : Text("your name")),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Password')),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                                child: isedit
                                    ? TextFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      62, 99, 99, 99)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colors.blue_base),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "Enter password",
                                          hintStyle: TextStyle(
                                            color: colors.hinttext,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,

                                        // validator: (value) {
                                        //   if (value!.isEmpty || !value.contains('@')) {
                                        //     return 'Invalid email!';
                                        //   }
                                        // },
                                        // onSaved: (value) {
                                        //   _authData['email'] = value!;
                                        // },
                                      )
                                    : Text("***********")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Center(
                                  child: Text(
                                    'LogOut',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                    width: 20,
                                    height: 40,
                                    margin: EdgeInsets.symmetric(horizontal: 0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.exit_to_app,
                                          color: Colors.white,
                                        )))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
