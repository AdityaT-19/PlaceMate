import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placemate/app/data/applications.dart';
import 'package:placemate/app/data/companies.dart';
import 'package:placemate/app/data/student.dart';
import 'package:placemate/app/models/application.dart';
import 'package:placemate/app/models/company.dart';
import 'package:placemate/app/models/student.dart';
import 'package:placemate/app/views/home_screen.dart';
import 'package:placemate/app/views/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData &&
            snapshot.data != null &&
            FirebaseAuth.instance.currentUser != null) {
          final db = FirebaseFirestore.instance;
          final user = FirebaseAuth.instance.currentUser;
          final doc = db.collection('student').doc(user!.uid);

          final curentStudent = doc.get();
          curentStudent.then((value) {
            student = Student.fromFirestore(value);
            db
                .collection('applications')
                .where(
                  'studentUsn',
                  isEqualTo: student.usn,
                )
                .snapshots()
                .listen((event) {
              applications = event.docs.map((e) {
                return Application.fromFirestore(e);
              }).toList();
            });
          });
          db.collection('company').snapshots().listen((event) {
            companies = event.docs.map((e) {
              return Company.fromFirestore(e);
            }).toList();
          });
          return const HomeScreen();
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('An error occurred'),
            ),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
