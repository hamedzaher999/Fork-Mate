import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fork_mate/view/customer/widget/custom_back_button.dart';
import 'package:fork_mate/view/customer/widget/custom_field.dart';
import 'package:fork_mate/view/customer/widget/location_details_card.dart';
import 'package:fork_mate/view/sections/location_permission_section.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/location_page_controller.dart';
import 'package:fork_mate/utils/size_config.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetX<LocationController>(
        builder: (controller) {
          //if location permission & services denied
          if (!controller.access.value) {
            return LocationPermissionSection();
          }
          return SizedBox(
            height: SizeConfig.height,
            width: SizeConfig.width,
            child: Stack(
              children: [
                //map
                FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                    initialCenter:
                        controller.myLocation.value ?? LatLng(33.5138, 36.2765),
                    initialZoom: 13,
                    onTap: (tapPosition, point) {
                      controller.setLocationFromTap(point);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                      subdomains: ['a', 'b', 'c', 'd'],
                      userAgentPackageName: 'com.shawarma.myapp',
                    ),
                    if (controller.locationDetails.value?.route.isNotEmpty ??
                        false)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: controller.locationDetails.value!.route,
                            color: Colors.blue,
                            strokeWidth: 4,
                          ),
                        ],
                      ),
                    // Marker for selected location (only if not null)
                    if (controller.myLocation.value != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: controller.myLocation.value!,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                //selected location details
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LocationDetailsCard(),
                ),
                //search field
                Positioned(
                  top: SizeConfig.height * 0.05,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.sidePadding),
                    child: CustomField(
                      controller: controller.searchController,
                      focusNode: controller.searchFocusNode,
                      color: backGroundColor,
                      onSubmitted: controller.searchByName,
                      suffix: CustomBackButton(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
