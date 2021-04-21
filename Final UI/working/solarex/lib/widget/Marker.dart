
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ObjectMarker{
   late double height;
  late double width;
  late double lat;
  late double lng;

 
  ObjectMarker(){}


double getHeight() {
    return height;
  }

void setheight(double height) {
  this.height = height;
}

double getWidth() {
    return width;
  }

void setWidth(double height) {
  this.width = width;
}

Marker marker(LatLng onTapLatLang){
  Marker marker  = new Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          //     onDragEnd: (dragEndPoint){
          onDragEnd: (dragEndPoint){
            print(dragEndPoint);
          }
  );
 

  this.lat = onTapLatLang.latitude;
  this.lng = onTapLatLang.latitude;
  return marker;


}

  ObjectMarker.fromJson(Map<String, dynamic> json)
      : height = json['height'],
        width = json['width'],
        lat = json['lat'],
        lng = json['lng'];
Map<String, dynamic> toJson() =>{
  'height': height,'width':width,'lat': lat,'lng':lng

};
      

}