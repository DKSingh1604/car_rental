import 'package:car_rental/firebase_options.dart';
import 'package:car_rental/onboarding_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void _addUser() {
    final user = {
      "firestName": "Dev Karan",
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
      home: OnboardingPage(),
    );
  }
}
