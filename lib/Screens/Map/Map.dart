import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({Key? key}) : super(key: key);


  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> with AutomaticKeepAliveClientMixin<MapScreen>{
  late GoogleMapController mapController;
  var position;
  var zoom;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    zoom=10.0;
    position=LatLng(45.188,5.724);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return GoogleMap(
        initialCameraPosition: CameraPosition(
            target: position,
            zoom: zoom,
        ),
      onMapCreated: (GoogleMapController controller) {
          mapController=controller;
          position=mapController.getLatLng(ScreenCoordinate(x: (queryData.size.width*queryData.devicePixelRatio/2).round(), y: (queryData.size.height*queryData.devicePixelRatio/2).round()));
          zoom=mapController.getZoomLevel();
          
      },
    );


  }
}
