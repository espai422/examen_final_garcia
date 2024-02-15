import 'package:examen_final_garcia/provider/api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Provider for the marks of the map, the screen will load all the marks of the
/// set of marks there are some functions to add and remove marks. In this case
/// is adapted to load the mark of the user's IP when the provider is created
/// because there is no reason to load it in another site, it could be done in
/// the maps screen, but this is a template so it is better to load it here to not
/// create breaking changes in the template.
class MapsMarks extends ChangeNotifier {
  Set<Marker> _markers = {};

  final ipProvider = ApiProvider('https://api.ipify.org/?format=json');
  final cordsProvider = ApiProvider('https://ipinfo.io/');

  MapsMarks() {
    _init();
  }

  /// Initialize the provider, i think there is no reason the map all the responses
  /// of the API, so i will only get the IP and the cords of the IP because there
  /// are no time to do it and is something that we are not going to use in the whole
  /// app, jsut in this lines of code to create a mark in the map.
  _init() async {
    // get ip
    final ipdata = await ipProvider.fetchJsonData('');
    final ip = ipdata['ip'];

    // get cords of IP
    final cordsData = await cordsProvider.fetchJsonData('$ip/geo');
    String cords = cordsData['loc'];
    double lat = double.parse(cords.split(',')[0]);
    double lng = double.parse(cords.split(',')[1]);
    final marker = Marker(
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
