import 'package:car_rental/data/datasources/firebase_car_data_source.dart';
import 'package:car_rental/data/models/car.dart';
import 'package:car_rental/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final FirebaseCarDataSource dataSource;

  CarRepositoryImpl(this.dataSource);

  @override
  Future<List<Car>> fetchCars() {
    return dataSource.getCars();
  }
}
