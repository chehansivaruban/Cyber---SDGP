
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

  DateTime _chosenDateTime = DateTime.now();

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

    //------------------------



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

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    //------------------------

    final CameraPosition _currentLocationCam = CameraPosition(
        target: LatLng(position.latitude,position.longitude),
        zoom: 19.151926040649414
    );


    final GoogleMapController controller = await _controller.future;
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
       'endTime': formattedEndTime
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

                    return SingleChildScrollView(
                      child:Column(
                        children: <Widget>[
                       
                          Container(
                            margin: EdgeInsets.only(top: kToolbarHeight),
                            height: constraints.maxWidth*0.96,
                            width: constraints.maxWidth*0.96,
                            //color: Colors.red,
                            child: Card(
                            
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WithShading(true)));
                                },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: constraints.maxWidth*0.9378,
                                        width: constraints.maxWidth*0.96,
                                        child: GoogleMap(
                                          mapType: MapType.hybrid,
                                          initialCameraPosition: _startCamPosition,
                                          onMapCreated: (GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                          onTap: checkLocationType(),
                                          markers: Set.from(solarpanelLatLanList),
                                        ),
                                      ),

                              
                                      Container(
                                        margin:EdgeInsets.only(left:width*0.65,top: width*0.78),
                                        width: 50.0,
                                        height: 50.0,
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
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0,right: 5.0),                  
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

                          Container(
                             margin: EdgeInsets.only(top: 20),
                            child: Text('Location point table',
                            style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),
                            ),
                          ),
                          //list of solar panel markers in  widgets
                          Container(
                           
                              width: width*0.9,
                              height: 200,
                               decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent,width: 3)
                      
                                ),
                              child: solarpanelLatLanList.length > 0
                                  ? ListView.separated(
                                      itemCount: solarpanelLatLanList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
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

                          //add date and time gap 
                          Container(
                            
                            child: Column(
                              children: <Widget>[
                                // getDatePicker(),
                                // SizedBox(height: 50,),
                                ElevatedButton(onPressed: (){
                                  _showDatePicker(context,constraints);
                                  }, child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('Date'),
                                  ),
                                ),
                               
                                ElevatedButton(onPressed: (){
                                  startTimeClicked = true;
                                  _showTimePicker(context,constraints,startTime);
                                  // formattedStartTime = timeFormatter.format(startTime);
                                  // print(formattedStartTime);  
                                  }, child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('Start Time'),
                                  ),
                                ),

                                ElevatedButton(onPressed: (){
                                   endTimeClicked = true;
                                  _showTimePicker(context,constraints,endTime);
                                  // formattedEndTime = timeFormatter.format(endTime);
                                  // print(formattedEndTime); 
                                  
                                  }, child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('End Time'),
                                  ),
                                  
                                ),
                                ElevatedButton(onPressed: () async {
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
                                },
                               child: Container(
                                    width: constraints.maxWidth*0.3,
                                    alignment: Alignment.center,
                                    
                                    child: Text('Calculate'),
                                  ),
                                ),

                                Container(
                                  width: width*0.9,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent,width: 3)
                                  ),
                                  child:  Column(
                                    children: <Widget>[
                                      //irradiance 
                                      SizedBox(height: 10),
                                      Text('Irradiance during time gap..',
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
                                      SizedBox(height: 10,),
                                      Text('Irradiance : ' + finalResult,
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ),
                                      ),
                                    ],
                                  ),
                                )


                                
                                
                                 
                              ],
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
      )
    ); 

  

    
  }             
   
  void _showDatePicker(ctx,BoxConstraints constraints) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: constraints.maxHeight*0.4 ,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: constraints.maxHeight*0.3,
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
                height: 50,
                child: CupertinoButton(
                  color: Colors.red,
                  child: Text('Select'),                
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
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: constraints.maxHeight*0.4 ,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: constraints.maxHeight*0.3,
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
                height: 50,
                child: CupertinoButton(
                  color: Colors.red,
                  child: Text('Select'),                
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
