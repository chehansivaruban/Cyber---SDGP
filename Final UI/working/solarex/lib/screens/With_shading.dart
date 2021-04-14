
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class With_Shading extends StatefulWidget {
  final bool withShading;
  With_Shading(this.withShading);
  
  @override
  _With_ShadingState createState() => _With_ShadingState();

}

class _With_ShadingState extends State<With_Shading> {

  
List<Marker> solarpanel_LatLan_list = [];
List<Marker> object_list = [];
  bool solar_panel_button = true ;


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _startCamPosition = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    zoom: 14.4746,
  );

  _onTap_map_true(LatLng onTap_LatLang){
    print(onTap_LatLang);
    setState(() {
     // with_shading_solarpanel_list = [];
     if(solarpanel_LatLan_list.length < 4){
       solarpanel_LatLan_list.add(
        Marker(
          markerId: MarkerId(onTap_LatLang.toString()),
          position: onTap_LatLang,
          draggable: true,
          onTap: _remove_marker_solar_pannel(onTap_LatLang.toString()),
          onDragEnd: (dragEndPoint){
            print(dragEndPoint);
          }
        )
      );

     }
      
      
    });
  }



  _remove_marker_solar_pannel(String latlang){
    for(Marker marker in solarpanel_LatLan_list){
      print('working1');
      if(marker.markerId.toString() == latlang){
        solarpanel_LatLan_list.remove(marker);
        print('Removed location');
      }
    }
  }

  _onTap_map_false(LatLng onTap_LatLang){
    print(onTap_LatLang);
    setState(() {
      // with_shading_solarpanel_list = [];
      solarpanel_LatLan_list.add(
          Marker(
              markerId: MarkerId(onTap_LatLang.toString()),
              position: onTap_LatLang,
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

  _sloar_panel_bool(bool bool){
    solar_panel_button = bool;
  }

   _check_location_type(){
    if(solar_panel_button == true){
      return _onTap_map_true;
    }
    else if(solar_panel_button == false){
      return _onTap_map_false;
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

//////////////////////////////////////////////////////////////


  @override
  Widget build(BuildContext context) {

    bool withOrWithoutShadingBtn = widget.withShading;

    return Scaffold(
      appBar:AppBar(title: Text('SolareX'),) ,

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
                    child:Scaffold(

                        body: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: _startCamPosition,
                          onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          },
                        onTap: _check_location_type(),
                        markers: Set.from(solarpanel_LatLan_list),

                        ),
                      floatingActionButton: Container(
                        margin: const EdgeInsets.only(right: 50.0),
                        width: 50.0,
                        height: 50.0,
                        child: FloatingActionButton(
                          onPressed: _goToCurrentLocation,
                            child: Image.asset('images/gps.png'),
                        ),
                      )
                  ),




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
                   

                    child:ElevatedButton(
                      onPressed: () {
                        solar_panel_button = true;
                       },//this
                      child: Row(
                      

                        children: <Widget>[
                          Container(
                            child: !widget.withShading ? Container(
                              width: 340,
                  
                              child:  Column(
                                children: <Widget>[

                                    Image.asset('images/roof.png'),
                                    Text('Add Solar Panel Location')

                                ],
                                )
                            ):Container(
                              width: 160.0,
                              child:  Column(
                                children: <Widget>[

                                    Image.asset('images/roof.png'),
                                    Text('Add Solar Panel Location')

                                ],
                                )
                            ),
                          )
                        

                        
                          
                        ],
                        
                      )
                    ),
                  ),

                  Container(
                   
                    child: !widget.withShading ? null : ElevatedButton(
                      onPressed: () {
                        solar_panel_button = false;
                      },
                      child:  Container(
                         width: 150.0,
                        child: Column(
                        children: <Widget>[
                          Image.asset('images/tree.png'),
                          Text('Add Shading Objects')

                        ],
                      )
                       

                      )
                    ),
                  ),
                  
                  
                ]


              )
            ),
            Container(
                   child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term'
                    ),
                  )
            )

            
            
          ]
          ),
        )
    );
  }
}
