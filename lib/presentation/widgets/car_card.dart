import 'package:car_rental/data/models/car.dart';
import 'package:car_rental/presentation/pages/card_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardDetailsPage(car: car)),
          ),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        margin: const EdgeInsets.all(10),
        //OUTER CONTAINER
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(5),
          height: 250,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //CONTAINER FOR IMAGE
              Container(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    car.imageUrl,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //CONTAINER FOR CAR NAME AND DETAILS
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child:
                // Car Name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        car.model,
                        style: GoogleFonts.titilliumWeb(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Details Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  //SPEED
                                  const Icon(
                                    Icons.speed,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(car.distance.toString()),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  //FUEL CAPACITY
                                  const Icon(
                                    Icons.local_gas_station,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(car.fuelCapacity.toString()),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              //PRICE
                              const Icon(
                                Icons.attach_money,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '\$ ${car.pricePerHour}/hr',
                                style: TextStyle(
                                  backgroundColor: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
