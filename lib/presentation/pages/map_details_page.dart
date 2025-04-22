import 'dart:math';

import 'package:car_rental/data/models/car.dart' as models;
import 'package:car_rental/presentation/pages/car_book_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapDetailsPage extends StatefulWidget {
  final models.Car car;
  const MapDetailsPage({super.key, required this.car});

  @override
  State<MapDetailsPage> createState() => _MapDetailsPageState();
}

class _MapDetailsPageState extends State<MapDetailsPage> {
  LatLng? _currentPosition;
  LatLng? _carPosition;
  double? _carDistanceMeters;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  LatLng getRandomNearbyLocation(LatLng origin, double radiusInMeters) {
    final random = Random();
    // Convert radius from meters to degrees
    final radiusInDegrees = radiusInMeters / 111320.0;

    final u = random.nextDouble();
    final v = random.nextDouble();
    final w = radiusInDegrees * sqrt(u);
    final t = 2 * pi * v;
    final x = w * cos(t);
    final y = w * sin(t);

    // Adjust the x-coordinate for the shrinking of the east-west distances
    final newX = x / cos(origin.latitude * pi / 180);

    final foundLongitude = origin.longitude + newX;
    final foundLatitude = origin.latitude + y;

    return LatLng(foundLatitude, foundLongitude);
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final userLatLng = LatLng(position.latitude, position.longitude);
    final carLatLng = getRandomNearbyLocation(userLatLng, 2000); // 2km radius

    // Calculate distance in meters
    final distance = Geolocator.distanceBetween(
      userLatLng.latitude,
      userLatLng.longitude,
      carLatLng.latitude,
      carLatLng.longitude,
    );

    setState(() {
      _currentPosition = userLatLng;
      _carPosition = carLatLng;
      _carDistanceMeters = distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Location',
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        backgroundColor: Colors.transparent,
      ),
      body:
          _currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: _currentPosition!,
                      initialZoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentPosition!,
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            child: Icon(
                              Icons.my_location,
                              color: Colors.blue,
                              size: screenWidth * 0.1,
                            ),
                          ),
                          if (_carPosition != null)
                            Marker(
                              point: _carPosition!,
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                              child: Icon(
                                Icons.directions_car,
                                color: Colors.red,
                                size: screenWidth * 0.1,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: carDetailsCard(widget.car, _carDistanceMeters),
                  ),
                ],
              ),
    );
  }
}

Widget carDetailsCard(dynamic car, double? distanceMeters) {
  return Builder(
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      return SizedBox(
        height: screenHeight * 0.45,
        child: Stack(
          children: [
            //Black container with car name and details
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.07),
                  topRight: Radius.circular(screenWidth * 0.07),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    car.model,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: screenWidth * 0.04,
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "${distanceMeters != null ? distanceMeters.toStringAsFixed(0) : car.distance} m",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.025),
                      Icon(
                        Icons.battery_full,
                        color: Colors.white,
                        size: screenWidth * 0.04,
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "${car.fuelCapacity} km",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //White container with features and price
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.05),
                    topRight: Radius.circular(screenWidth * 0.05),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Features",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      featureIcons(context),
                      SizedBox(height: screenHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${car.pricePerHour}/hr',
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Button Pressed');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CarBookForm(car: car),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.06,
                                vertical: screenHeight * 0.013,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.055,
                                ),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.025),
                    ],
                  ),
                ),
              ),
            ),
            //Car image
            Positioned(
              width:
                  screenWidth * 0.6, // 60% of screen width instead of fixed 250
              height:
                  screenWidth * 0.6, // Keep it square by using same dimension
              top:
                  screenHeight * 0.01, // 1% of screen height instead of fixed 6
              right: screenWidth * 0.01,

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(car.imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget featureIcons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      featureIcon(context, Icons.local_gas_station, 'Diesel', 'Common Rail'),
      featureIcon(context, Icons.speed, 'Acceleration', '0 - 100km/s'),
      featureIcon(context, Icons.ac_unit, 'Cold', 'Temp control'),
    ],
  );
}

Widget featureIcon(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenWidth * 0.25,
    height: screenHeight * 0.12,
    padding: EdgeInsets.all(screenWidth * 0.012),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(screenWidth * 0.025),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: screenWidth * 0.07),
        Text(title, style: TextStyle(fontSize: screenWidth * 0.030)),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.025),
        ),
      ],
    ),
  );
}
