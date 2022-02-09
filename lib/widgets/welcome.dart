// database
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';
//import icons
//import colors
import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/resetpass.dart';

import '../authintactions/httpexe.dart';

enum AuthMode { Signup, Login }

class welcome extends StatefulWidget {
  //const welcome({Key? key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

final password2 = TextEditingController();
final _formkey = GlobalKey<FormState>();
AuthMode _auth = AuthMode.Login;
// Map<String, GlobalKey<FormState>> _formKeys = {
//   'signup': GlobalKey<FormState>(),
//   'login': GlobalKey<FormState>()
// };
// Map<String, String> _authData = {
//   'email': '',
//   'password': '',
// };

class _welcomeState extends State<welcome> {
  final _auth = FirebaseAuth.instance;
  late String email = '';
  late String password = '';
  bool isSignup = false;
  bool iscustomer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              // image
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/signup.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 75,
                    left: 20,
                  ),
                  color: Color.fromARGB(146, 71, 153, 183),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Welcom to",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                          ),
                          children: [
                            TextSpan(
                              text: " Gyms Home.",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "all gyms in one place",
                        style: TextStyle(
                          fontFamily: 'Epilogue',
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 208, 79),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 5),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignup = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: 'Epilogue',
                                  fontSize: 18,
                                  color: isSignup
                                      ? colors.black60
                                      : colors.black100),
                            ),
                            // line
                            if (!isSignup)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                width: 90,
                                color: colors.blue_base,
                              ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignup = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontFamily: 'Epilogue',
                                  fontSize: 18,
                                  color: isSignup
                                      ? colors.black100
                                      : colors.black60),
                            ),
                            // line
                            if (isSignup)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                width: 90,
                                color: colors.blue_base,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(62, 99, 99, 99)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colors.blue_base),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "your email",
                                  hintStyle: TextStyle(
                                    color: colors.hinttext,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@'))
                                    return 'Invalid email!';
                                },
                                onChanged: (value) {
                                  email = value;
                                }
                                // onSaved: (value) {
                                //   if (isemail) email = value!;
                                //   if (ispassword) password = value!;
                                // },
                                ),
                          ),
                          // password
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(62, 99, 99, 99)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: colors.blue_base),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                contentPadding: EdgeInsets.all(10),
                                hintText: "password",
                                hintStyle: TextStyle(
                                  color: colors.hinttext,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                              },
                              onChanged: (value) {
                                password = value;
                              },
                              // onSaved: (value) {
                              //   if (isemail) email = value!;
                              //   if (ispassword) password = value!;
                              // },
                            ),
                          ),
                          // confirm password
                          if (isSignup)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: password2,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(62, 99, 99, 99)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colors.blue_base),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "confirm password",
                                  hintStyle: TextStyle(
                                    color: colors.hinttext,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value.length < 5 ||
                                      password2.value.toString() == password) {
                                    return 'password does not match!';
                                  }
                                },
                                onChanged: (value) {
                                  // email = value;
                                },
                                // onSaved: (value) {
                                //   if (isemail) email = value!;
                                //   if (ispassword) password = value!;
                                // },
                              ),
                            ),

                          //  forgot password
                          if (!isSignup)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const resetpassword()));
                                  },
                                  child: Text(
                                    "Forget password?",
                                    style: TextStyle(
                                      fontFamily: 'Epilogue',
                                      fontSize: 16,
                                      color: colors.blue_base,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (isSignup)
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: [
// is customer?

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        iscustomer = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_rounded,
                                          size: 30,
                                          color: iscustomer
                                              ? colors.iconscolor
                                              : colors.hinttext,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Customer",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roborto',
                                            color: iscustomer
                                                ? colors.iconscolor
                                                : colors.hinttext,
                                            fontWeight: iscustomer
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          margin: EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                            color: iscustomer
                                                ? Colors.white
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

// is gym owner?
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        iscustomer = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.business_rounded,
                                          size: 30,
                                          color: iscustomer
                                              ? colors.hinttext
                                              : colors.iconscolor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Gym owner",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roborto',
                                            color: iscustomer
                                                ? colors.hinttext
                                                : colors.iconscolor,
                                            fontWeight: iscustomer
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  //submit botton

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.blue_base,
                        onPrimary: colors.blue_smooth,
                        minimumSize: Size(250, 40)),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      try {
                        // ignore: curly_braces_in_flow_control_structures
                        if (isSignup && _formkey.currentState!.validate()) {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (iscustomer) {
                            FirebaseFirestore.instance
                                .collection("Customer")
                                .doc(email)
                                .set({});
                            Navigator.of(context).pushNamed(NewHome.rounamed);
                          } else {
                            FirebaseFirestore.instance
                                .collection("Gym Owner")
                                .doc(email)
                                .set({});
                            Navigator.of(context).pushNamed(OwnerHome.rounamed);
                          }
                          // Navigator.pushNamed(context, ChatScreen.screenRoute);
                        } else if (!isSignup &&
                            _formkey.currentState!.validate()) {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          var collection = FirebaseFirestore.instance
                              .collection('Gym Owner');
                          var docSnapshot = await collection.doc(email).get();
                          if (docSnapshot.exists) {
                            Navigator.of(context).pushNamed(OwnerHome.rounamed);
                          } else
                            Navigator.of(context).pushNamed(NewHome.rounamed);
                        }
                      } on FirebaseAuthException catch (e) {
                        String messages = e.code;
                        if (e.code == 'weak-password') {
                          messages = 'The password provided is too weak.';
                        } else if (e.code == 'email-already-in-use') {
                          messages =
                              'The account already exists for that email.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              messages,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 16),
                            ),
                            backgroundColor: colors.red_base,
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    }

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ,
                    child: Text(
                      isSignup ? "Sign Up" : "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Epilogue',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
