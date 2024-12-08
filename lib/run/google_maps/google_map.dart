import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutterState();
}

class _GoogleMapFlutterState extends State<GoogleMapFlutter> {
  LatLng myCurrentLocation = const LatLng(-26.20227, 28.04363);
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {}; // To store the trace line
  List<LatLng> tracePoints = []; // List of points for the polyline
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    checkPermissions().then((isGranted) {
      if (isGranted) {
        startRealTimeTracking();
      } else {
        // Handle case where permissions are not granted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions not granted")),
        );
      }
    });
  }

  @override
  void dispose() {
    positionStream.cancel(); // Cancel the stream when the widget is disposed
    super.dispose();
  }

  Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void startRealTimeTracking() {
    // Check permissions and start listening to position updates
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2, // Update every 2 meters
      ),
    ).listen((Position position) {
      LatLng newPosition = LatLng(position.latitude, position.longitude);

      // Add the new position to the trace
      setState(() {
        tracePoints.add(newPosition);

        // Update the trace polyline
        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: const PolylineId("trace_polyline"),
            points: tracePoints,
            color: Colors.blue,
            width: 5,
          ),
        );

        // Update the marker
        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId("real_time_marker"),
            position: newPosition,
            infoWindow: const InfoWindow(title: "Current Location"),
          ),
        );

        // Optional: Animate the camera to the new position
        googleMapController.animateCamera(
          CameraUpdate.newLatLng(newPosition),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true, // Show the blue dot for the current location
        myLocationButtonEnabled: false,
        markers: markers,
        polylines: polylines, // Show the trace line
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: myCurrentLocation,
          zoom: 15,
        ),
      ),
    );
  }
}
