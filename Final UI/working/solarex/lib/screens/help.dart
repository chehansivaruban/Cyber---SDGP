import 'package:flutter/material.dart';
class HelpView extends StatefulWidget {

  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line
    
     
     //resizeToAvoidBottomInset : false,
     // appBar: AppBar(),
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
                    child: LayoutBuilder(
                      builder: (context, constraints){
                      bool resultbool = false;
                      final width = constraints.maxWidth;

                      return  SingleChildScrollView(
                        child: Container(
                          width: constraints.maxWidth*0.9,
                          child: 

                          Column(
                           
                            children: <Widget>[
                              (SizedBox(height: kToolbarHeight,)),
                              Container(
                                height:constraints.maxHeight*0.9,
                                width:constraints.maxWidth*0.9,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight:const Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                    
                                    image: AssetImage(
                                      'images/h1.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              (SizedBox(height: 20,)), 
                              Container(
                                height:constraints.maxHeight*0.9,
                                width:constraints.maxWidth*0.9,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight:const Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'images/h2.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              (SizedBox(height: 20,)), 
                              Container(
                                height:constraints.maxHeight*0.9,
                                width:constraints.maxWidth*0.9,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight:const Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'images/h3.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),      
                              (SizedBox(height: 20,)), 
                              Container(
                                height:constraints.maxHeight*0.9,
                                width:constraints.maxWidth*0.9,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight:const Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'images/h4.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),      
                              (SizedBox(height: 20,)), 
                              Container(
                                height:constraints.maxHeight*0.9,
                                width:constraints.maxWidth*0.9,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight:const Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'images/h5.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),              












                            ]
                          )
                        )
                      );
                    }
                  )
                )
                )
              )
              ]
            )
          )
          )
    );
  }
}