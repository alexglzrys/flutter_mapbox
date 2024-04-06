import 'package:flutter/material.dart';
import 'package:mapbox_flutter_app/screens/full_screen.dart';

void main() => runApp(const MapboxApp());

class MapboxApp extends StatelessWidget {
  const MapboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapas con Mapbox',
      home: FullScreen(),
    );
  }
}
