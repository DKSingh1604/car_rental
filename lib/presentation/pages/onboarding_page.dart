import 'package:car_rental/presentation/pages/car_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rental/presentation/bloc/car_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboard9.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Dark Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          // 🔹 Text and Button
          Positioned(
            left: 20,
            right: 20,
            top: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rent Your Dream Car Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Explore premium cars at the best price.\nDrive with comfort and class.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 160),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to car list screen but don't dispatch event
                      // The CarListScreen will handle the event dispatch itself
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                          ) {
                            return BlocProvider.value(
                              value: context.read<CarBloc>(),
                              child: CarListScreen(),
                            );
                          },
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            const begin = Offset(
                              1.0,
                              0.0,
                            ); // Slide from right to left
                            const end = Offset.zero;
                            const curve = Curves.ease;
                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 400),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.grey, // 👈 adds ripple color
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      splashFactory:
                          InkRipple.splashFactory, // 👈 ensures ripple effect
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
