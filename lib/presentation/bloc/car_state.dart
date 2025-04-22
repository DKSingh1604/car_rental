// part of 'car_bloc.dart';

// @immutable
// abstract class CarState {}

// class CarInitialState extends CarState {}

// class CarLoadingState extends CarState {}

// class CarLoadedState extends CarState {
//   final List<Car> cars;
//   CarLoadedState(this.cars);
// }

// class CarErrorState extends CarState {
//   final String message;
//   CarErrorState(this.message);
// }

import 'package:car_rental/data/models/car.dart';

abstract class CarState {}

class CarInitialState extends CarState {}

class CarLoadingState extends CarState {}

class CarLoadedState extends CarState {
  final List<Car> cars;
  CarLoadedState(this.cars);
}

class CarErrorState extends CarState {
  final String message;
  CarErrorState(this.message);
}
