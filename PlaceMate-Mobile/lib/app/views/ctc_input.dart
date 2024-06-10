import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placemate/app/data/student.dart';
import 'package:placemate/app/views/drawer.dart';
import 'package:http/http.dart' as http;

class CtcInputScreen extends StatefulWidget {
  @override
  _CtcInputScreenState createState() => _CtcInputScreenState();
}

//fields to be taken from the user
/*
  {
  "no_of_dsa": 0,
  "knows_ml": 0,
  "knows_python": 0,
  "knows_dsa": 0,
  "knows_js": 0,
  "knows_html": 0,
  "knows_css": 0,
  "was_coding_club": 0,
  "no_of_backlogs": 0,

}

all are boolean values
*/
class _CtcInputScreenState extends State<CtcInputScreen> {
  final _formKey = GlobalKey<FormState>();
  int noOfDsa = 0;
  bool knowsMl = false;
  bool knowsPython = false;
  bool knowsDsa = false;
  bool knowsJs = false;
  bool knowsHtml = false;
  bool knowsCss = false;
  bool wasCodingClub = false;
  int noOfBacklogs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CTC Input'),
        backgroundColor: Get.theme.primaryColor,
        foregroundColor: Get.theme.colorScheme.onPrimary,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter the following details:',
                  style: Get.textTheme.headlineLarge!.copyWith(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Number of DSA questions solved',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of DSA questions solved';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    noOfDsa = int.parse(newValue!);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Knows Machine Learning'),
                  value: knowsMl,
                  onChanged: (newValue) {
                    setState(() {
                      knowsMl = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Knows Python'),
                  value: knowsPython,
                  onChanged: (newValue) {
                    setState(() {
                      knowsPython = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Knows DSA'),
                  value: knowsDsa,
                  onChanged: (newValue) {
                    setState(() {
                      knowsDsa = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Knows JavaScript'),
                  value: knowsJs,
                  onChanged: (newValue) {
                    setState(() {
                      knowsJs = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Knows HTML'),
                  value: knowsHtml,
                  onChanged: (newValue) {
                    setState(() {
                      knowsHtml = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Knows CSS'),
                  value: knowsCss,
                  onChanged: (newValue) {
                    setState(() {
                      knowsCss = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Was in Coding Club'),
                  value: wasCodingClub,
                  onChanged: (newValue) {
                    setState(() {
                      wasCodingClub = newValue!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Number of Backlogs',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of backlogs';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    noOfBacklogs = int.parse(newValue!);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    foregroundColor: Get.theme.colorScheme.onPrimary,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final int branch = student.dept == 'CSE'
                          ? 0
                          : student.dept == 'EEE'
                              ? 2
                              : student.dept == 'MECH'
                                  ? 1
                                  : 3;
                      final data = {
                        'no_of_dsa': noOfDsa,
                        'knows_ml': knowsMl ? 1 : 0,
                        'knows_python': knowsPython ? 1 : 0,
                        'knows_dsa': knowsDsa ? 1 : 0,
                        'knows_js': knowsJs ? 1 : 0,
                        'knows_html': knowsHtml ? 1 : 0,
                        'knows_css': knowsCss ? 1 : 0,
                        'was_coding_club': wasCodingClub ? 1 : 0,
                        'cgpa': student.cgpa,
                        'branch': branch,
                        'no_of_backlogs': noOfBacklogs,
                      };

                      final Uri url = Uri.parse(
                          'https://placemate-predict-m994.onrender.com/predict');
                      final headers = {
                        'Content-Type': 'application/json',
                      };

                      final response = await http.post(
                        url,
                        headers: headers,
                        body: jsonEncode(data),
                      );
                      final body = jsonDecode(response.body);
                      print(body);
                      Get.dialog(
                        AlertDialog(
                          title: const Text(
                            'Predicted CTC',
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            'The predicted CTC is ${(body['ctc'] as double).toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                            style: Get.textTheme.headlineSmall!.copyWith(
                              color: Get.theme.primaryColor,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                        ),
                      );
                    }
                  },
                  label: const Text('Submit'),
                  icon: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
