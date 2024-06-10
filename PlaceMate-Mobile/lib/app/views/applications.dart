import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placemate/app/data/applications.dart';
import 'package:placemate/app/data/companies.dart';
import 'package:placemate/app/models/application.dart';
import 'package:placemate/app/views/company_details.dart';
import 'package:placemate/app/views/drawer.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('applications').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            applications = snapshot.data!.docs.map((DocumentSnapshot document) {
              return Application.fromFirestore(document);
            }).toList();

            if (applications.isEmpty) {
              return const Center(
                child: Text('No applications found'),
              );
            }
            return ListView.builder(
              itemCount: applications.length,
              itemBuilder: (BuildContext context, int index) {
                final application = applications[index];
                final company = companies.firstWhere(
                    (company) => company.id == application.companyId);

                return ListTile(
                  title: Text(company.name),
                  subtitle: Text(application.status),
                  leading: const Icon(Icons.business),
                  onTap: () {
                    Get.to(() => CompanyDetailScreen(company: company));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
