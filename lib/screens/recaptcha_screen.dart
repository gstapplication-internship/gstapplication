import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';
import 'package:gst/screens/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class ReCaptchaScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyHomePage(title: 'Google ReCaptcha '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String verifyResult = "";
  LoginScreen ls;

  RecaptchaV2Controller captchaV2controller = RecaptchaV2Controller();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Hexcolor("#305c91"),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Hexcolor("#305c91"),
          title: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: FlatButton(
                      child: Text(
                        "SHOW ReCAPTCHA",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        captchaV2controller.show();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    verifyResult,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            RecaptchaV2(
              apiKey: "6Lddie4UAAAAAJfeFfzj_M2UHvgd9Gy80Ot5Z_BZ",
              apiSecret: "6Lddie4UAAAAAC_06GyJQD052PuWdgbSz7IqrZ_n",
              controller: captchaV2controller,
              onVerifiedError: (err) {
                print(err);
              },
              onVerifiedSuccessfully: (success) {
                setState(
                  () {
                    if (success) {
                      verifyResult = "You've been verified successfully.";
                      LoginScreen.enable = true;
                    } else {
                      verifyResult = "Failed to verify.";
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
