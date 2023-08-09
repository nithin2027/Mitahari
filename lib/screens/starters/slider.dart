import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mitahari/models/daily_calorie.dart';
import 'package:mitahari/models/personal_details.dart';
import 'package:mitahari/screens/navigator.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: use_key_in_widget_constructors
class IntroScreenDemo extends StatefulWidget {
  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {
  final _auth = FirebaseAuth.instance;
  // 1. Define a `GlobalKey` as part of the parent widget's state
  final _introKey = GlobalKey<IntroductionScreenState>();
  String gender = "male";
  int age = 20;
  int height = 150;
  int weight = 40;

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      bodyPadding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
      pages: [
        PageViewModel(
          title: 'Input your information to calculate your daily calorie goal',
          bodyWidget: const Column(
            children: [
              Text("This is MITAHARI TEAM"),
            ],
          ),
          decoration: const PageDecoration(
            pageColor: Color(0xFF581845),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFF77406)),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w900, fontSize: 40.0),
          ),
        ),
        PageViewModel(
          title: 'Input your information to calculate your daily calorie goal',
          bodyWidget: Column(children: [
            const SizedBox(height: 50),
            const Text('Choose your gender',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 223, 83, 18))),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                gender = "Male";
              },
              child: const Text("Male"),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                gender = "Female";
              },
              child: const Text("Female"),
            ),
            const SizedBox(height: 50),
            const Text('Choose your age (in years)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 223, 83, 18))),
            NumberPicker(
              value: age,
              minValue: 0,
              maxValue: 100,
              onChanged: (value) => setState(() => age = value),
            ),
          ]),
          decoration: const PageDecoration(
            pageColor: Color(0xFF581845),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFF77406)),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w900, fontSize: 40.0),
          ),
        ),
        PageViewModel(
          title: 'Input your information to calculate your daily calorie goal',
          bodyWidget: Column(children: [
            const SizedBox(height: 50),
            const Text('Choose your height (in cms)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 223, 83, 18))),
            NumberPicker(
              value: height,
              minValue: 100,
              maxValue: 300,
              onChanged: (value) => setState(() => height = value),
            ),
            const SizedBox(height: 50),
            const Text('Choose your weight (in kgs)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 223, 83, 18))),
            NumberPicker(
              value: weight,
              minValue: 0,
              maxValue: 100,
              onChanged: (value) => setState(() => weight = value),
            ),
          ]),
          decoration: const PageDecoration(
            pageColor: Color(0xFF581845),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFF77406)),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
      ],
      showNextButton: true,
      showDoneButton: true,
      skip: const Text("Skip"),
      next: const Text("Next"),
      done: const Text("Done"),
      onDone: () => {
        postDetailsToFirestore(),
      },
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    PersonalModel personalModel = PersonalModel();
    DailyCalories dailyCalories = DailyCalories();
    //writing all the calories values to zero intially for 20 days for the perticualar user
    dailyCalories.breakfast = 0;
    dailyCalories.lunch = 0;
    dailyCalories.snacks = 0;
    dailyCalories.dinner = 0;
    DateTime selectedDate = DateTime.now();
    // ignore: no_leading_underscores_for_local_identifiers, unused_element
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2023, 5),
          lastDate: DateTime(2100));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    var now = DateTime(selectedDate.year, selectedDate.month);
    var totalDays = daysInMonth(now);
    List<String> listOfDates = List<String>.generate(
        totalDays - selectedDate.day,
        (i) =>
            "${i + selectedDate.day}-${selectedDate.month}-${selectedDate.year}");

    print(listOfDates);
    int size = listOfDates.length;

    if (size < 30) {
      now = DateTime(selectedDate.year, selectedDate.month + 1);
      var totalDays = daysInMonth(now);
      listOfDates.addAll(List<String>.generate(totalDays - size,
          (i) => "${i + 1}-${selectedDate.month}-${selectedDate.year}"));
    }

    for (int i = 0; i < listOfDates.length; i++) {
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection("trackInfo")
          .doc(listOfDates[i])
          .set(dailyCalories.toMap());
    }
    // writing all the values
    personalModel.gender = gender;
    personalModel.age = age;
    personalModel.weight = weight;
    personalModel.height = height;
    personalModel.totalCalories =
        calaculateCalories(gender, age, height, weight);

    await firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .collection("trackInfo")
        .doc("personalDetails")
        .set(personalModel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully :) Login to Continue");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => const navigator()), (route) => false);
  }
}

int calaculateCalories(String gender, int age, int height, int weight) {
  double bmr = 0;
  if (gender == "Male") {
    bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
  } else {
    bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
  }
  return bmr.round();
}

int daysInMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}
