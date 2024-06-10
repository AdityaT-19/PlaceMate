import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placemate/app/data/student.dart';
import 'package:placemate/app/views/drawer.dart';
import 'package:placemate/app/views/login_screen.dart';
import 'package:placemate/app/views/pdf_viewer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(LoginScreen());
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Name'),
                  subtitle: Text(student.name),
                  leading: const Icon(Icons.person),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('USN'),
                  subtitle: Text(student.usn),
                  leading: const Icon(Icons.confirmation_number),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('CGPA'),
                  subtitle: Text(student.cgpa.toString()),
                  leading: const Icon(Icons.school),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Depatment'),
                  subtitle: Text(student.dept),
                  leading: const Icon(Icons.apartment),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Semester'),
                  subtitle: Text(student.sem.toString()),
                  leading: const Icon(Icons.calendar_today),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Backlogs'),
                  subtitle: Text(student.backlogs.toString()),
                  leading: const Icon(Icons.warning_rounded),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Resume'),
                  leading: const Icon(Icons.file_open),
                  onTap: () {
                    Get.to(
                      () => PdfViewer(
                        path: student.resume,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
