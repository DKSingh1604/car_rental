import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDetailsPage extends StatefulWidget {
  const MapDetailsPage({super.key});

  @override
  State<MapDetailsPage> createState() => _MapDetailsPageState();
}

class _MapDetailsPageState extends State<MapDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Details'),
        backgroundColor: Colors.blue,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51, -0.09),
      initialZoom: 13
      ), 
      children: [
        // Add a MapController to control the map programmatically
        MapController(),
      ],
      layers: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(51.5, -0.09),
              builder: (context) => const Icon(Icons.location_on, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
