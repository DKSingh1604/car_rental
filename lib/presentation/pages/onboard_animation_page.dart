import 'package:car_rental/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardAnimationPage extends StatefulWidget {
  const OnboardAnimationPage({super.key});

  @override
  State<OnboardAnimationPage> createState() => _OnboardAnimationPageState();
}

class _OnboardAnimationPageState extends State<OnboardAnimationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const OnboardingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Lottie.asset(
          'assets/animations/onboarding.json',
          width: 300,
          height: 300,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
