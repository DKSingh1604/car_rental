import 'package:car_rental/presentation/bloc/car_bloc.dart';
import 'package:car_rental/presentation/bloc/car_state.dart';
import 'package:car_rental/presentation/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    // Explicitly dispatch the event when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('CarListScreen: Dispatching LoadCarEvent');
      context.read<CarBloc>().add(LoadCarEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Column(
            children: [
              Text(
                'CHOOSE YOUR CAR',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Expanded(
                child: BlocConsumer<CarBloc, CarState>(
                  listener: (context, state) {
                    print(
                      'CarListScreen: State changed to ${state.runtimeType}',
                    );
                    if (state is CarErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${state.message}')),
                      );
                    }
                  },
                  builder: (context, state) {
                    print(
                      'CarListScreen: Building UI with state ${state.runtimeType}',
                    );
                    if (state is CarLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CarLoadedState) {
                      print('CarListScreen: Loaded ${state.cars.length} cars');
                      final filteredCars =
                          _searchQuery.isEmpty
                              ? state.cars
                              : state.cars.where((car) {
                                final name = car.model?.toLowerCase() ?? '';

                                return name == _searchQuery;
                              }).toList();
                      if (filteredCars.isEmpty) {
                        return const Center(
                          child: Text(
                            'No cars found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (state.cars.isEmpty) {
                        return const Center(
                          child: Text(
                            'No cars available',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: filteredCars.length,
                        itemBuilder: (context, index) {
                          return CarCard(car: state.cars[index]);
                        },
                      );
                    } else if (state is CarErrorState) {
                      return Center(
                        child: Text(
                          "Error: ${state.message}",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      // This handles CarInitialState or any other unexpected state
                      return const Center(
                        child: Text(
                          "No cars available",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
