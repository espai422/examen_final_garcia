import 'dart:async';

import 'package:examen_final_garcia/provider/maps_marks_provider.dart';
import 'package:examen_final_garcia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Widget for displaying a map with a specific scan's location using Google Maps.
class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  // Completer to handle the initialization of the GoogleMapController.
  final Completer<GoogleMapController> _controller = Completer();

  MapType _mapType = MapType.normal;
  double tilt = 0;

  @override
  Widget build(BuildContext context) {
    // Retrieve the ScanModel from the route arguments.
    // final ScanModel scan =
    //     ModalRoute.of(context)!.settings.arguments as ScanModel;

    final markers = Provider.of<MapsMarks>(context).markers;
    final centerMarker = markers.toList().elementAtOrNull(0) ??
        Marker(markerId: MarkerId('default'), position: LatLng(1, 1));

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text('Mapa'),

        // Actions in the AppBar for re-centering the map and toggling the tilt.
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;

              // Animate the camera to the scan's location with the current zoom and tilt values.
              controller.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                  target: centerMarker.position,
                  zoom: await controller.getZoomLevel(),
                  tilt: tilt,
                )),
              );
            },
            icon: const Icon(Icons.location_searching),
          ),
          IconButton(
            onPressed: () {
              // Toggle between 0 and 45-degree tilt angles.
              setState(() async {
                tilt = (tilt == 0) ? 45 : 0;
                final GoogleMapController controller = await _controller.future;

                // Animate the camera to the scan's location with the current zoom and tilt values.
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                    target: centerMarker.position,
                    zoom: await controller.getZoomLevel(),
                    tilt: tilt,
                  )),
                );
              });
            },
            // Use the Rotate 90 degrees CCW icon for tilt action.
            icon: const Icon(Icons.rotate_90_degrees_ccw),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Toggle the map type
          _mapType =
              (_mapType == MapType.normal) ? MapType.satellite : MapType.normal;

          // Update the UI to reflect the new map type.
          setState(() {});
        },
        child: const Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: centerMarker.position,
          zoom: 17,
        ),
        myLocationEnabled: true,
        mapType: _mapType,
        myLocationButtonEnabled: true,
        tiltGesturesEnabled: true,
        markers: markers,
      ),
    );
  }
}
