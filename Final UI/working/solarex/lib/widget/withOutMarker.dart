import 'package:google_maps_flutter/google_maps_flutter.dart';
class PanelMarker{
  
  late double latS;
  late double lngS;

 
  PanelMarker(){}

Marker marker(LatLng onTapLatLang){
  Marker marker  = new Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          //     onDragEnd: (dragEndPoint){
          onDragEnd: (dragEndPoint){
            print(dragEndPoint);
          }
  );
 

  this.latS = onTapLatLang.latitude;
  this.lngS = onTapLatLang.latitude;
  return marker;
}

  PanelMarker.fromJson(Map<String, dynamic> json)
      : 
        latS = json['latS'],
        lngS = json['lngS'];
Map<String, dynamic> toJson() =>{
  'latS': latS,'lngS':lngS
};
      

}