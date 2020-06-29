import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class GstCal extends StatefulWidget {
  @override
  _GstState createState() => _GstState();
}

class _GstState extends State<GstCal> {
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  String _extension;
  double pcgst = 0;
  double scgst = 0;
  double psgst = 0;
  double ssgst = 0;
  double pigst = 0;
  double sigst = 0;

  var tsgst;
  var tigst;
  var gst;
  var tgst=0.0;
  var tcgst;
  static int check=0;
  String ss;

  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getUid();
    setData();
  }

  void setData() async {
    FirebaseUser u = await _auth.currentUser();
    var date = DateTime.now();
    var s = DateFormat('yyyy-MMM-dd');
    ss = s.format(date);
    setState(() {
      user = u;
      _db
          .collection("users")
          .document(user.uid)
          .collection("userinfo")
          .document("gstinfo")
          .get().then((value) {
        tcgst = value.data["tcgst"];
        tigst = value.data["tigst"];
        tsgst = value.data["tsgst"];
        print(tcgst);
        print(tsgst);
        print(tigst);
      });

        if (check == 0) {
          _db.collection("users")
              .document(user.uid)
              .collection("userinfo")
              .document("gstinfo")
              .collection("paymentinfo")
              .document(ss)
              .setData({
            "tgst":0,
          });
        }
        else {
          _db.collection("users")
              .document(user.uid)
              .collection("userinfo")
              .document("gstinfo")
              .collection("paymentinfo")
              .document(ss)
              .get()
              .then((value) {
                tgst=value.data["tgst"];
                print(tgst);
          });
        }

    });
  }


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        width: double.infinity,
        height: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Hexcolor("#305c91"), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                    child: Text(
                      'ENTER TAX',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 30),
                    )),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 20, left: 15.0, right: 15.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        elevation: 20,
                        margin: EdgeInsets.only(top: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: DropdownButton(
                                hint: Text('SELECT GST'),
                                items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text('CGST'),
                                    value: "CGST",
                                  ),
                                  DropdownMenuItem(
                                    child: Text('SGST'),
                                    value: "SGST",
                                  ),
                                  DropdownMenuItem(
                                    child: Text('IGST'),
                                    value: "IGST",
                                  ),
                                ],
                                onChanged: (value) =>
                                    setState(() {
                                      if (value == "CGST") {
                                        _extension = value;
                                      }
                                      if (value == "SGST") {
                                        _extension = value;
                                      }
                                      if (value == "IGST") {
                                        _extension = value;
                                      }
                                    }),
                                isDense: true,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              child: _extension == "CGST"
                                  ? TextField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                onChanged: (value) {
                                  setState(() {
                                    pcgst = value.length > 0
                                        ? double.parse(value)
                                        : 0;
                                    //print(pcgst);
                                    gst = (scgst - pcgst + tcgst) +
                                        (ssgst - psgst + tsgst) +
                                        (sigst - pigst + tigst);
                                    _controller6.text =
                                        gst.toStringAsFixed(2);
                                  });
                                },
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: 'CGST',
                                  labelText: 'ENTER PURCHASE CGST',
                                  labelStyle: textStyle,
                                  border: tBorder(),
                                ),
                              )
                                  : Container(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: _extension == "CGST"
                                  ? TextField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                onChanged: (value) {
                                  setState(() {
                                    scgst = value.length > 0
                                        ? double.parse(value)
                                        : 0;
                                    //print(scgst);
                                    gst = (scgst - pcgst + tcgst) +
                                        (ssgst - psgst + tsgst) +
                                        (sigst - pigst + tigst);
                                    _controller6.text =
                                        gst.toStringAsFixed(2);
                                  });
                                },
                                controller: _controller1,
                                decoration: InputDecoration(
                                    hintText: 'CGST',
                                    labelText: 'ENTER SELLING CGST',
                                    labelStyle: textStyle,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0))),
                              )
                                  : Container(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: _extension == "SGST"
                                  ? TextField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                onChanged: (value) {
                                  setState(() {
                                    psgst = value.length > 0
                                        ? double.parse(value)
                                        : 0;
                                    //print(psgst);
                                    gst = (scgst - pcgst + tcgst) +
                                        (ssgst - psgst + tsgst) +
                                        (sigst - pigst + tigst);
                                    _controller6.text =
                                        gst.toStringAsFixed(2);
                                  });
                                },
                                controller: _controller2,
                                decoration: InputDecoration(
                                  hintText: 'SGST',
                                  labelText: 'ENTER PURCHASE SGST',
                                  labelStyle: textStyle,
                                  border: tBorder(),
                                ),
                              )
                                  : Container(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: _extension == "SGST"
                                  ? TextField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                onChanged: (value) {
                                  setState(() {
                                    ssgst = value.length > 0
                                        ? double.parse(value)
                                        : 0;
                                    //print(ssgst);
                                    gst = (scgst - pcgst + tcgst) +
                                        (ssgst - psgst + tsgst) +
                                        (sigst - pigst + tigst);
                                    _controller6.text =
                                        gst.toStringAsFixed(2);
                                  });
                                },
                                controller: _controller3,
                                decoration: InputDecoration(
                                  hintText: 'SGST',
                                  labelText: 'ENTER SELLING SGST',
                                  labelStyle: textStyle,
                                  border: tBorder(),
                                ),
                              )
                                  : Container(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: _extension == "IGST"
                                  ? TextField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                onChanged: (value) {
                                  setState(() {
                                    pigst = value.length > 0
                                        ? double.parse(value)
                                        : 0;
                                    //print(pigst);
                                    gst = (scgst - pcgst + tcgst) +
                                        (ssgst - psgst + tsgst) +
                                        (sigst - pigst + tigst);
                                    _controller6.text =
                                        gst.toStringAsFixed(2);
                                  });
                                },
                                controller: _controller4,
                                decoration: InputDecoration(
                                  hintText: 'IGST',
                                  labelText: 'ENTER PURCHASE IGST',
                                  labelStyle: textStyle,
                                  border: tBorder(),
                                ),
                              )
                                  : Container(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: _extension == "IGST"
                                  ? TextField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                onChanged: (value) {
                                  setState(() {
                                    sigst = value.length > 0
                                        ? double.parse(value)
                                        : 0;
                                    //print(sigst);
                                    gst = (scgst - pcgst + tcgst) +
                                        (ssgst - psgst + tsgst) +
                                        (sigst - pigst + tigst);
                                    _controller6.text =
                                        gst.toStringAsFixed(2);
                                  });
                                },
                                controller: _controller5,
                                decoration: InputDecoration(
                                  hintText: 'IGST',
                                  labelText: 'ENTER SELLING IGST',
                                  labelStyle: textStyle,
                                  border: tBorder(),
                                ),
                              )
                                  : Container(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                style: textStyle,
                                controller: _controller6,
                                decoration: InputDecoration(
                                  labelText: 'TOTAL GST',
                                  hintText: 'TOTAL GST',
                                  labelStyle: textStyle,
                                  border: tBorder(),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        //color: Colors.white,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 3,
                              height: 60,
                              margin: EdgeInsets.all(10),
                              //color: Colors.black,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Hexcolor("#305c91"),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  clear();
                                },
                                child: Text("CLEAR",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),),
                              ),
                            ),

                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2,
                              margin: EdgeInsets.all(7),
                              // color: Colors.black,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Hexcolor("#305c91"),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  pay();
                                },
                                child: Text("PAY",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 40,
                        child: FlatButton(
                          onPressed: () async {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  tBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
    );
  }

  void clear() async {
    _controller.clear();
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    _controller5.clear();
    _controller6.clear();
  }

  void pay() async {
    if (gst > 0) {
      print(
          "you have pay $gst Tax to Government.\nTHANKYOU");
    } else {
      print(" $gst Tax is Credited.\nTHANKYOU");
    }

    tcgst = scgst - pcgst + tcgst;
    if (tcgst < 0) {
      _db
          .collection("users")
          .document(user.uid)
          .collection("userinfo")
          .document("gstinfo")
          .updateData({
        "tcgst": tcgst,
      });
    } else {
      print("error");
    }


    tsgst = ssgst - psgst + tsgst;
    if (tsgst < 0) {
      _db
          .collection("users")
          .document(user.uid)
          .collection("userinfo")
          .document("gstinfo")
          .updateData({
        "tsgst": tsgst,
      });
    } else {
      print("error");
    }


    tigst = sigst - pigst + tigst;
    if (tigst < 0) {
      _db
          .collection("users")
          .document(user.uid)
          .collection("userinfo")
          .document("gstinfo")
          .updateData({
        "tigst": tigst,
      });
    } else {
      print("error");
    }




    tgst += gst;
    if (tgst > 0) {
      check++;
      print(tgst);
      setState(() {

        _db.collection("users")
            .document(user.uid)
            .collection("userinfo")
            .document("gstinfo")
            .collection("paymentinfo")
            .document(ss)
            .updateData({
          "tgst":tgst,
        }).then((value){

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
                      "Rs $tgst is paid successfully",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
          );

        });
      });
    }

  }

}