import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String id;
  final String name;
  final double cgpa;
  final int ctc;
  final String location;
  final String jobRole;
  final String jobDescription;
  final int duration;

  Company({
    required this.id,
    required this.name,
    required this.cgpa,
    required this.ctc,
    required this.location,
    required this.jobRole,
    required this.jobDescription,
    required this.duration,
  });

  factory Company.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Company(
      id: doc.id,
      name: data['name'],
      cgpa: data['cgpa'].toDouble(),
      ctc: data['ctc'],
      location: data['location'],
      jobRole: data['jobRole'],
      jobDescription: data['jobDescription'],
      duration: data['duration'],
    );
  }
}
