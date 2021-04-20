import 'package:google_maps_flutter/google_maps_flutter.dart';
class ObjectMarker{

  ObjectMarker(){}

Marker marker(LatLng onTapLatLang){
  Marker marker  = new Marker(
          markerId: MarkerId(onTapLatLang.toString()),
          position: onTapLatLang,
          draggable: true,
          //onTap: removeMarkerSolarPannel(onTapLatLang.toString()),
          onDragEnd: (dragEndPoint){
            print(dragEndPoint);
          }
  );
  return marker;

}
      

}