

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
      
      appBar: AppBar(
       // title: Text(widget.title),
       // 
       // 
      backgroundColor: Color.fromRGBO(0, 148, 255, 1) ,
      elevation: 0.0,
      toolbarHeight: 40,
      ),
      
      body: Material(
        type: MaterialType.transparency,
        child:
        Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 0, 148, 255), Color.fromARGB(255, 0, 255, 163)] //top bottom color
          )
      ),
      child:
      Column(
        children: <Widget>[
          Flexible(
            child:FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                //color: Colors.amber,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    final height = constraints.maxHeight - kToolbarHeight;
                    // final width = constraints.minWidth;
                    return SingleChildScrollView(
                      child:Column(
                      

                      
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          //color: Colors.red,
                          height: constraints.maxHeight*0.2,
                          child: Container(
                            width: constraints.maxWidth*0.9,
                            child: Column(
                            children: <Widget>[
                              Text('Find the power output of your solar energy system',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                              
                              ),
                              SizedBox(height: 10,),
                              // Text('The power output of a particular given time can be calculated according to the roof area of the solar energy system on a particular day.',
                              // style: TextStyle(fontSize: 15, color: Colors.white),
                              
                              // )
                            ],
                          ),
                          )
                        ),




                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            topRight: Radius.circular(35.0),
                            
                          ),
                          child: Container( // white color container
                            color: Colors.white,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            

                            child: SingleChildScrollView(
                            
                            child:Column(
                              


                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text('Get Started',
                                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                  ),
                                ),
                      
                        Container(
                         // margin: EdgeInsets.only(top: kToolbarHeight + 50),
                          margin: EdgeInsets.only(top: 20),
                          height: height*0.3,
                          width: constraints.maxWidth*0.83,
                          child: Card(
                          
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WithShading(true)));
                              },
                              child: Stack(
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                        child: Image.asset('images/Withshading.jpg' ,
                                          height: height*0.285,
                                          fit:BoxFit.fill
                                        ),
                                      ),
                                    ]
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                        child: Container(
                                          height: height*0.285,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ]
                                  ),
                                  
                                 // SizedBox(height: height*0.03),
                                 Container(
                                   alignment: Alignment.center,
                                   //color: Colors.red,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Text("Shaded",
                                       style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: height*0.0245),
                                       textAlign: TextAlign.center,
                                       ),
                                       Text("Solar Panels",
                                       style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: height*0.0245),
                                       textAlign: TextAlign.center,
                                       ),
                                     ],
                               
                                  ),
                                 )
                                  
                                ],
                              ),
                            )
                          ) 
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: height*0.3,
                          width: constraints.maxWidth*0.83,
                          child: Card(
                          
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WithShading(false)));
                              },
                              child: Stack(
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      child: Image.asset('images/Withoutshading.jpg' ,
                                        height: height*0.285,
                                        fit:BoxFit.fill
                                      ),
                                    ),

                                    ]
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                        child: Container(
                                          height: height*0.285,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ]
                                  ),
                                  
                                 
                                 Container(
                                   alignment: Alignment.center,
                                   //color: Colors.red,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Text("Non - Shaded",
                                       style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: height*0.0245),
                                       textAlign: TextAlign.center,
                                       ),
                                       Text("Solar Panels",
                                       style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: height*0.0245),
                                       textAlign: TextAlign.center,
                                       ),
                                     ],
                               
                                  ),
                                 )
                                  
                                ],
                              ),
                            )
                          ) 
                        ),



                              ],
                            ),
                            )
                          )
                          
                        ),

                      ]
                      )
                      
                    );
                  },
                ),
              ) 
            )
          )
        ],
      ),
      )
      ),
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Opacity(
            //   opacity: 1,
            //   child: Container(
            //     height: kToolbarHeight,
            //   )
            // ),
             DrawerHeader(
         
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );  
  }
}
