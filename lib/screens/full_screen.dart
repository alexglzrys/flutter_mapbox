import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

// Widget que hace referencia al mapa mostrado a pantalla completa
// Dada la interactividad del mapa, se recomienda hacer uso de widgets con estado
class FullScreen extends StatefulWidget {
  const FullScreen({super.key});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  MapboxMapController? mapController;

  //var isLight = true;
  // Propiedad que especifica las coordenadas centrales a mostrar en el mapa
  final LatLng center = const LatLng(19.281610, -99.662491);
  // Propiedades que almacenan URL que apuntan a los estilos personalizados para este mapa
  final String styleStreets =
      'mapbox://styles/jsconestilo/cluodqqsj014r01pbgllt6mrt';
  final String styleSatellite =
      'mapbox://styles/jsconestilo/cluofycw7054v01qq4rtmd931';
  String styleDefault = 'mapbox://styles/jsconestilo/cluodqqsj014r01pbgllt6mrt';

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  _onStyleLoadedCallback() {
    /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));*/
  }

  // Método para crear símbolos personalizados.
  // (El nombre asignado se corresponderá con el nombre de este símbolo)
  void _onStyleLoaded() {
    // Crear un símbolo a partir de un recurso de imagen en nuestro proyecto
    addImageFromAsset("assetImage", "assets/images/symbols/partly_cloudy.png");
    // Crear un símbolo a partir de un recurso de imagen desde Internet
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Cargar una imagen usada como símbolo desde el directorio del proyecto
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Cardar una imagen usada como símbolo desde una URL
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapa(),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        // Botón para crear un Símbolo (objeto o marcador sobre el mapa)
        FloatingActionButton(
            onPressed: () {
              mapController!.addSymbol(SymbolOptions(
                  textField: 'Tortas el Pingüno',
                  // iconImage: 'fast-food',

                  // usar un recurso de imagen externo para personalizar el nuevo símbolo
                  iconImage: 'assetImage',
                  geometry: center,
                  textOffset: const Offset(0, 2.5),
                  iconSize: 3));
            },
            child: const Icon(Icons.emoji_symbols_sharp)),
        const SizedBox(height: 8),
        // Botón para Zoom In
        FloatingActionButton(
            onPressed: () {
              mapController!.animateCamera(CameraUpdate.zoomIn());
            },
            child: const Icon(Icons.zoom_in)),
        const SizedBox(height: 8),
        // Botón para Zoom Out
        FloatingActionButton(
            onPressed: () {
              mapController!.animateCamera(CameraUpdate.zoomOut());
            },
            child: const Icon(Icons.zoom_out)),
        const SizedBox(height: 8),
        // Cambiar el tipo de esquema o estilo de mapa
        FloatingActionButton(
          onPressed: () {
            if (styleDefault == styleStreets) {
              styleDefault = styleSatellite;
            } else {
              styleDefault = styleStreets;
            }
            setState(() {});
          },
          child: const Icon(Icons.style),
        ),
      ]),
    );
  }

  MapboxMap mapa() {
    // Widget oficial de Mapbox
    // Ejemplos en... https://github.com/flutter-mapbox-gl/maps/blob/master/example/lib/full_map.dart
    return MapboxMap(
      //styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,

      // Los estilos de mapa se pueden personalizar desde el sitio Web de Mapbox - sección studio
      styleString: styleDefault,
      accessToken:
          'pk.eyJ1IjoianNjb25lc3RpbG8iLCJhIjoiY2x1b2J2OGx3MGd4dDJqcDdjbjg2eGZhaSJ9.uODlj3lavhP8Yv3syuS17A',
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        // Inclinación del mapa Eje Z
        tilt: 60,
        zoom: 17,
      ),
      onStyleLoadedCallback: _onStyleLoadedCallback,
    );
  }
}
