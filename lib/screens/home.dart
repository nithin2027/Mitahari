import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitahari/models/daily_calorie.dart';
import 'package:mitahari/models/personal_details.dart';
import 'package:mitahari/screens/maindata.dart';

final _firebase = FirebaseFirestore.instance;

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String userId;
  Home({super.key, required this.userId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year, selectedDate.month),
        lastDate: DateTime(selectedDate.year, selectedDate.month + 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  PersonalModel personalModel = PersonalModel();
  DailyCalories dailyCalories = DailyCalories();

  int caloriesConsumed = 0;
  int breakfastCalorie = 0;
  int lunchCalorie = 0;
  int snacksCalorie = 0;
  int dinnerCalorie = 0;
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
      });
    });
    _firebase
        .collection("users")
        .doc(widget.userId)
        .collection("trackInfo")
        .doc("${selectedDate.day}-${selectedDate.month}-${selectedDate.year}")
        .get()
        .then((value) {
      setState(() {
        // ignore: unrelated_type_equality_checks
        dailyCalories = DailyCalories.fromMap(value.data());
        breakfastCalorie = dailyCalories.breakfast!.toInt();
        lunchCalorie = dailyCalories.lunch!.toInt();
        snacksCalorie = dailyCalories.snacks!.toInt();
        dinnerCalorie = dailyCalories.dinner!.toInt();
        caloriesConsumed =
            breakfastCalorie + lunchCalorie + snacksCalorie + dinnerCalorie;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String dateStr =
        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(children: [
            const Text(
              "MITAHARI",
              style: TextStyle(color: Color(0xFFFFC300)),
            ),
            const SizedBox(width: 60),
            Text(
              dateStr,
              style: const TextStyle(fontSize: 10.0, color: Color(0xFFFFC300)),
            ),
          ]),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.date_range_rounded,
                color: Color(0xFFFFC300),
              ),
              tooltip: 'Show Date',
              onPressed: () {
                _selectDate(context);
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
          backgroundColor: const Color(0xFF581845),
          // centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://w0.peakpx.com/wallpaper/565/109/HD-wallpaper-vintage-ink-food-background-material-food-background-food-background-hand-drawn-lettering.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                PhysicalShape(
                  elevation: 5.0,
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  color: const Color(0xFF581845),
                  child: SizedBox(
                    height: 130.0,
                    width: 350.0,
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        'Your Dialy Calorie Intake: ' +
                            personalModel.totalCalories!.toString(),
                        style: const TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        'Consumed Calories: ' + caloriesConsumed.toString(),
                        style: const TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        'Remaining Calories Intake: ' +
                            (personalModel.totalCalories! - caloriesConsumed)
                                .toString(),
                        style: const TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                PhysicalShape(
                  elevation: 5.0,
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  color: const Color(0xFF581845),
                  child: SizedBox(
                    height: 90.0,
                    width: 350.0,
                    child: Row(children: [
                      const SizedBox(width: 50),
                      const Text(
                        'Breakfast',
                        style: TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(width: 150),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: const Color(0xFFFFC300),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => data(
                                  userId: widget.userId,
                                  type: 'breakfast',
                                  date: dateStr,
                                ),
                              )).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                PhysicalShape(
                  elevation: 5.0,
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  color: const Color.fromRGBO(88, 24, 69, 1),
                  child: SizedBox(
                    height: 90.0,
                    width: 350.0,
                    child: Row(children: [
                      const SizedBox(width: 50),
                      const Text(
                        'Lunch      ',
                        style: TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(width: 150),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: const Color(0xFFFFC300),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => data(
                                  userId: widget.userId,
                                  type: 'lunch',
                                  date: dateStr,
                                ),
                              )).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                PhysicalShape(
                  elevation: 5.0,
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  color: const Color(0xFF581845),
                  child: SizedBox(
                    height: 90.0,
                    width: 350.0,
                    child: Row(children: [
                      const SizedBox(width: 50),
                      const Text(
                        'Snacks    ',
                        style: TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(width: 150),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: const Color(0xFFFFC300),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => data(
                                  userId: widget.userId,
                                  type: 'snacks',
                                  date: dateStr,
                                ),
                              )).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                PhysicalShape(
                  elevation: 5.0,
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  color: const Color(0xFF581845),
                  child: SizedBox(
                    height: 90.0,
                    width: 350.0,
                    child: Row(children: [
                      const SizedBox(width: 50),
                      const Text(
                        'Dinner     ',
                        style: TextStyle(
                          color: Color(0xFFFFC300),
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(width: 150),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: const Color(0xFFFFC300),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => data(
                                  userId: widget.userId,
                                  type: 'dinner',
                                  date: dateStr,
                                ),
                              )).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
