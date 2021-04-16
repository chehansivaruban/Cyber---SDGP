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
    Timer(Duration(seconds: 100),
          ()=>Navigator.pushReplacement(context,MaterialPageRoute(
            builder:(context) =>Start())
      )
    );
  }
  @override
  Widget build(BuildContext context) {
   return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 0, 70, 122), Color.fromARGB(255, 0, 224, 254)] //top bottom color
          )
      ),
      child:  Flexible(
            child:FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                child: LayoutBuilder(
                  builder: (context, constraints){
                    //final height = constraints.maxHeight - kToolbarHeight;
                    final width = constraints.maxWidth;
                    return  Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: <Widget>[
                          Container(
                          
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/Logo.png' ,
                            height: constraints.maxWidth*0.5,
                            width: constraints.maxWidth*0.45,
                            fit:BoxFit.fill
                          ) 
                        )
                        ]
                      )
                    );
                  }
                )
              )
            )
      )

      
    
    );
  }
}