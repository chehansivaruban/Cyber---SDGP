import 'dart:async';
import 'Start.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Start())));
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height) - kToolbarHeight;
    double width = (MediaQuery.of(context).size.width);
    return Material(
        type: MaterialType.transparency,
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 0, 70, 122),
                  Color.fromARGB(255, 0, 224, 254)
                ] //top bottom color
                    )),
            child: Stack(children: <Widget>[
              Container(
                height: kToolbarHeight,
              ),
              Container(
                  margin: EdgeInsets.only(top: height * 0.3),
                  alignment: Alignment.center,
                  height: height * 0.3,
                  width: width,
                  child: Image.asset('images/Logo.png',
                      height: height * 0.28,
                      width: width * 0.45,
                      fit: BoxFit.fill)),
              Container(
                margin: EdgeInsets.only(top: height),
                alignment: Alignment.center,
                width: width,
                child: Text(
                  "Project by Team Cyber",
                  style:
                      TextStyle(fontSize: height * 0.03, color: Colors.white),
                ),
              )
            ])));
  }
}
