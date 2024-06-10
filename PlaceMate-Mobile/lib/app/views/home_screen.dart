import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placemate/app/views/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlaceMate'),
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: Get.height * 0.4,
              fit: BoxFit.cover,
            ),
            SizedBox(height: Get.height * 0.1),
            Text(
              'Welcome to PlaceMate',
              style: Get.textTheme.displayMedium!.copyWith(
                color: Get.theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.15),
          ],
        ),
      ),
    );
  }
}
