import 'package:car_rental/data/datasources/firebase_car_data_source.dart';
import 'package:car_rental/data/models/car_list.dart';
import 'package:car_rental/domain/usecases/get_cars.dart';
import 'package:car_rental/firebase_options.dart';
import 'package:car_rental/injection_container.dart';
import 'package:car_rental/presentation/bloc/car_bloc.dart';
import 'package:car_rental/presentation/pages/onboard_animation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initInjection();
  await uploadAllCars(getIt<FirebaseCarDataSource>());
  runApp(
    BlocProvider(
      create: (context) => CarBloc(getCars: GetCars(getIt())),
      child: MyApp(),
    ),
  );
}

Future<void> uploadAllCars(FirebaseCarDataSource dataSource) async {
  for (final car in cars) {
    await dataSource.addCar(car);
  }
  print('All cars uploaded!');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  FirebaseFirestore db = FirebaseFirestore.instance;

  void _addUser() {
    final user = {
      "firstName": "Dev Karan",
      "lastName": "Singh",
      "born": "April 2004",
      "email": "heheboi@gmail.com",
    };
    db
        .collection("users")
        .add(user)
        .then(
          (DocumentReference doc) => {print("User added with ID: ${doc.id}")},
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardAnimationPage(),
    );
  }
}
