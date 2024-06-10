import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placemate/app/data/companies.dart';
import 'package:placemate/app/models/company.dart';
import 'package:placemate/app/views/company_details.dart';
import 'package:placemate/app/views/drawer.dart';

class CompaniesScreen extends StatelessWidget {
  CompaniesScreen({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: db.collection('company').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Companies found'),
              );
            }
            final companiesList = snapshot.data!.docs;
            companies = companiesList.map((DocumentSnapshot document) {
              return Company.fromFirestore(document);
            }).toList();
            return ListView.builder(
              itemCount: companiesList.length,
              itemBuilder: (context, index) {
                print(companiesList[index].data());
                final company = companies[index];
                return Card(
                  child: ListTile(
                    title: Text(company.name),
                    subtitle: Text(company.jobRole),
                    onTap: () {
                      Get.to(() => CompanyDetailScreen(company: company));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
