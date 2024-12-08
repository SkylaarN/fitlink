import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolygon extends StatefulWidget {
  const GoogleMapPolygon({super.key});

  @override
  State<GoogleMapPolygon> createState() => _GoogleMapPolygonState();
}

class _GoogleMapPolygonState extends State<GoogleMapPolygon> {
  LatLng myCurrentLocation = const LatLng(-26.52136817051537, 27.826930446109476);
  final Completer<GoogleMapController> _completer = Completer();

  final Set<Marker> markers = {};

  Set<Polygon> polygone = HashSet<Polygon>();
  List<LatLng> points = [
    const LatLng(-26.52136817051537, 27.826930446109476),
    const LatLng(-26.518085135696154, 27.84230097563743),
    const LatLng(-26.496876244247154, 27.846862552142504),
    const LatLng(-26.490308680773143, 27.835061952053298),
    const LatLng(-26.52136817051537, 27.826930446109476),
  ];
  void addPolygon() {
    polygone.add(
      Polygon(
        polygonId: PolygonId("Id"),
        points: points,
        strokeColor: Colors.blueAccent,
        strokeWidth: 4,
        fillColor: Colors.green.withOpacity(0.1),
        geodesic: true,
      ),
    );
  }

  @override
  void initState() {
    addPolygon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Maps Polylines")),
      body: GoogleMap(
        polygons: polygone,
        myLocationButtonEnabled: false,
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: myCurrentLocation,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
