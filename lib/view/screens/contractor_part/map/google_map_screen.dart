import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:servana/utils/app_colors/app_colors.dart';

class GoogleMapScreen extends StatefulWidget {
  final String location;

  const GoogleMapScreen({
    super.key,
    required this.location,
  });

  @override
  GoogleMapScreenState createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;
  late CameraPosition initialPosition;
  final Set<Marker> markers = {};
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    initialPosition = const CameraPosition(
      target: LatLng(37.7749, -122.4194), // Default position (e.g., San Francisco)
      zoom: 13.0,
    );
    _initializeMapPosition();
  }

  Future<void> _initializeMapPosition() async {
    try {
      // Geocode the address to get coordinates
      final locations = await geocoding.locationFromAddress(widget.location.isNotEmpty ? widget.location : "Mexico");
      if (locations.isNotEmpty) {
        final location = locations.first;

        setState(() {
          // Set initial position to the geocoded location
          initialPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 13.0,
          );

          // Add marker for the location
          markers.add(
            Marker(
              markerId: const MarkerId('locationMarker'),
              position: LatLng(location.latitude, location.longitude),
              infoWindow: InfoWindow(
                title: widget.location,
              ),
            ),
          );

          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Location not found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Please enter a location (e.g., "Central Park, NY" or "1600 Pennsylvania Ave")';
        isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.location),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: initialPosition,
        markers: markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}