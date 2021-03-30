import 'package:flutter/material.dart';

import 'package:solarex/screens/With_shading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,

      body: SingleChildScrollView(
        child: Stack(
               
          children :<Widget>[
            Container(
              
              child: Column(
                children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                     
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            child: Image.asset('images/shading.jpeg' ,
                            fit: BoxFit.contain,
                            //width: 400,
                            //height: 300,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => With_Shading(true)));
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Solar Energy Productivity with Shading',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ]
                      ),
                    ),

                    Container(
                       margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                     
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            child: Image.asset('images/panels.jpeg',
                              fit: BoxFit.contain,
                            //width: 400,
                             // height: 300,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => With_Shading(false)));
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Solar Energy Productivity',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ]
                      ),
                    ),

                ]
              ),
            )
          ]
        ),
      ),
    );
  }
}
