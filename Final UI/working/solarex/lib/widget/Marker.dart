import 'package:google_maps_flutter/google_maps_flutter.dart';

class ObjectMarker {
  late String height;
  late String width;
  late String lat;
  late String lng;

  ObjectMarker() {}

  // double getHeight() {
  //   return height;
  // }

  // void setheight(double height) {
  //   this.height = height;
  // }

  // double getWidth() {
  //   return width;
  // }

  // void setWidth(double height) {
  //   this.width = width;
  // }

  Marker marker(LatLng onTapLatLang) {
    Marker marker = new Marker(
        markerId: MarkerId(onTapLatLang.toString()),
        position: onTapLatLang,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        //     onDragEnd: (dragEndPoint){
        onDragEnd: (dragEndPoint) {
          print(dragEndPoint);
        });

    this.lat = onTapLatLang.latitude.toString();
    this.lng = onTapLatLang.longitude.toString();
    return marker;
  }

  ObjectMarker.fromJson(Map<String, dynamic> json)
      : height = json['height'],
        width = json['width'],
        lat = json['lat'],
        lng = json['lng'];
Map<String, String> toJson() =>{
  'height': height.toString(),'width':width.toString(),'lat': lat,'lng':lng

};
      

}
