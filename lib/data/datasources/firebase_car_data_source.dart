import 'package:car_rental/data/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCarDataSource {
  final FirebaseFirestore firestore;

  FirebaseCarDataSource({required this.firestore});

  Future<void> addCar(Car car) async {
    await firestore.collection('cars').add(car.toMap());
  }

  Future<List<Car>> getCars() async {
    final snapshot = await firestore.collection('cars').get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.data())).toList();
  }
}
