

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:solarex/screens/With_shading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Flexible(
            child:FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                color: Colors.amber,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    final height = constraints.maxHeight - kToolbarHeight;
                    final width = constraints.minWidth;
                    return Column(
                      children: <Widget>[
                        // Container(
                        //   height: kToolbarHeight,
                        //   width: constraints.maxWidth,
                        //   color: Colors.amber.shade50,
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: kToolbarHeight),
                          height: height*0.4,
                          width: constraints.maxWidth*0.96,
                          //color: Colors.red,
                          child: Card(
                            
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => With_Shading(true)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                    child: Image.asset('images/shading.jpeg' ,
                                      
                                      height: height*0.3,
                                      fit:BoxFit.fill
                                    ),
                                  ),
                                  SizedBox(height: height*0.03),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(                                      
                                      text: 'Solar Energy Productivity with Shading',
                                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: height*0.0245),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          )                        
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height*0.03),
                          height: height*0.4,
                          width: constraints.maxWidth*0.96,
                          //color: Colors.red,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => With_Shading(false)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                    child: Image.asset('images/panels.jpeg' ,
                                      // width: 300,
                                      height: height*0.3,
                                      fit:BoxFit.fill

                                    ),
                                  ),
                                  SizedBox(height: height*0.03),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Solar Energy Productivity without shading',
                                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: height*0.0245),
                                      ),
                                  ),
                                ],
                              ),
                            )
                          ) 
                        ),
                      ],
                    );
                  },
                ),
              ) 
            )
          )
        ],
      ),
    );  
  }
}
