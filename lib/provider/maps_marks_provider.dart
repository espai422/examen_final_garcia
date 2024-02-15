import 'package:examen_final_garcia/provider/api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsMarks extends ChangeNotifier {
  Set<Marker> _markers = {
    // ADD A MARKER FOR PALMA DE MALLORCA
    // Marker(
    //   markerId: MarkerId('1'),
    //   position: const LatLng(40.4165, -3.7026),
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

  MapsMarks() {
    _init();
  }

  _init() async {
    // get ip
    final ipProvider = ApiProvider('https://api.ipify.org/?format=json');
    final ipdata = await ipProvider.fetchJsonData('');
    final ip = ipdata['ip'];

    // get cords of IP
    final cordsProvider = ApiProvider('https://ipinfo.io/');
    final cordsData = await cordsProvider.fetchJsonData('$ip/geo');
    String cords = cordsData['loc'];
    double lat = double.parse(cords.split(',')[0]);
    double lng = double.parse(cords.split(',')[1]);
    final marker =
        // Marker(
        //   markerId: MarkerId('Ip position'),
        //   position: LatLng(
        //     double.parse(cords.split(',')[0]),
        //     double.parse(cords.split(',')[1]),
        //   ),
        //   infoWindow: const InfoWindow(title: 'Ip position'),
        //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        // );
        Marker(
      markerId: MarkerId('1'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(title: 'Palma de Mallorca'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    );
    addMarker(marker);
    notifyListeners();
  }

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
