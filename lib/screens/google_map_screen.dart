import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Screen displaying a full-screen Google Map with a marker on Cairo Governorate, Egypt.
class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // Cairo Governorate, Egypt coordinates
  static const LatLng _cairoLocation = LatLng(30.0444, 31.2357);

  // Set of markers to place on the Google Map
  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('cairo_governorate'),
      position: _cairoLocation,
      infoWindow: const InfoWindow(
        title: 'Cairo Governorate',
        snippet: 'Egypt',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      // Full-screen Google Map widget
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _cairoLocation,
          zoom: 12.0,
        ),
        markers: _markers,
        myLocationEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
