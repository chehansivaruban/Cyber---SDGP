import 'package:flutter/material.dart';
import 'package:solarex/widget/google_maps_widget.dart';

class With_Shading extends StatefulWidget {
  @override
  _With_ShadingState createState() => _With_ShadingState();
}

class _With_ShadingState extends State<With_Shading> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
        child: Stack(

          children :<Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  width: 400,
                  height: 400,
                  child: Center(
                    child:GoogleMapWidget() ,
                  )
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 470.0),
                height: 50,

              child: Row(
                children: <Widget>[

                  Container(
                    margin: const EdgeInsets.only(left: 10.0,right: 5.0),
                    width: 190.0,

                    child:ElevatedButton(
                      onPressed: () { },
                      child:  Column(
                        children: <Widget>[
                          Image.asset('images/roof.png'),
                          Text('Add Solar Panel Location')
                          
                        ],
                        
                      )
                    ),
                  ),

                  Container(
                    width: 190.0,
                    child:ElevatedButton(
                      onPressed: () { },
                      child:  Column(
                        children: <Widget>[
                          Image.asset('images/tree.png'),
                          Text('Add Shading Objects')

                        ],

                      )
                    ),
                  )
                ]


              )
            )


          ]
          ),
        )
    );
  }
}
