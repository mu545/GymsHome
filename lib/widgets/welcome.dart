// database

import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';
//import icons
//import colors

import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:gymhome/widgets/resetpass.dart';
import 'package:gymhome/models/user.dart';
import 'package:provider/provider.dart';

class welcome extends StatefulWidget {
  //const welcome({Key? key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

final Map<String, GlobalKey<FormState>> _formkeys = {
  'signup': GlobalKey<FormState>(),
  'login': GlobalKey<FormState>()
};
late String email = '';
late String name = '';
late String password = '';
final confpassword = TextEditingController();
bool isSignup = false;
bool iscustomer = true;

class _welcomeState extends State<welcome> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final devicsize = MediaQuery.of(context).size;
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
            child: SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
                width: devicsize.width - 40,
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
                        key:
                            isSignup ? _formkeys['signup'] : _formkeys['login'],
                        child: Column(
                          children: [isSignup ? signup() : login()],
                        ),
                      ),
                    ),

                    //submit botton
                    isLoading
                        ? Container(
                            color: null,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: colors.blue_base,
                            )),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: colors.blue_base,
                                onPrimary: colors.blue_smooth,
                                minimumSize: Size(250, 40)),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              if (isSignup &&
                                  _formkeys['signup']!
                                      .currentState!
                                      .validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                AppUser.signup(iscustomer, email, name,
                                        password, context)
                                    .whenComplete(() => setState(() {
                                          isLoading = false;
                                        }));
                              } else if (!isSignup &&
                                  _formkeys['login']!
                                      .currentState!
                                      .validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                AppUser.login(email, password, context)
                                    .whenComplete(() => setState(() {
                                          isLoading = false;
                                        }));
                                ;
                              }
                            },
                            child: Text(
                              isSignup ? "Sign Up" : "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Epilogue',
                                fontSize: 18,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// signup
  Widget signup() {
    return Column(
      children: [
        // name
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.blue_base),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(10),
                hintText: "name",
                hintStyle: TextStyle(
                  color: colors.hinttext,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) return 'please write your name';
              },
              onChanged: (value) {
                name = value;
              }),
        ),
        // email
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.blue_base),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(10),
                hintText: "email",
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
              }),
        ),
        // password
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.blue_base),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
          ),
        ),
        // confirm password
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: confpassword,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.blue_base),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              contentPadding: EdgeInsets.all(10),
              hintText: "confirm password",
              hintStyle: TextStyle(
                color: colors.hinttext,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty ||
                  value.length < 5 ||
                  confpassword.value.toString() == password) {
                return 'password does not match!';
              }
            },
          ),
        ),
        // enter type
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: iscustomer ? colors.iconscolor : colors.hinttext,
                      ),
                      Text(
                        "Customer",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roborto',
                          color:
                              iscustomer ? colors.iconscolor : colors.hinttext,
                          fontWeight:
                              iscustomer ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // is gym owner?
              GestureDetector(
                onTap: () {
                  setState(() {
                    iscustomer = false;
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.business_rounded,
                        size: 30,
                        color: iscustomer ? colors.hinttext : colors.iconscolor,
                      ),
                      Text(
                        "Gym owner",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roborto',
                          color:
                              iscustomer ? colors.hinttext : colors.iconscolor,
                          fontWeight:
                              iscustomer ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

// login
  Widget login() {
    return Column(
      children: [
        // email
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.blue_base),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(10),
                hintText: "email",
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
              }),
        ),
        // password
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.blue_base),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
// resetpass
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const resetpassword()));
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
      ],
    );
  }
}
