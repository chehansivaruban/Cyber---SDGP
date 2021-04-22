import 'package:flutter/material.dart';
import 'package:solarex/widget/Login.dart';

//import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:solarex/provider/google_sign_in.dart';
//import 'package:provider/provider.dart';
import 'package:solarex/widget/SignUp.dart';

import 'package:solarex/widget/google_sign_up_button.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //  Scaffold(
        //    // appBar: AppBar(),
        //     body: Material(
        //       type: MaterialType.transparency,
        //       child:
        //         Container(
        //           decoration: BoxDecoration(
        //             gradient: LinearGradient(
        //               begin: Alignment.topCenter,
        //               end: Alignment.bottomCenter,
        //               colors: [Color.fromARGB(255, 0, 148, 255), Color.fromARGB(255, 0, 255, 163)] //top bottom color
        //             )
        //           ),
        //           child:Column(
        //             children: <Widget>[
        //               Flexible(
        //               child:FractionallySizedBox(
        //                 heightFactor: 1.0,
        //                 widthFactor: 1.0,
        //                 child: Container(
        //                   child: LayoutBuilder(
        //                     builder: (context, constraints){
        //                     bool resultbool = false;
        //                     final width = constraints.maxWidth;

        //                     return

        //                       Column(
        //                         children: <Widget>[]
        //                       );

        //                 }
        //               )
        //             )
        //           )
        //         )
        //       ]
        //     )
        //       )
        //     )
        //     );

        Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          height: 250,
          child: Image(
            image: AssetImage("images/solarex_LOGO.png"),
            // height: 400,
            width: 400,
            fit: BoxFit.contain,
          ),
        ),
        RichText(
            text: TextSpan(
                text: "Welcome to ",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
              TextSpan(
                  text: "SolareX",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))
            ])),
        SizedBox(height: 30.0),
        Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: Text('REGISTER',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                )),
          ],
        ),
        SizedBox(height: 10.0),
        GoogleSignUpButtonWidget(),
        SizedBox(height: 30.0),
        Text(
          "A Project by Team Cyber",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        )
      ],
    );
  }
}
