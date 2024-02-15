import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsMarks extends ChangeNotifier {
  Set<Marker> _markers = {
    // ADD A MARKER FOR PALMA DE MALLORCA
    // Marker(
    //   markerId: MarkerId('1'),
    //   position: const LatLng(39.8729607, 3.0256346),
    //   infoWindow: const InfoWindow(title: 'Palma de Mallorca'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    // ),

    // // add another marker in barcelona
    // Marker(
    //   markerId: MarkerId('2'),
    //   position: const LatLng(41.3851, 2.1734),
    //   infoWindow: const InfoWindow(title: 'Barcelona'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    // ),
  };

  void addMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void removeMarker(Marker marker) {
    _markers.remove(marker);
    notifyListeners();
  }

  set markers(Set<Marker> markers) {
    _markers = markers;
    notifyListeners();
  }

  Set<Marker> get markers => _markers;

  /// String format '39.8729607,3.0256346'
  void addMarkerByString(String id, String cords) {
    final latLng = cords.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    addMarker(Marker(markerId: MarkerId(id), position: LatLng(lat, lng)));
  }
}
