import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placemate/app/data/student.dart';
import 'package:placemate/app/views/applications.dart';
import 'package:placemate/app/views/companies.dart';
import 'package:placemate/app/views/ctc_input.dart';
import 'package:placemate/app/views/home_screen.dart';
import 'package:placemate/app/views/profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
            ),
            child: Column(
              children: [
                Container(
                  width: Get.width * 0.1,
                  height: Get.width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  student.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  student.usn,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Get.offAll(() => const HomeScreen());
            },
          ),
          ListTile(
            title: const Text('Companies'),
            onTap: () {
              Get.offAll(() => CompaniesScreen());
            },
          ),
          ListTile(
            title: const Text('Applications'),
            onTap: () {
              Get.offAll(() => const ApplicationsScreen());
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Get.offAll(() => const ProfileScreen());
            },
          ),
          ListTile(
            title: const Text('CTC Predictor'),
            onTap: () {
              Get.offAll(() => CtcInputScreen());
            },
          )
        ],
      ),
    );
  }
}
