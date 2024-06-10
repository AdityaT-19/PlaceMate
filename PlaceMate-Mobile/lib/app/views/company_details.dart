import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:placemate/app/data/applications.dart';
import 'package:placemate/app/data/student.dart';
import 'package:placemate/app/models/application.dart';
import 'package:placemate/app/models/company.dart';
import 'package:placemate/app/views/home_screen.dart';

class CompanyDetailScreen extends StatelessWidget {
  final Company company;
  const CompanyDetailScreen({super.key, required this.company});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text('Company Name'),
              subtitle: Text(company.name),
              leading: const Icon(Icons.business),
            ),
            ListTile(
              title: Text('Job Role'),
              subtitle: Text(company.jobRole),
              leading: const Icon(Icons.work),
            ),
            ListTile(
              title: Text('Location'),
              subtitle: Text(company.location),
              leading: const Icon(Icons.location_on),
            ),
            ListTile(
              title: Text('CGPA Requirement'),
              subtitle: Text(company.cgpa.toString()),
              leading: const Icon(Icons.school),
            ),
            ListTile(
              title: Text('CTC'),
              subtitle: Text(company.ctc.toString()),
              leading: const Icon(Icons.attach_money),
            ),
            ListTile(
              title: Text('Duration'),
              subtitle: Text('${company.duration} months'),
              leading: const Icon(Icons.calendar_today),
            ),
            ListTile(
              title: Text('Job Description'),
              subtitle: Text(company.jobDescription),
              leading: const Icon(Icons.description),
            ),
            SizedBox(height: Get.height * 0.1),
            if (applications.any((application) =>
                application.companyId == company.id &&
                application.studentUsn == student.usn))
              Text(
                'You have already applied to this company',
                style: Get.textTheme.headlineMedium!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              )
            else if (student.cgpa >= company.cgpa)
              ElevatedButton.icon(
                onPressed: () {
                  final Map<String, dynamic> data = {
                    'companyId': company.id,
                    'studentUsn': student.usn,
                    'status': 'Applied',
                    'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  };
                  final db = FirebaseFirestore.instance;
                  final doc = db.collection('applications').add(data);
                  doc.then((value) {
                    print('Application added with ID: ${value.id}');
                  });

                  Get.snackbar(
                    'Applied',
                    'You have successfully applied to ${company.name}',
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Get.theme.colorScheme.onPrimaryContainer,
                    backgroundColor: Get.theme.colorScheme.primaryContainer,
                    duration: const Duration(seconds: 3),
                  );
                  Get.offAll(HomeScreen());
                },
                label: Text(
                  'Apply',
                  style: Get.textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                icon: const Icon(Icons.send),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.all(20),
                ),
              )
            else
              Text(
                'You do not meet the CGPA requirement for this company',
                style: Get.textTheme.headlineMedium!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
