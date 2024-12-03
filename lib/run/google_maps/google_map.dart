import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutterState();
}

class _GoogleMapFlutterState extends State<GoogleMapFlutter> {
  LatLng myCurrentLocation = const LatLng(-26.20227, 28.04363);
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

@override
  void initState() {
    // TODO: implement initState
    customMarker();
    super.initState();
  }

  void customMarker () {
    BitmapDescriptor.asset(
      const ImageConfiguration(), 
      "images/location.jpeg"
      ).then((icon){
        setState(() {
          customIcon = icon;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: myCurrentLocation,
        zoom: 15
        ),
        markers:  {
          Marker(
            markerId: const MarkerId("MarkerId"), 
            position: myCurrentLocation,
            draggable: true,
            onDragEnd: (value){},
            infoWindow: const InfoWindow(
              title: "Title of the marker",
              snippet: "more info about the marker"
            ),
            // custom Icon for my current location in google maps
            // icon: customIcon,
            )
        },
        ),
    );
  }
}