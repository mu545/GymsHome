import 'package:flutter/material.dart';
//import icons
//import colors
import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/resetpass.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

Map<String, GlobalKey<FormState>> _formKeys = {
  'signup': GlobalKey<FormState>(),
  'login': GlobalKey<FormState>()
};
Map<String, String> _authData = {
  'email': '',
  'password': '',
};

class _welcomeState extends State<welcome> {
  bool isSignup = true;
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
                  // Sign up
                  if (isSignup)
                    signup()
                  else
                    //Login
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Form(
                        key: _formKeys['login'],
                        child: Column(
                          children: [
                            textfield(false, true, "Your email"),
                            textfield(true, false, "Password"),
                            Align(
                              alignment: Alignment.bottomRight,
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
                                    color: colors.blue_base,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),

                  //submit botton

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.blue_base,
                        onPrimary: colors.blue_smooth,
                        minimumSize: Size(250, 40)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (isSignup &&
                          (_formKeys['signup']!.currentState!.validate())) {}
                      if (!isSignup &&
                          (_formKeys['login']!.currentState!.validate())) {}
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                    },
                    child: Text(
                      isSignup ? "Sign Up" : "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
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

  Container signup() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(children: [
        Form(
          key: _formKeys['signup'],
          child: Column(
            children: [
              textfield(false, true, "Your email"),
              textfield(true, false, "Password"),
              // textfield(true, false, "confirm password"),
            ],
          ),
        ),
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
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: iscustomer ? colors.blue_base : Colors.white,
                        border: Border.all(
                          width: 1,
                          color: colors.hinttext,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: iscustomer
                            ? Color.fromARGB(255, 255, 255, 255)
                            : colors.hinttext,
                      ),
                    ),
                    Text(
                      "Customer",
                      style: TextStyle(
                        color: iscustomer ? colors.black60 : colors.hinttext,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                width: 30,
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
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: iscustomer ? Colors.white : colors.blue_base,
                        border: Border.all(
                          width: 1,
                          color: colors.hinttext,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: iscustomer
                            ? colors.hinttext
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Text(
                      "Gym owner",
                      style: TextStyle(
                        color: iscustomer ? colors.hinttext : colors.black60,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget textfield(bool ispassword, bool isemail, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        obscureText: ispassword,
        keyboardType: isemail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(62, 99, 99, 99)),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.blue_base),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
          hintStyle: TextStyle(
            color: colors.hinttext,
          ),
        ),
        validator: (value) {
          if (isemail && (value!.isEmpty || !value.contains('@'))) {
            return 'Invalid email!';
          }
          if (ispassword && (value!.isEmpty || value.length < 5)) {
            return 'Password is too short!';
          }
        },
        onSaved: (value) {
          if (isemail) _authData['email'] = value!;
          if (ispassword) _authData['password'] = value!;
        },
      ),
    );
  }
}
