import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// Widget que hace referencia al mapa mostrado a pantalla completa
// Dada la interactividad del mapa, se recomienda hacer uso de widgets con estado
class FullScreen extends StatefulWidget {
  const FullScreen({super.key});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  MapboxMapController? mapController;
  var isLight = true;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Widget oficial de Mapbox
        // Ejemplos en... https://github.com/flutter-mapbox-gl/maps/blob/master/example/lib/full_map.dart
        body: MapboxMap(
      styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,
      accessToken:
          'pk.eyJ1IjoianNjb25lc3RpbG8iLCJhIjoiY2x1b2J2OGx3MGd4dDJqcDdjbjg2eGZhaSJ9.uODlj3lavhP8Yv3syuS17A',
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(19.281610, -99.662491),
        zoom: 16,
      ),
      onStyleLoadedCallback: _onStyleLoadedCallback,
    ));
  }
}
