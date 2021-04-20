import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ObjectMarker{
  late double height;
  late double width;
  


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
  return marker;

}
      

}