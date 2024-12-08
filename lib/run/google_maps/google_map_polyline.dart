import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolyline extends StatefulWidget {
  const GoogleMapPolyline({super.key});

  @override
  State<GoogleMapPolyline> createState() => _GoogleMapPolylineState();
}

class _GoogleMapPolylineState extends State<GoogleMapPolyline> {
  late GoogleMapController googleMapController;

  LatLng myCurrentLocation = const LatLng(-26.53137469224591, 27.826900281431875);

  final Set<Marker> markers = {};
  final Set<Polyline> _polylines = {};

  final List<LatLng> pointOnMap = [
    const LatLng(-26.53137469224591, 27.826900281431875),
    const LatLng(-26.52680122634223, 27.826639720610608),
    const LatLng(-26.51893356823255, 27.815998012331995),
    const LatLng(-26.51766778863322, 27.83147832327803),
    const LatLng(-26.513179912089516, 27.82172074372306),
    const LatLng(-26.505757269910834, 27.819052278842285),
  ];

  @override
  void initState() {
    super.initState();

    _polylines.add(
      Polyline(
        polylineId: const PolylineId("polyline_1"),
        points: pointOnMap,
        color: Colors.blue,
        width: 5,
      ),
    );

    for (int i = 0; i < pointOnMap.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: pointOnMap[i],
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bounds = boundsFromLatLngList(pointOnMap);
      googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double southWestLat = list.map((e) => e.latitude).reduce((a, b) => a < b ? a : b);
    double southWestLng = list.map((e) => e.longitude).reduce((a, b) => a < b ? a : b);
    double northEastLat = list.map((e) => e.latitude).reduce((a, b) => a > b ? a : b);
    double northEastLng = list.map((e) => e.longitude).reduce((a, b) => a > b ? a : b);

    return LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Maps Polylines")),
      body: GoogleMap(
        onMapCreated: (controller) => googleMapController = controller,
        polylines: _polylines,
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: myCurrentLocation,
          zoom: 15,
        ),
      ),
    );
  }
}
