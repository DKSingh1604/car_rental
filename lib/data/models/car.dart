// ignore_for_file: public_member_api_docs, sort_constructors_first
class Car {
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;
  final String imageUrl;
  final String owner;

  Car({
    required this.model,
    required this.distance,
    required this.fuelCapacity,
    required this.pricePerHour,
    required this.imageUrl,
    required this.owner,
  });

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['model'],
      distance: map['distance'],
      fuelCapacity: map['fuelCapacity'],
      pricePerHour: map['pricePerHour'],
      imageUrl: map['imageUrl'],
      owner: map['owner'],
    );
  }
}
