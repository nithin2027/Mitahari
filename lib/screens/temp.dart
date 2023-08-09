import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class temp extends StatelessWidget {
  String gender;
  int age, height, weight;

  var calories;
  temp(
      {super.key,
      required this.gender,
      required this.age,
      required this.height,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    calories = calaculateCalories(gender, age, height, weight);
    return Scaffold(
        appBar: AppBar(
          title: const Text("This is Profile Page"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gender: $gender'),
                Text('Age: $age'),
                Text('Height: $height'),
                Text('Weight: $weight'),
                // ignore: prefer_interpolation_to_compose_strings
                Text("Calories:" + calories,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF7F12DF))),
              ],
            ),
          ),
        ));
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
