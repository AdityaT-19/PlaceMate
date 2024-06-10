import 'package:cloud_firestore/cloud_firestore.dart';

class Application {
  final String id;
  final String studentUsn;
  final String companyId;
  final String status;
  final String date;

  Application({
    required this.id,
    required this.studentUsn,
    required this.companyId,
    required this.status,
    required this.date,
  });

  factory Application.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Application(
      id: doc.id,
      studentUsn: data['studentUsn'],
      companyId: data['companyId'],
      status: data['status'],
      date: data['date']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'studentUsn': studentUsn,
      'companyId': companyId,
      'status': status,
      'date': date,
    };
  }
}
