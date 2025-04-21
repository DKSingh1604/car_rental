import 'package:car_rental/data/models/car_list.dart';
import 'package:car_rental/presentation/bloc/car_bloc.dart';
import 'package:car_rental/presentation/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

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
                child: BlocBuilder<CarBloc, CarState>(
                  builder: (context, state) {
                    if (state is CarLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CarLoadedState) {
                      return ListView.builder(
                        itemCount: state.cars.length,
                        itemBuilder: (context, index) {
                          return CarCard(car: state.cars[index]);
                        },
                      );
                    } else if (state is CarErrorState) {
                      return Center(child: Text("Error: ${state.message}"));
                    } else {
                      return Center(child: Text("No cars available"));
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
