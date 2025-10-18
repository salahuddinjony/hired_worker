import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text_field/custom_text_field.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';

import '../../../components/custom_loader/custom_loader.dart';

class SelectedMapScreen extends StatelessWidget {
  const SelectedMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Select Location".tr,
      ),
      body: Stack(
        children: [
          Obx(() {
            mapController.cameraPosition.value = const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12,
            );

            return GoogleMap(
              initialCameraPosition: mapController.cameraPosition.value,
              onMapCreated: mapController.onMapCreated,
              markers: mapController.markers.toSet(),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onTap: (LatLng position) {
                mapController.onMapTap(position);
                searchController.text =
                    mapController.selectedLocation.value?['address'] ??
                    'San Francisco';
                mapController.setIsClean(true);
              },
            );
          }),
          Positioned(
            top: 30,
            right: 30,
            left: 30,
            child: Column(
              children: [
                CustomTextField(
                  textEditingController: searchController,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textCLr,
                  ),
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
                            icon: const Icon(
                              Icons.clear,
                              color: AppColors.textCLr,
                            ),
                            onPressed: () {
                              searchController.clear();
                              mapController.clearSelectedLocation();
                            },
                          )
                          : null,
                  hintText: 'Enter your address'.tr,
                  hintStyle: const TextStyle(color: AppColors.textCLr),
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
                                    style: const TextStyle(
                                      color: AppColors.textCLr,
                                    ),
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
          Obx(() {
            return Positioned(
              bottom: 30,
              right: 30,
              left: 30,
              child:
                  mapController.status.value.isLoading
                      ? const CustomLoader()
                      : CustomButton(
                        onTap: () {
                          if (mapController.selectedLocation.value != null) {
                            mapController.updateContractorData();
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please select a location first.',
                            );
                          }
                        },
                        title: "Continue".tr,
                      ),
            );
          }),
        ],
      ),
    );
  }
}
