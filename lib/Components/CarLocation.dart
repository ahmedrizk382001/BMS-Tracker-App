import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CarLocation extends StatefulWidget {
  const CarLocation({super.key});

  @override
  State<CarLocation> createState() => _StateCarLocation();
}

class _StateCarLocation extends State<CarLocation> {
  double latitude = 30.044420, longtide = 31.235712;
  bool locationButtonPressed = false;

  Future<void> _OpenMap(double lat, double long) async {
    String googleURL = 'https://www.google.com/maps/search/$lat,$long';
    if (await canLaunchUrlString(googleURL)) {
      await launchUrlString(googleURL);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.all(5),
      color: const Color.fromARGB(255, 6, 29, 15),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  locationButtonPressed = true;
                });
              },
              child: const Text(
                "Current Location",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xffec872b),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: Color(0xffec872b),
                  )),
            ),
            if (locationButtonPressed)
              const SizedBox(
                height: 10,
              ),
            if (locationButtonPressed)
              Text(
                "latitude: $latitude",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            if (locationButtonPressed)
              const SizedBox(
                height: 5,
              ),
            if (locationButtonPressed)
              Text(
                "longtide: $longtide",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            if (locationButtonPressed)
              const SizedBox(
                height: 30,
              ),
            if (!locationButtonPressed)
              const SizedBox(
                height: 20,
              ),
            ElevatedButton(
              onPressed: () {
                _OpenMap(latitude, longtide);
              },
              child: const Text(
                "Location on Google Maps",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xffec872b),
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: Color(0xffec872b),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}





























/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarLocation extends StatefulWidget {
  const CarLocation({super.key});
  @override
  State<CarLocation> createState() => _StateCarLocation();
}

class _StateCarLocation extends State<CarLocation> {
  static const double lat = 30.044420;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _InitLocation = CameraPosition(
    target: LatLng(30.044420, 31.235712),
    zoom: 14.4746,
  );
  List<Marker> LocationIndicatorIcon = [
    const Marker(
        markerId: MarkerId("Car Location"),
        position: LatLng(30.044420, 31.235712),
        icon: BitmapDescriptor.defaultMarker),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Car Location",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff092f19),
              fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _InitLocation,
              mapType: MapType.normal,
              markers: LocationIndicatorIcon.toSet(),
            ),
          ),
        ],
      ),
    );
  }
}*/
