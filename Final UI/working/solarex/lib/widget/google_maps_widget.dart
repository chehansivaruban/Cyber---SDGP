import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  List<Marker> withShadingSolarpanelList = [];
  bool solarPanelButton = true;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _startCamPosition = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _startCamPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: checkLocationType(),
          markers: Set.from(withShadingSolarpanelList),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(right: 50.0),
          width: 50.0,
          height: 50.0,
          child: FloatingActionButton(
            onPressed: _goToCurrentLocation,
            child: Image.asset('images/gps.png'),

            // backgroundColor: Colors.blue,
          ),
        ));
  }

  onTapMapTrue(LatLng onTapLatLang) {
    print(onTapLatLang);
    setState(() {
      // with_shading_solarpanel_list = [];
      withShadingSolarpanelList.add(Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          onTap: removeMarkerSolarPannel(onTapLatLang.toString()),
          onDragEnd: (dragEndPoint) {
            print(dragEndPoint);
          }));
    });
  }

  removeMarkerSolarPannel(String latlang) {
    for (Marker marker in withShadingSolarpanelList) {
      print('working1');
      if (marker.markerId.toString() == latlang) {
        withShadingSolarpanelList.remove(marker);
        print('working');
      }
    }
  }

  onTapMapFalse(LatLng onTapLatLang) {
    print(onTapLatLang);
    setState(() {
      // with_shading_solarpanel_list = [];
      withShadingSolarpanelList.add(Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onDragEnd: (dragEndPoint) {
            print(dragEndPoint);
          }));
    });
  }

  //solar pannel location in with shading button

  sloarPanelBool(bool bool) {
    solarPanelButton = bool;
  }

  checkLocationType() {
    if (solarPanelButton == true) {
      return onTapMapTrue;
    } else if (solarPanelButton == false) {
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
        return Future.error('Location permissions are denied');
      }
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    //------------------------

    final CameraPosition _currentLocationCam = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19.151926040649414);

    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_currentLocationCam));
  }
}
