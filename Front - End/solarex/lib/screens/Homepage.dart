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

      body: SingleChildScrollView(
        child: Stack(
               
      children :<Widget>[
      Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              
              child: Column(
                children: <Widget>[

                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: Center(
                      child: IconButton(
                        icon: Image.asset('images/shading.jpeg'),
                        iconSize: 300,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => With_Shading()));
                        },
                        )
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Solar Energy Productivity with Shading',
                        style: TextStyle(color: Colors.black),
                        
                      ),
                    ),
                  )


                  ]
                ),
            ),

            /* with out shading*/ 
             Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              
              child: Column(
                children: <Widget>[

                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: Center(
                      child: IconButton(
                        icon: Image.asset('images/panels.jpeg'),
                        iconSize: 300,
                        onPressed: () {},
                        )
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Solar Energy Productivity',
                        style: TextStyle(color: Colors.black),
                        
                      ),
                    ),
                  )


                  ]
                ),
            )

          ]
          
        )
      ),







          ]
        ),
      ),
    );
  }
}
