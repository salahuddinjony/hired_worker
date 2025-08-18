import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/app_const/app_const.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';

class MapController extends GetxController {
  // Observable variables
  var cameraPosition =
      const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 12).obs;
  var markers = <Marker>{}.obs;
  GoogleMapController? mapController;
  RxBool isClean = false.obs;
  var suggestions = <Map<String, dynamic>>[].obs;
  var selectedLocation = Rxn<Map<String, dynamic>>();
  final String apiKey = AppConstants.mapApiKey;

  @override
  void onInit() {
    super.onInit();
    _addInitialMarker();
    getUserLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
  }

  void _addInitialMarker() {
    markers.add(
      Marker(
        markerId: const MarkerId('initial_marker'),
        position: const LatLng(37.7749, -122.4194),
        infoWindow: const InfoWindow(title: 'San Francisco'),
      ),
    );
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    cameraPosition.value = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 15,
    );

    markers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );
    // Fetch address via reverse geocoding
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    String address = 'Unknown Address';
    if (data['status'] == 'OK' && data['results'].isNotEmpty) {
      address = data['results'][0]['formatted_address'];
    }
    // Set current location as selected by default
    selectedLocation.value = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    };

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition.value),
    );
  }

  // Handle map tap to mark a location
  Future<void> onMapTap(LatLng position) async {
    try {
      // Fetch address via reverse geocoding
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      String address = 'Unknown Address';
      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        address = data['results'][0]['formatted_address'];
      }

      // Update selected location
      selectedLocation.value = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': address,
      };

      // Update marker
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          infoWindow: InfoWindow(title: address),
        ),
      );

      // Move camera to the tapped position
      cameraPosition.value = CameraPosition(target: position, zoom: 15);
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition.value),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to get address: $e');
    }
  }

  // Fetch place autocomplete suggestions
  Future<void> fetchPlaceSuggestions(String query) async {
    if (query.isEmpty) {
      suggestions.clear();
      isClean.value = false;
      return;
    }

    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&types=(cities)';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        suggestions.value =
            List<Map<String, dynamic>>.from(data['predictions'])
                .map(
                  (prediction) => {
                    'description': prediction['description'],
                    'place_id': prediction['place_id'],
                  },
                )
                .toList();
        isClean.value = true;
      } else {
        suggestions.clear();
        Get.snackbar('Error', 'No suggestions found for "$query".');
      }
    } catch (e) {
      suggestions.clear();
      Get.snackbar('Error', 'Failed to fetch suggestions: $e');
    }
  }

  // Search for a place using place_id from autocomplete
  Future<void> searchPlaceById(String placeId) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,geometry,formatted_address&key=$apiKey';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final place = data['result'];
        final lat = place['geometry']['location']['lat'];
        final lng = place['geometry']['location']['lng'];
        final name = place['name'];
        final address = place['formatted_address'];

        // Update selected location
        selectedLocation.value = {
          'latitude': lat,
          'longitude': lng,
          'address': address,
        };

        cameraPosition.value = CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15,
        );

        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId('searched_place'),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name),
          ),
        );

        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition.value),
        );
        suggestions.clear();
      } else {
        Get.snackbar('Error', 'No results found for selected place.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search place: $e');
    }
  }

  // Search for a place using text query
  Future<void> searchPlace(String query) async {
    if (query.isEmpty) {
      isClean.value = false;
      return;
    }

    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        final place = data['results'][0];
        final lat = place['geometry']['location']['lat'];
        final lng = place['geometry']['location']['lng'];
        final name = place['name'];
        final address = place['formatted_address'] ?? name;

        // Update selected location
        selectedLocation.value = {
          'latitude': lat,
          'longitude': lng,
          'address': address,
        };

        cameraPosition.value = CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15,
        );

        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId('searched_place'),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name),
          ),
        );

        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition.value),
        );
      } else {
        Get.snackbar('Error', 'No results found for "$query".');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search place: $e');
    }
  }

  void setIsClean(bool value) => isClean.value = value;

  // Clear selected location
  void clearSelectedLocation() {
    selectedLocation.value = null;
    markers.clear();
    suggestions.clear();
    isClean.value = false;
    getUserLocation();
  }

  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  Future<void> updateContractorData() async {
    status.value = RxStatus.loading();

    final String userId = await SharePrefsHelper.getString(AppConstants.userId);

    String uri = '${ApiUrl.updateUser}/$userId';

    Map<String, String> body = {
      'data': '{"location": "${selectedLocation.value?['address']}"}',
    };

    try {
      var response = await ApiClient.patchMultipartData(
        uri,
        body,
        multipartBody: [],
      );

      if (response.statusCode == 200) {
        debugPrint('Selected Location: ${selectedLocation.value}');

        status.value = RxStatus.success();

        Get.toNamed(AppRoutes.scheduleSeletedScreen);
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "response.statusText",
          isError: true,
        );

        status.value = RxStatus.error();
      }
    } catch (e) {
      debugPrint('Error updating contractor data: $e');

      showCustomSnackBar("Error updating contractor data: $e", isError: true);

      status.value = RxStatus.error();
    }
  }
}