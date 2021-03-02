import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'Login.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[

            Container(
              margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              height: 300,
              child: Image(image: AssetImage("images/solarex_LOGO.png"),
                 // height: 400,
                  width: 400,
                  fit: BoxFit.contain,),
            ),

            RichText(
                text: TextSpan(
                    text: "Welcome to ",
                    style:
                    TextStyle(fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),

                    children: <TextSpan>[
                      TextSpan(
                          text: "SolareX",
                          style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.black)
                      )
                    ]
                )
            ),
            SizedBox(height: 30.0),


            Row(
              children: <Widget>[


                Container(
                    margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),

                    child: ElevatedButton(


                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },

                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text('LOGIN', style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),

                      ),

                      style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),),


                    )
                ),

                Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

                    child: ElevatedButton(
                      onPressed: () { },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        child: Text('REGISTER', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),),

                      style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),),

                    )
                ),

              ],
            ),

            SizedBox(height: 10.0),


            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            ),

            SizedBox(height: 30.0),
            Text("A Project by Team Cyber", style: TextStyle(color: Colors.black,fontSize: 20.0 ),)
          ],
        ),
      ),
       backgroundColor: Colors.amber,

    );
  }


}
