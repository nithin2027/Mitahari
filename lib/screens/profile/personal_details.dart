import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitahari/models/personal_details.dart';

final _firebase = FirebaseFirestore.instance;

// ignore: must_be_immutable
class PersonalDetailsPage extends StatefulWidget {
  String userId;
  PersonalDetailsPage({super.key, required this.userId});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  PersonalModel personalModel = PersonalModel();
  late double weight = 60;
  late double height = 170;
  late String gender = 'Male';
  late double age = 20;

  @override
  void initState() {
    super.initState();
    _firebase
        .collection("users")
        .doc(widget.userId)
        .collection("trackInfo")
        .doc("personalDetails")
        .get()
        .then((value) {
      setState(() {
        // ignore: unrelated_type_equality_checks
        personalModel = PersonalModel.fromMap(value.data());
        weight = personalModel.weight! as double;
        height = personalModel.height! as double;
        gender = personalModel.gender!;
        age = personalModel.age! as double;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF581845),
        title: const Text(
          'Personal Details',
          style: TextStyle(color: Color(0xFFFFC300)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.accessibility),
            title: const Text('Weight'),
            subtitle: Text('${weight.toStringAsFixed(1)} kg'),
            onTap: () {
              _showWeightDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.height),
            title: const Text('Height'),
            subtitle: Text('${height.toStringAsFixed(1)} cm'),
            onTap: () {
              _showHeightDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Gender'),
            subtitle: Text(gender),
            onTap: () {
              _showGenderDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.cake),
            title: const Text('Age'),
            subtitle: Text('$age'),
            onTap: () {
              _showAgeDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showWeightDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Weight'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${weight.toStringAsFixed(1)} kg'),
                  const SizedBox(height: 16),
                  Slider(
                    value: weight,
                    min: 1,
                    max: 500,
                    onChanged: (value) {
                      setState(() {
                        weight = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                // Save weight to database or perform any other logic
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  void _showHeightDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Height'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${height.toStringAsFixed(1)} cm'),
                  const SizedBox(height: 16),
                  Slider(
                    value: height,
                    min: 50,
                    max: 300,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                // Save height to database or perform any other logic
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  void _showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Male'),
                leading: Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as String;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as String;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: const Text('Other'),
                leading: Radio(
                  value: 'Other',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as String;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Age'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('$age'),
                  const SizedBox(height: 16),
                  Slider(
                    value: age.toDouble(),
                    min: 5,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        age = value.toInt() as double;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                // Save age to database or perform any other logic
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }
}
