import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gst/screens/recaptcha_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gst/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gst/screens/recaptcha_screen.dart';

class LoginScreen extends StatefulWidget {
  static bool enable = false;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _gst = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              lowerHalf(context),
              upperHalf(context),
              loginCard(context),
              pageTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.account_box,
            size: 48,
            color: Colors.white,
          ),
          Text(
            "GST LOGIN",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.black,
          Hexcolor("#305c91"),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      height: screenHeight / 2,
      //color: Hexcolor("#305c91"),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        // color: Color(0xFFECF0F3),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 3.5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: "USERNAME", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: "PASSWORD", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _gst,
                    decoration: InputDecoration(
                        labelText: "GST NUMBER", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
<<<<<<< HEAD
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReCaptchaScreen()));
=======
                          String email = _emailController.text.trim();
                          String password = _passwordController.text;
                          String gst = _gst.text;
                          if (email.isEmpty || password.isEmpty || gst.isEmpty){
                            _error();
                          }
                          else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReCaptchaScreen()));
                          }
>>>>>>> 2d9a006cc4e645617d0f6335ed360c33bea02bcc
                        },
                        child: Text("VERIFY RECAPTHA"),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("LOGIN"),
                        color: Hexcolor("#305c91"),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          signIn();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String gst = _gst.text;
    //double tcgst=g.tcgst;

    if (email.isNotEmpty && password.isNotEmpty && gst.isNotEmpty) {
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        _db.collection("users").document(user.user.uid).setData({
          "email": email,
          "lastseen": DateTime.now(),
          "gst": gst,
          //"signin_method": user.user.providerId
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }).catchError(
        (e) {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Hexcolor("#305c91"),
                        ),
                      ),
                    ),
                    Text(
                      "${e.message}",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Hexcolor("#305c91"),
                    ),
                  ),
                ),
                Text(
                  "email password and gst number cannot be empty.",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  _error() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Hexcolor("#305c91"),
                  ),
                ),
              ),
              Text(
                "All fields are required and please verify recaptcha..",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );
      },
    );
  }
}
