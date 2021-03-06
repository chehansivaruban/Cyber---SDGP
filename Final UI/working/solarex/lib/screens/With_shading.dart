
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:solarex/widget/Marker.dart';
import 'package:solarex/widget/withOutMarker.dart';




import 'package:intl/intl.dart';


class WithShading extends StatefulWidget {
  final bool withShading;
  WithShading(this.withShading);
  
  @override
  _WithShadingState createState() => _WithShadingState();

}

class _WithShadingState extends State<WithShading> {


  int selectedRadioTile = 0;

  bool solarPannelViewOn = true;
  bool mapViewisOn = false;
  bool calculatiOnReady = false;
  bool withCapacity = true;

  DateTime _chosenDateTime = DateTime.now();
  final capacityTxtField = TextEditingController();
  final hPointTxtField = TextEditingController();
  final lPointTxtField = TextEditingController();
  final distanceTxtField = TextEditingController();
  final oPanelCapacityTxtField = TextEditingController();
  final oPAreaTxtField = TextEditingController();
  
  final pannelAreaTxtField = TextEditingController();
  //final pannelAreaTxtField = TextEditingController();

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
  List<List> solarpanelLatLangDouble =[];

  List<List> objectlatlangDouble =[];
  List<Marker> objectList = [];
  List<List> pointHeightWidth = [];

  List<Marker> allMarkers = [];
 
  List<PanelMarker> opaneltMarkeListWithDetails = [];
  List<ObjectMarker> objectMarkeListWithDetails = [];

  List<TextField> textFieldHW =[];
  bool solarPanelButton = true ;
  late bool withOrWithoutShadeHome;

  

  TextField textFieldHeight = new TextField();



  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _startCamPosition = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    zoom: 14.4746,
  );

  onTapMapTrue(LatLng onTapLatLang){
    print(onTapLatLang);
    setState(() {
     
     if(solarpanelLatLanList.length < 4){

      //PanelMarker marker = new PanelMarker(); 
      Marker newMarker = new Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          //     onDragEnd: (dragEndPoint){
          onDragEnd: (dragEndPoint){
            print(dragEndPoint);
          }


          );
      
      
      List latlangList = [];
      latlangList.add(onTapLatLang.latitude);
      latlangList.add(onTapLatLang.longitude);
      
      
      //marker.marker(onTapLatLang);
       
       solarpanelLatLanList.add(newMarker);


       solarpanelLatLangDouble.add(latlangList);
      // opaneltMarkeListWithDetails.add(marker);

     }
     
     

    allMarkers.clear();
      for (Marker marker in solarpanelLatLanList) {
          allMarkers.add(marker);
      }
      for (Marker marker in objectList) {
          allMarkers.add(marker);
      }
    });
  }



  // removeMarkerSolarPannel(String latlang){
  //   for(Marker marker in solarpanelLatLanList){
  //     print('working1');
  //     if(marker.markerId.toString() == latlang){
  //       solarpanelLatLanList.remove(marker);
  //       print('Removed location');
  //     }
  //   }
  // } 

  onTapMapFalse(LatLng onTapLatLang){
    print(onTapLatLang);
    setState(() {
      //ObjectMarker marker = new ObjectMarker(); 
      //Marker newMarker = marker.marker(onTapLatLang);
      // with_shading_solarpanel_list = [];
      objectList.add(
        //newMarker
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

      //objectMarkeListWithDetails.add(marker);

      List latLangList = [];
      latLangList.add(onTapLatLang.latitude);
      latLangList.add(onTapLatLang.longitude);


      objectlatlangDouble.add(latLangList);

      allMarkers.clear();

      for (Marker marker in solarpanelLatLanList) {
          allMarkers.add(marker);
      }
      
      for (Marker marker in objectList) {
          allMarkers.add(marker);
      }
      

    });
  }

  //solar pannel location in with shading button

  sloarPanelBool(bool bool){
    setState(() {
          solarPanelButton = bool;
        });
    
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
  // bool checkDataType(TextEditingController controller){
   
  //   if(controller.value is double){}
  // }

//////////////////////////////////////////////////////////////API

 Future<http.Response> calculateWithShading() {
   
    
  
  //  Map<String, dynamic> shadingMarker = {"shadingMarkerHW": objectMarkeListWithDetails};
  // var shadingMarkerJson = jsonEncode(shadingMarker);
  // print(shadingMarkerJson);

  // Map<String, dynamic> withOutShadingMarker = {"solarPanel": opaneltMarkeListWithDetails};
  // var withOutShadingMarkerJson = jsonEncode(withOutShadingMarker);
  // print("with Shading");
  // print(withOutShadingMarkerJson);
  print(jsonEncode(<String, dynamic>{
      
       'date': formattedDate,
       'startTime': formattedStartTime,
       'endTime': formattedEndTime,
       'capacity': capacityTxtField.text,
       'oCapacity': oPanelCapacityTxtField.text,
       'oArea': oPAreaTxtField.text,
      //  'shadingMarkerHW' : shadingMarkerJson,
       'solarPanelMarker' : solarpanelLatLangDouble,
       'shadingMarkerHW': objectlatlangDouble,
       'objectHw': pointHeightWidth,
       'hLow' : hPointTxtField.text,
       'hHigh' : lPointTxtField.text,
       'd' : distanceTxtField.text,
    }),
    );

   //print(shadingMarker);
  return http.post(
    Uri.https('solarex-final.herokuapp.com','/shade'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      
       'date': formattedDate,
       'startTime': formattedStartTime,
       'endTime': formattedEndTime,
       'capacity': capacityTxtField.text,
       'oCapacity': oPanelCapacityTxtField.text,
       'oArea': oPAreaTxtField.text,
      //  'shadingMarkerHW' : shadingMarkerJson,
       'solarPanelMarker' : solarpanelLatLangDouble,
       'shadingMarkerHW': objectlatlangDouble,
       'objectHw': pointHeightWidth,
       'hLow' : hPointTxtField.text,
       'hHigh' : lPointTxtField.text,
       'd' : distanceTxtField.text,
    }),
  );
}

//solarpanelLatLanList
//
//


Future<http.Response> calculateWithOutShading() {
   
    
// Map<dynamic,dynamic> withOutShadingMarker = {opaneltMarkeListWithDetails} as Map;
 // var withOutShadingMarkerJson = jsonEncode(solarpanelLatLanList);
 // String data = withOutShadingMarkerJson.replaceAll("\"", "");
  //print(data);
  
 
  
  print('this');
  print(jsonEncode(<String, dynamic>{
      
        'date': formattedDate,
       'startTime': formattedStartTime,
       'endTime': formattedEndTime,
       'capacity': capacityTxtField.text,
       'oneCapacity' :  oPanelCapacityTxtField.text,
       'onepanelArea' : oPAreaTxtField.text,
       'solarPanel' :solarpanelLatLangDouble//jsonEncode(opaneltMarkeListWithDetails).replaceAll("\"", "")
  //'l1': solarpanelLatLanList.elementAt(0).
    }),);

   //print(shadingMarker);
  return http.post(
    Uri.https('solarex-final.herokuapp.com','/wshade'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      
       'date': formattedDate,
       'startTime': formattedStartTime,
       'endTime': formattedEndTime,
       'capacity': capacityTxtField.text,
       'oneCapacity' :  oPanelCapacityTxtField.text,
       'onepanelArea' : oPAreaTxtField.text,
       'solarPanel' : solarpanelLatLangDouble//jsonEncode(opaneltMarkeListWithDetails).replaceAll("\"", "")
       //'l1': solarpanelLatLanList
    }),
  );
}
Future<http.Response> calculate(){
  print(withOrWithoutShadeHome);
  return //calculateWithOutShading();

      !withOrWithoutShadeHome? calculateWithOutShading():calculateWithShading();

}


//////////////////////////////////////////////////////////////
@override
void initState() {
  super.initState();



  selectedRadioTile = 0;
}

void withCapacityBool(){
  withCapacity = true;
  oPAreaTxtField.clear();
  oPanelCapacityTxtField.clear();
  

}

void withOutCapacityBool(){
   withCapacity = false;
   capacityTxtField.clear();

}
 
setSelectedRadioTile(int val) {
  setState(() {
    selectedRadioTile = val;
    val ==1 ? withCapacityBool():withOutCapacityBool() ;
  });
}



  @override
  Widget build(BuildContext context) {
      _controller = Completer();

    withOrWithoutShadeHome = widget.withShading; // from home page true or false
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
              colors:  [Color.fromARGB(255, 0, 148, 255), Color.fromARGB(255, 0, 255, 163)] //top bottom color
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

                    return 
                    
                    Column(
                      
                      children: <Widget>[

                        Visibility(
                          visible: mapViewisOn,
                          child:
                        Container(
                          height: constraints.maxHeight*0.6,
                          child:

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
                     

                        


                          child:Container(
                           
                            height: constraints.maxWidth*1,
                            
                            alignment: Alignment.center,
                            child:  Column(
                            children: <Widget>[
                              Container(
                            margin: EdgeInsets.only(top: kToolbarHeight),
                            height: constraints.maxWidth*0.55,
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
                                        height: constraints.maxWidth*0.5,
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
                                          markers: Set.from(allMarkers),
                                        ),
                                        )
                                      ),

                              
                                      Container(
                                        margin:EdgeInsets.only(left:width*0.65,top: width*0.38),
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
                                      setState(() {
                                        solarPanelButton = true;                     
                                      });
                                      
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
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                ),
                                ),
                                Container(                  
                                  child: !widget.withShading ? null : ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        solarPanelButton = false;        
                                      });
                                     
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
                                    ),
                                    style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                  ),
                                )
                              ],
                            )
                          ),
                          // mapViewisOn = false;    
                           ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        mapViewisOn = false;         
                                      });
                                     
                                    },
                                    child:  Container(
                                      alignment: Alignment.center,
                                      width: width*0.8,
                                      child: Text('Done'),
                                    ),
                                    style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                  ),  

                          


                            ],
                          ),
                          )
                          
                          
                          
                        );
                  }
                    )
                 
                ),
              ),
              ),
              ),
                        ),

//************************************************************* */
                       
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
                            margin: EdgeInsets.only(top: kToolbarHeight + 10),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {                                 
                                  mapViewisOn = true;               
                                });
                                
                              },
                             child: Text("Select Solar panel Location"),
                             style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                  ),
                          ),
                          ),
                       
                          Visibility(
                          visible: mapViewisOn,
                          child: Column(
                            children: <Widget>[

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
                              children: <Widget>[
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    solarPannelViewOn = true;          
                                  });
                                  //print(solarPannelViewOn);
                                 
                                }, child: Text("Solar Pannel"),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                ),
                                SizedBox(width: constraints.maxWidth*0.01,),
                                Visibility(
                                  visible: withOrWithoutShadeHome,
                                  child: 
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                  solarPannelViewOn = false;   
                                  });
                                 // print(solarPannelViewOn);
                                 
                                  }, child: Text("Shading Objects"),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                  ),
                                )
                              ],
                            ),
                          ),

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
                                visible: solarPannelViewOn,
                                child:  Container(
                                  ///color: Colors.red,
                                child: solarpanelLatLanList.length > 0
                                  ? ListView.separated(
                                      itemCount: solarpanelLatLanList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Row(children: [
                                            Text("Point" + (index + 1).toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                            Spacer(),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    solarpanelLatLanList.removeAt(index);// removing marker
//opaneltMarkeListWithDetails.removeAt(index);
                                                   // print(solarpanelLatLangDouble);
                                                    solarpanelLatLangDouble.removeAt(index);//removing panel lang
                                                  
                                                   
                                                    print("Removed Marker " + index.toString());
                                                    allMarkers.clear();

                                                    for (Marker marker in solarpanelLatLanList) {
                                                      allMarkers.add(marker);
                                                    }
      
                                                    for (Marker marker in objectList) {
                                                      allMarkers.add(marker);
                                                    }
                                                  });
                                                }),
                                          ]),
                                          // color: Colors.white,
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
                                visible: !solarPannelViewOn,
                                child:  Container(
                                  
                                child: objectList.length > 0
                                  ? ListView.separated(
                                      itemCount: objectList.length,
                                      itemBuilder: (context, index) {
                                        final hightTxtField = TextEditingController();
                                        final widthTxtField = TextEditingController();

                                        return Container(
                                          color: Colors.blue,
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Row(children: [
                                            Text("Obj. " + (index + 1).toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                            Row(children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: width*0.9*0.01),
                                                width:  width*0.9*0.25,
                                                child:
                                                
                                                  TextField(
                                                    
                                                    controller: hightTxtField,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                                      hintText: 
                                                      
                                                      pointHeightWidth.isEmpty  ?'hight': pointHeightWidth.asMap()[index] != null  ?  pointHeightWidth.elementAt(index).elementAt(0).toString(): "hight"
                                                      
                                                      // suffixIconConstraints: BoxConstraints( maxWidth: width*0.9*0.02)
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.digitsOnly
                                                    ], // Only numbers can be entered
                                                    

                                                    
                                                  ),
                                              ),
                                              
                                              Container(
                                                margin: EdgeInsets.only(left: width*0.9*0.01),
                                                width:  width*0.9*0.25,
                                                child:
                                                  TextField(
                                                    controller: widthTxtField,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                                      hintText: pointHeightWidth.isEmpty   ?'width': pointHeightWidth.asMap()[index] != null  ?  pointHeightWidth.elementAt(index).elementAt(1).toString(): "width"
                                                      // suffixIconConstraints: BoxConstraints( maxWidth: width*0.9*0.02)
                                                    ),
                                                     keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                  ),
                                              ),
                                              Container(
                                                width:constraints.maxWidth*0.15,
                                                alignment: Alignment.center,
                                                
                                                child:ElevatedButton(onPressed: (){
                                                  setState(() {

                                                    List heightWidth = [];

                                                    //pointHeightWidth
                                                    
                                                    double height = double.parse(hightTxtField.text);
                                                    double width = double.parse(widthTxtField.text);
                                                    print('h');
                                                    print(height);
                                                    print('w');
                                                    print(width);
                                                    heightWidth.add(height);
                                                    heightWidth.add(width);

                                                    pointHeightWidth.add(heightWidth);



                                                   // objectMarkeListWithDetails.elementAt(index).height = height; 
                                                    //objectMarkeListWithDetails.elementAt(index).width = width;  
                                                     print('done');                                          
                                                  });
                                                }, 
                                              child: Icon(Icons.beenhere_sharp,color: Colors.grey,),
                                              style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                              
                                              
                                              ),
                                              
                                              )


                                            ] ),
                                            

                                            Container(
                                              width: constraints.maxWidth*0.0999,
                                              color: Colors.blue,
                                              child:
                                            
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                   // pointHeightWidth.removeAt(index).removeAt(0);
                                                   // pointHeightWidth.removeAt(index).removeAt(1);
                                                    objectList.removeAt(index);
                                                   // objectMarkeListWithDetails.removeAt(index);
                                                    objectlatlangDouble.removeAt(index);//removing lat lang
                                                    pointHeightWidth.removeAt(index);//removing the hight
                                                    
                                                   
                                                   
                                                    print("Removed Marker " + index.toString());
                                                    allMarkers.clear();

                                                    for (Marker marker in solarpanelLatLanList) {
                                                      allMarkers.add(marker);
                                                    }
      
                                                    for (Marker marker in objectList) {
                                                      allMarkers.add(marker);
                                                    }
                                                  });
                                                }),
                                            )
                                          ]),
                                          
                                          
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




                            ],


                          ),
                          ),

                          

                          

                          // solar pannel location in tabel
                          


                          // object list view
                          

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
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
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
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
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
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
                                  
                                ),

                                    ],
                                  ),


                                ),
                                Center(
                                  
                                  child: Container(
                                    alignment: Alignment.center,
            
                                 child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                

                                      RadioListTile(
                                          value: 1,
                                          groupValue: selectedRadioTile,
                                          title: Text("Calculate with Capacity"),
                                          onChanged: (val) {
                                           
                                            setSelectedRadioTile(int.parse(val.toString()));
                                          },
                                          activeColor: selectedRadioTile == 1? Colors.red:Colors.black,
 
                                          selected: true,
                                      ),
                         

                                      RadioListTile(
                                        value: 2,
                                        groupValue: selectedRadioTile,
                                        title: Text("Calculate without Capacity"),
 
                                        onChanged: (val) {
                                       
                                          setSelectedRadioTile(int.parse(val.toString()));
                                        },
                                        activeColor: selectedRadioTile == 2? Colors.red:Colors.black,
  
                                        selected: true,
                                      ),

                                   ]
                                   ),
                                  ),
                                  ),
                                // Row(
                                //   children: <Widget>[
                                //     ListTile(  
                                //       title: const Text('www.javatpoint.com'),  
                                //       leading: Radio(  
                                //         value: 1,  
                                //         groupValue: group,  
                                //         onChanged:(T){
                                //           print(T);
                                //           setState(() {
                                                                                      
                                //           });
                                //         },  
                                //       ),  
                                //     ),  
                                //   ],
                                // ),

                                Container(
                                  width: width*0.9,
                                  alignment: Alignment.center,

                                  child: withCapacity  ? Column(
                                    children: <Widget>[
                                      SizedBox(height: 15,),
                                      Text('Total Solar pannel Capacity',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                                      
                  
                                      controller: capacityTxtField,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                        hintText: 'Enter Solar Panel Capacity in Kilo watt'
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                   
                                    ]
                                  ): Column(
                                    children: <Widget>[


                                      SizedBox(height: 15,),
                                    Text('One panel Capacity',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04, color: Colors.white),
                                    
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                  
                                      controller: oPanelCapacityTxtField,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                        hintText: 'Enter capacity in (wh)'
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Text('One Pannel Area',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04, color: Colors.white),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                  
                                      controller: oPAreaTxtField,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                        hintText: 
                                        
                                        'Enter the value in square meter (m\u00B2)'
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                      
                                    
                                    ],
                                  )
                                ),
                                Container(
                                  width: width*0.9,
                                  child: withOrWithoutShadeHome ? 
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 15,),
                                    Text('Highest point of solar pannel',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                  
                                      controller: hPointTxtField,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                        hintText: 'Enter the value in meter (m)'
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Text('Lowest point of solar pannel',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                  
                                      controller: lPointTxtField,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                        hintText: 'Enter the value in meter (m)'
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Text('Perpendiculer distance between ',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04),
                                    ),
                                    Text('Highes point and Lowest point of Solar panel ',
                                    style: TextStyle(fontSize: constraints.maxWidth*0.04),
                                    ),
                                    SizedBox(height: 10,),
                                    TextField(
                  
                                      controller: distanceTxtField,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                          
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                        ),
                                        hintText: 'Enter the value in meter (m)'
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    )
                                  ],
                                ):null,
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
                                  print( capacityTxtField.text);
                                  // _showTimePicker(context,constraints,endTime);
                                  http.Response response = await calculate();
                                  if (response.statusCode == 200) {
                                    setState(() {
                                        finalResult = response.body.toString();
                                    });
                                    
                                    print("SUCCESS: " + finalResult);
                                  } else {
                                    
                                      finalResult = response.statusCode.toString();  
                                    
                                    
                                    print("REQUEST FAILED " + "STARTUS_CODE: " + finalResult);
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
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                    )
                                  )
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
