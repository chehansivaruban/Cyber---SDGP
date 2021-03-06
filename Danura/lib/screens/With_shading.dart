
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;



import 'package:intl/intl.dart';


class WithShading extends StatefulWidget {
  final bool withShading;
  WithShading(this.withShading);
  
  @override
  _WithShadingState createState() => _WithShadingState();

}

class _WithShadingState extends State<WithShading> {

  bool solarPannelViewOn = true;
  bool mapViewisOn = false;
  bool calculatiOnReady = false;

  DateTime _chosenDateTime = DateTime.now();
  final capacityTxtField = TextEditingController();

  DateTime date = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  static final DateFormat timeFormatter = DateFormat.Hms();
  String formattedEndTime = "00:00:00";
  String formattedStartTime = "00:00:00";
  String formattedDate = "0000-00-00";
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  bool startTimeClicked = false;
  bool endTimeClicked = false;

  String finalResult = "";


  List<Marker> solarpanelLatLanList = [];
  List<Marker> objectList = [];
  bool solarPanelButton = true ;


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _startCamPosition = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    zoom: 14.4746,
  );

  onTapMapTrue(LatLng onTapLatLang){
    print(onTapLatLang);
    setState(() {
     // with_shading_solarpanel_list = [];
     if(solarpanelLatLanList.length < 4){
       solarpanelLatLanList.add(
        Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          onTap: removeMarkerSolarPannel(onTapLatLang.toString()),
          onDragEnd: (dragEndPoint){
            print(dragEndPoint);
          }
        )
      );

     }
      
      
    });
  }



  removeMarkerSolarPannel(String latlang){
    for(Marker marker in solarpanelLatLanList){
      print('working1');
      if(marker.markerId.toString() == latlang){
        solarpanelLatLanList.remove(marker);
        print('Removed location');
      }
    }
  }

  onTapMapFalse(LatLng onTapLatLang){
    print(onTapLatLang);
    setState(() {
      // with_shading_solarpanel_list = [];
      solarpanelLatLanList.add(
          Marker(
              markerId: MarkerId(onTapLatLang.toString()),
              position: onTapLatLang,
              draggable: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              onDragEnd: (dragEndPoint){
                print(dragEndPoint);
              }
          )
      );

    });
  }

  //solar pannel location in with shading button

  sloarPanelBool(bool bool){
    solarPanelButton = bool;
  }

   checkLocationType(){
    if(solarPanelButton == true){
      return onTapMapTrue;
    }
    else if(solarPanelButton == false){
      return onTapMapFalse;
    }
  }

  Future<void> _goToCurrentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
            'Location permissions are denied');
      }
    }

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
        print("test");
    print(position);

    CameraPosition _currentLocationCam = CameraPosition(
        target: LatLng(position.latitude,position.longitude),
        zoom: 19.151926040649414
    );


    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentLocationCam));
  }

//////////////////////////////////////////////////////////////API
 Future<http.Response> calculate() {
  return http.post(
    Uri.https('cybersolarex.herokuapp.com','//api'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
       "date": formattedDate,
       "startTime": formattedStartTime,
       'endTime': formattedEndTime,
       'capacity': capacityTxtField.text.toString()
    }),
  );
}

//////////////////////////////////////////////////////////////



  @override
  Widget build(BuildContext context) {

    //bool withOrWithoutShadingBtn = widget.withShading;
    //final TextEditingController _textEditingController = TextEditingController();
    

    return Scaffold(
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
      child:Column(
        children: <Widget>[
          Flexible(
            child:FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                //color: Colors.amber,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    //final height = constraints.maxHeight - kToolbarHeight;
                    bool resultbool = false;
                    final width = constraints.maxWidth;

                    return Column(
                      
                      children: <Widget>[
                        Visibility(
                          visible: mapViewisOn,


                          child:Container(
                            alignment: Alignment.center,
                            child:  Column(
                            children: <Widget>[
                              Container(
                            margin: EdgeInsets.only(top: kToolbarHeight),
                            height: constraints.maxWidth*0.97,
                            width: constraints.maxWidth*0.96,
                            
                            //color: Colors.red,
                            child: Card(
                            
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              color: Colors.black,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WithShading(true)));
                                },
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        margin:EdgeInsets.only(top: constraints.maxHeight*0.005) ,
                                        height: constraints.maxWidth*0.93,
                                        width: constraints.maxWidth*0.92,
                                        child: Center(
                                          child: GoogleMap(
                                          mapType: MapType.hybrid,
                                          initialCameraPosition: _startCamPosition,
                                          onMapCreated: (GoogleMapController controller) {
                                             if (!_controller.isCompleted) {
                                                _controller.complete(controller);
                                             }
                                             else{
                                              
                                             }
                                            
                                          },
                                          onTap: checkLocationType(),
                                          markers: Set.from(solarpanelLatLanList),
                                        ),
                                        )
                                      ),

                              
                                      Container(
                                        margin:EdgeInsets.only(left:width*0.65,top: width*0.78),
                                        width: 45.0,
                                        height: 45.0,
                                        child: FloatingActionButton(
                                          onPressed: _goToCurrentLocation,
                                          child: Image.asset('images/gps.png'),
                                        ),
                                      )
                                    ]
                                  ),
                                ],
                              ),
                              )
                            )
                            ),
                              
                            
                          ),
                            

                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: constraints.maxWidth*0.02,right: 5.0),                  
                                  child:ElevatedButton(
                                    onPressed: () {
                                      solarPanelButton = true;
                                    },//this
                                  child: Row(                      
                                    children: <Widget>[
                                      Container(
                                        child: !widget.withShading ? Container(
                                          width: width*0.861,                
                                          child:  Column(
                                            children: <Widget>[
                                              Image.asset('images/roof.png'),
                                              Text('Add Solar Panel Location', 
                                              style: TextStyle( fontSize: width*0.035)
                                              ,),
                                              SizedBox(height: 6)
                                            ],
                                          )
                                        ):Container(
                                            width: width*0.44,
                                            child:  Column(
                                              children: <Widget>[
                                                Image.asset('images/roof.png'),
                                                Text('Add Solar Panel Location', 
                                                style: TextStyle( fontSize: width*0.035)
                                                ,),
                                                SizedBox(height: 6)
                                              ],
                                            )
                                          ),
                                      ),
                                      
                                    ],
                                  )
                                ),
                                ),
                                Container(                  
                                  child: !widget.withShading ? null : ElevatedButton(
                                    onPressed: () {
                                      solarPanelButton = false;
                                    },
                                    child:  Container(
                                      width: width*0.334,
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset('images/tree.png'),
                                          AutoSizeText(
                                            'Add Shading Objects', 
                                                style: TextStyle( fontSize: width*0.035),
                                                maxLines: 1,
                                          ),
                                          
                                          SizedBox(height: 6)
                                        ],
                                      )
                                    )
                                  ),
                                )
                              ],
                            )
                          ),

                          


                            ],
                          ),
                          )
                          
                          
                          
                        ),
                       
                        Flexible(
                          child:FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: Container(
                //color: Colors.amber,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    //final height = constraints.maxHeight - kToolbarHeight;
                    bool resultbool = false;
                    final width = constraints.maxWidth;
                    return SingleChildScrollView(
                      child:Column(
                        children: <Widget>[ 
                          Visibility(
                          visible: !mapViewisOn,

                          child:Container(
                            margin: EdgeInsets.only(top: kToolbarHeight),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {                                 
                                  mapViewisOn = true;               
                                });
                                
                              },
                             child: Text("Select Solar panel Location")),
                          ),
                          ),
                       
                          
                          

                          Container(
                             margin: EdgeInsets.only(top: 20),
                            child: Text('Location point table',
                            style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),
                            ),
                          ),
                          //list of solar panel markers in  widgets
                          Container(
                            width: constraints.maxWidth*0.9,
                            
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                                             solarPannelViewOn = true;          
                                                                    });
                                                                    print(solarPannelViewOn);
                                 
                                }, child: Text("Solar Pannel")),
                                SizedBox(width: constraints.maxWidth*0.01,),
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                                                    solarPannelViewOn = false;   
                                                                    });
                                                                    print(solarPannelViewOn);
                                 
                                }, child: Text("Shading Objects")),
                              ],
                            ),
                          ),

                          // solar pannel location in tabel
                          Visibility(
                            visible: solarPannelViewOn,
                            child:
                          
                          Container(
                           
                              width: width*0.9,
                              height: 200,
                              
                               decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent,width: 3)
                      
                                ),
                              child: Visibility(
                                visible: !solarPannelViewOn,
                                child:  Container(
                                  ///color: Colors.red,
                                child: solarpanelLatLanList.length > 0
                                  ? ListView.separated(
                                      itemCount: solarpanelLatLanList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Row(children: [
                                            Text("Marker " + index.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                            Spacer(),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    solarpanelLatLanList.removeAt(index);
                                                    print("Removed Marker " + index.toString());
                                                  });
                                                }),
                                          ]),
                                          color: Colors.white,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                    )
                                  : null),
                              ), 
                          ),
                          ),


                          // object list view
                          Visibility(
                            visible: !solarPannelViewOn,
                            
                            child: 
                          Container(
                           
                              width: width*0.9,
                              height: 200,
                               decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red,width: 3)
                      
                                ),
                              child: Visibility(
                                visible: solarPannelViewOn,
                                child:  Container(
                                //  color: Colors.blue,
                                child: objectList.length > 0
                                  ? ListView.separated(
                                      itemCount: objectList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Row(children: [
                                            Text("Marker " + index.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                            Spacer(),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    objectList.removeAt(index);
                                                    print("Removed Marker " + index.toString());
                                                  });
                                                }),
                                          ]),
                                          color: Colors.white,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                    )
                                  : null),
                              ), 
                          ),
                          ),

                          //add date and time gap 
                          Container(
                            
                            child: Column(
                              children: <Widget>[
                                // getDatePicker(),
                                // SizedBox(height: 50,),
                                ElevatedButton(onPressed: (){
                                  _showDatePicker(context,constraints);
                                  setState(() {                                 
                                    mapViewisOn = false;               
                                  });
                                  }, child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('Date'),
                                  ),
                                ),

                                Container(
                                  width: width*0.9,
                                  alignment: Alignment.center,

                                  child: Row(
                                    children: <Widget>[
                                      ElevatedButton(onPressed: (){
                                  startTimeClicked = true;
                                  _showTimePicker(context,constraints,startTime);
                                  setState(() {                                 
                                    mapViewisOn = false;               
                                  });  
                                  }, child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('Start Time'),
                                  ),
                                ),
                                SizedBox(width: constraints.maxWidth*0.12,),

                                ElevatedButton(onPressed: (){
                                 // margin: EdgeInsets.only(left: constraints.maxWidth*0.28);
                                   endTimeClicked = true;
                                  _showTimePicker(context,constraints,endTime);
                                  setState(() {                                 
                                    mapViewisOn = false;               
                                  });
                                  
                                  }, child: Container(
                                    width: constraints.maxWidth*0.3,
                                    
                                    alignment: Alignment.center,
                                    
                                    child: Text('End Time'),
                                  ),
                                  
                                ),

                                    ],
                                  ),


                                ),

                                Container(
                                  width: width*0.9,
                                  alignment: Alignment.center,

                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      Text('Total Solar pannel Capacity',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04),
                                    ),
                                    TextField(
                  
                                      controller: capacityTxtField,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Solar Panel Capacity in Kilo watt'
                                      ),
                                    )


                                    ]
                                  )
                                ),





                              //   ElevatedButton(onPressed: (){
                              //     _showCapacity(context,constraints);
                               

                              //  ///////////////////************************************* */
                              //     }, child: Container(
                              //       width: constraints.maxWidth*0.9,
                              //       height: 50,
                              //       alignment: Alignment.center,
                                    
                              //       child: Text('Total Solar pannel Capacity',
                              //       style: TextStyle(fontSize: constraints.maxWidth*0.035),
                              //       ),
                              //     ),
                                  
                              //   ),
                               
                                
                                ElevatedButton(onPressed: () async {
                                  setState(() {                                 
                                    mapViewisOn = false;    
                                      
                                  });
                                  
                                  resultbool = true;
                                  // _showTimePicker(context,constraints,endTime);
                                  http.Response response = await calculate();
                                  if (response.statusCode == 200) {
                                    setState(() {
                                        finalResult = response.body.toString();
                                    });
                                    
                                    print("SUCCESS: " + finalResult);
                                  } else {
                                    
                                     // finalResult = response.statusCode.toString();  
                                    
                                    
                                    print("REQUEST FAILED" + "STARTUS_CODE: " + finalResult);
                                  }
                                  setState(() {
                                     calculatiOnReady = true;                                             
                                  });
                                 
                                },
                               child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('Calculate'),
                                  ),
                                ),
                                

                                Visibility(
                                  visible: calculatiOnReady,
                                  child: 
                                Container(
                                  width: width*0.9,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent,width: 3)
                                  ),
                                  child:  Column(
                                    children: <Widget>[
                                      //irradiance 
                                      SizedBox(height: 10),
                                      Text('Productivity during time gap..',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ),
                                      ),
                                      SizedBox(height: 20),
                                      Text('Date : ' + formattedDate,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                                      ),
                                      Text('Start Time : ' + formattedStartTime,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                                      ),
                                      Text('End time : ' + formattedEndTime,
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                                      ),
                                      Text('Solar Panel Capacity : ' + capacityTxtField.text.toString() + " kWh",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text('Productivity (kWh): ' + finalResult ,
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ),
                            
                                      ),
                                      
                                    ],
                                  ),
                                ),
                                )


                                
                                
                                 
                              ],
                            )
                          ),
                          
                          

                        ]
                      )
                    );
                }
                ),
                )
            ),
            )
                        

                      ],
                    );
                    
                     
                  },
                ),
              ) 
            )
          )
        ],
      ),
        )
      )
    ); 

  

    
  }             
   
  void _showDatePicker(ctx,BoxConstraints constraints) {
    double showDatePickerHieght =  constraints.maxHeight;
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: showDatePickerHieght,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: showDatePickerHieght*0.1 ),
                height: showDatePickerHieght*0.6,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                     mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),

              // Close the modal
              Container(
                height: (constraints.maxHeight < 150) ? constraints.maxHeight*0.299: 50,
                child: CupertinoButton(
                  color: Colors.red,
                  child: Text('Select',
                    style: TextStyle(fontSize: ((constraints.maxHeight < 150) ? constraints.minHeight*0.1:14)),
                  ),                
                    onPressed: () {
                      setState(() {
                        formattedDate = formatter.format(_chosenDateTime);
                      });
                         
                         print(formattedDate);
                        Navigator.of(ctx).pop();
                    } 
                ),
              )
              
            ],
          ),
        ));

        
  }

   void _showTimePicker(ctx,BoxConstraints constraints,DateTime time) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    double showTimePickerHeight = constraints.maxHeight;
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: showTimePickerHeight ,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: showTimePickerHeight*0.7,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                     mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (val) {
                      setState(() {
                        time = val;
                      });
                    }),
              ),

              // Close the modal
              Container(
                height:  (constraints.maxHeight < 150) ? constraints.maxHeight*0.299: 50,
                child: CupertinoButton(
                  
                  color: Colors.red,
                  child: Text('Select',
                  style: TextStyle(fontSize: ((constraints.maxHeight < 150) ? constraints.minHeight*0.1:14)),
                  ),                
                    onPressed: () {
                                  
                      if( startTimeClicked == true){
                        setState(() {
                          formattedStartTime = timeFormatter.format(time);
                        });
                          
                          print('start time');
                          print(formattedStartTime);  
                          startTimeClicked = false;

                      }else if( endTimeClicked == true){
                        setState(() {
                          formattedEndTime = timeFormatter.format(time);                          
                        });
                        
                         print('end time');
                        print(formattedEndTime); 
                        endTimeClicked = false;
                      }
                      
                      
                        // formatted = timeFormatter.format(time);
                        // print(formatted);
                        Navigator.of(ctx).pop();
                    } 
                ),
              ),
              
              
            ],
          ),
        ));     
  }

  
  
  
}
