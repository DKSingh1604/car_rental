import 'package:car_rental/data/models/car.dart';

final List<Car> cars = [
  Car(
    model: 'Toyota Fortuner',
    distance: 870,
    fuelCapacity: 50,
    pricePerHour: 45,
    imageUrl: 'assets/images/fortuner_bg.png',
    owner: 'John Doe',
  ),

  Car(
    model: 'Honda Civic',
    distance: 500,
    fuelCapacity: 60,
    pricePerHour: 20,
    imageUrl: 'assets/images/civic_bg.png',
    owner: 'Jane Smith',
  ),

  Car(
    model: 'Nissan GTR',
    distance: 200,
    fuelCapacity: 100,
    pricePerHour: 200,
    imageUrl: 'assets/images/gtr.jpg',
    owner: 'Alice Johnson',
  ),

  Car(
    model: 'Audi R8',
    distance: 40,
    fuelCapacity: 300,
    pricePerHour: 800,
    imageUrl: 'assets/images/r8.jpg',
    owner: 'Bob Brown',
  ),
  Car(
    model: 'Mecerdes G-Wagon',
    distance: 500,
    fuelCapacity: 120,
    pricePerHour: 100,
    imageUrl: 'assets/images/gwagon.jpg',
    owner: 'Charlie Davis',
  ),
];
