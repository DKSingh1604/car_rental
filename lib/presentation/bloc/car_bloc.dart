import 'package:car_rental/data/models/car.dart';
import 'package:car_rental/domain/usecases/get_cars.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetCars getCars;
  CarBloc({required this.getCars}) : super(CarLoadingState()) {
    on<LoadCarEvent>((event, emit) async {
      emit(CarLoadingState());
      try {
        final cars = await getCars.call();
        emit(CarLoadedState(cars));
      } catch (e) {
        emit(CarErrorState(e.toString()));
      }
    });
  }
}
