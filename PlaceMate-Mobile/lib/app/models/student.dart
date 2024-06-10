import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String uid;
  final String usn;
  final String name;
  final int sem;
  final String section;
  final double cgpa;
  final int backlogs;
  final String dept;
  final String resume;
  final String email;

  Student({
    required this.uid,
    required this.usn,
    required this.name,
    required this.sem,
    required this.section,
    required this.cgpa,
    required this.backlogs,
    required this.dept,
    required this.resume,
    required this.email,
  });

  factory Student.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Student(
      uid: doc.id,
      usn: data['usn'],
      name: data['name'],
      sem: data['sem'],
      section: data['section'],
      cgpa: data['cgpa'].toDouble(),
      backlogs: data['backlogs'],
      dept: data['dept'],
      resume: data['resume'],
      email: data['email'],
    );
  }
}
