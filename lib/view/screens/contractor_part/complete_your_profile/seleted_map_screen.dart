import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text_field/custom_text_field.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';

class SeletedMapScreen extends StatelessWidget {
  const SeletedMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Selecte Location"),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: mapController.cameraPosition.value,
              onMapCreated: mapController.onMapCreated,
              markers: mapController.markers.toSet(),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
               onTap: (LatLng position) {
                mapController.onMapTap(position);  
                searchController.text =
                    mapController.selectedLocation.value?['address'] ?? '';
                mapController.setIsClean(true);
              },
            ),
          ),
          Positioned(
            top: 30,
            right: 30,
            left: 30,
            child: Column(
              children: [
                CustomTextField(
                  textEditingController: searchController,
                  prefixIcon: Icon(Icons.search, color: AppColors.textCLr),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      mapController.setIsClean(true);
                      mapController.fetchPlaceSuggestions(value);
                    } else {
                      mapController.setIsClean(false);
                      mapController.suggestions.clear();
                    }
                  },
                  suffixIcon:
                      mapController.isClean.value
                          ? IconButton(
                            icon: Icon(Icons.clear, color: AppColors.textCLr),
                            onPressed: () {
                              searchController.clear();
                              mapController.clearSelectedLocation();
                            },
                          )
                          : null,
                  hintText: 'Enter your address',
                  hintStyle: TextStyle(color: AppColors.textCLr),
                  fillColor: AppColors.white,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      mapController.searchPlace(value);
                      mapController.suggestions.clear();
                    }
                  },
                ),
                Obx(
                  () =>
                      mapController.suggestions.isNotEmpty
                          ? Container(
                            constraints: const BoxConstraints(maxHeight: 200),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: mapController.suggestions.length,
                              itemBuilder: (context, index) {
                                final suggestion =
                                    mapController
                                        .suggestions[index]['description'];
                                return ListTile(
                                  title: Text(
                                    suggestion,
                                    style: TextStyle(color: AppColors.textCLr),
                                  ),
                                  onTap: () {
                                    searchController.text = suggestion;
                                    mapController.searchPlaceById(
                                      mapController
                                          .suggestions[index]['place_id'],
                                    );
                                    mapController.setIsClean(true);
                                  },
                                );
                              },
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            left: 30,
            child: CustomButton(
              onTap: () {
                if (mapController.selectedLocation.value != null) {
                  Get.toNamed(
                    AppRoutes.scheduleSeletedScreen,
                    arguments: mapController.selectedLocation.value,
                  );
                  debugPrint(
                    'Selected Location: ${mapController.selectedLocation.value}',
                  );
                } else {
                  Get.snackbar('Error', 'Please select a location first.');
                }
              },
              title: "Continue",
            ),
          ),
        ],
      ),
    );
  }
}
