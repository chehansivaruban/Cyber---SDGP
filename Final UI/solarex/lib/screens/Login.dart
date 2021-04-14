import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
                    return Column(
                      children: <Widget>[
                        // Container(
                        //   height: kToolbarHeight,
                        //   width: constraints.maxWidth,
                        //   color: Colors.amber.shade50,
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: kToolbarHeight),
                          height: constraints.maxHeight*0.5,
                          width: constraints.maxWidth,
                          color: Colors.red,
                        ),
                        Container(
                          height: constraints.maxHeight*0.1,
                          width: constraints.maxWidth,
                          color: Colors.blue,
                        ),
                        Container(
                          height: constraints.maxHeight*0.1,
                          width: constraints.maxWidth,
                          color: Colors.blue.shade100,
                        ),
                        Container(
                          height: constraints.maxHeight*0.1,
                          width: constraints.maxWidth,
                          color: Colors.blue.shade200,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                          height: constraints.maxHeight*0.1,
                          width: constraints.maxWidth,
                          color: Colors.green.shade200,
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