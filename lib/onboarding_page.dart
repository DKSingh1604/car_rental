import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: Image.asset('assets/images/onboard5.jpg', fit: BoxFit.cover),
          ),

          // 🔹 Dark Overlay (optional for readability)
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // 🔹 Text and Button
          Positioned(
            left: 20,
            right: 20,
            top: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rent Your Dream Car",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Explore premium cars at the best price.\nDrive with comfort and class.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to next screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("Get Started", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
