import 'package:car_rental/data/models/car.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 66, 70, 78),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                car.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // Car Name
            Text(
              car.model,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    //SPEED
                    const Icon(Icons.speed, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(car.distance.toString()),
                  ],
                ),
                Row(
                  children: [
                    //FUEL CAPACITY
                    const Icon(
                      Icons.local_gas_station,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(car.fuelCapacity.toString()),
                  ],
                ),
                Row(
                  children: [
                    //PRICE
                    const Icon(
                      Icons.attach_money,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text('\$${car.pricePerHour}/hr'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
