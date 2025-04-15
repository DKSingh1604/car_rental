// ignore_for_file: use_build_context_synchronously

import 'package:car_rental/data/models/car.dart';
import 'package:car_rental/presentation/pages/map_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDetailsPage extends StatefulWidget {
  final Car car;
  const CardDetailsPage({super.key, required this.car});

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: Text(
          'Car Details',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // HEADER SECTION
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //INFORMATION ROW
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: Colors.black),
                          Text(
                            'Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //NOTIFICATIONS ROW
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.notifications_active, color: Colors.black),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // NEAREST CAR SECTION
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),

                decoration: BoxDecoration(
                  //color in hex code
                  color: Color.fromARGB(255, 224, 204, 207),

                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'NEAREST CAR',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ), //CAR PHOTO
                    Image.asset(
                      // 'assets/images/civic_bg.png',
                      widget.car.imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    // CAR NAME
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        widget.car.model,
                        style: GoogleFonts.titilliumWeb(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    //CAR DETAILS
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // BATTERY
                              Icon(
                                Icons.battery_4_bar_outlined,
                                color: Colors.grey[700],
                              ),
                              SizedBox(width: 2),
                              Text(
                                '${widget.car.fuelCapacity} km',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // DISTANCE
                              Icon(
                                Icons.directions_walk,
                                color: Colors.grey[700],
                              ),
                              SizedBox(width: 2),
                              Text(
                                '${widget.car.distance.toString()} m',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              // PRICE
                              Icon(Icons.euro, color: Colors.grey[700]),
                              SizedBox(width: 2),
                              Text(
                                '${widget.car.pricePerHour} / h',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // MAPS AND USER DETAILS SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MAP SECTION
                  GestureDetector(
                    onTap: () async {
                      // Navigate to the map page
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MapDetailsPage(car: widget.car),
                        ),
                      );
                    },
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.89),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(16),

                        child: Image.asset(
                          'assets/images/maps.png',
                          fit: BoxFit.fill,
                          height: 200,
                          width: 160,
                          scale: 5.5,
                        ),
                      ),
                    ),
                  ),

                  // User Details Section
                  Expanded(
                    child: Container(
                      height: 200,
                      width: 160,

                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey[700]!,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/user.png',
                                  ),
                                  radius: 30,
                                  backgroundColor: Colors.grey[300],
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                widget.car.owner,
                                style: GoogleFonts.titilliumWeb(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[700],
                                thickness: 5,
                                height: 5,
                              ),
                              Text(
                                '\$2,912.56',
                                style: GoogleFonts.rowdies(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // SAVED FILTER SECTION
              Container(
                height: 130,
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SAVED FILTERS',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),

                    SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            //OFFER ROW
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "3 offers",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            //OFFER DETAILS
                            Row(
                              children: [
                                //DISTANCE
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //DISTANCE
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.navigation,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "500m",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    //BATTERY
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.battery_4_bar_outlined,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "500km",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt_rounded,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
