import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _sanFrancisco =
      LatLng(37.77483, -122.41942); // San Francisco coordinates
  GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _sanFrancisco,
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _googleMapController = controller;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }
}
