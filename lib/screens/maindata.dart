import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mitahari/models/daily_calorie.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final _firebase = FirebaseFirestore.instance;

// ignore: camel_case_types, must_be_immutable
class data extends StatefulWidget {
  String userId;
  String type;
  String date;
  data(
      {super.key,
      required this.userId,
      required this.type,
      required this.date});

  @override
  State<data> createState() => _dataState();
}

// ignore: camel_case_types
class _dataState extends State<data> {
  DailyCalories dailyCalories = DailyCalories();
  XFile? image;
  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //Loading the model
  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/food.tflite", labels: "assets/model/food.txt");
  }

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
        .doc(widget.date)
        .get()
        .then((value) {
      setState(() {
        dailyCalories = DailyCalories.fromMap(value.data());
        breakfastCalorie = dailyCalories.breakfast!.toInt();
        lunchCalorie = dailyCalories.lunch!.toInt();
        snacksCalorie = dailyCalories.snacks!.toInt();
        dinnerCalorie = dailyCalories.dinner!.toInt();
      });
    });
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> myResult(String label) async {
    var details = label.split("-");
    // int calories = await calculateCalories(label);
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Calories Details'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //background color of button
                        side: const BorderSide(
                            width: 3,
                            color: Colors.brown), //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(
                            40) //content padding inside button
                        ),
                    onPressed: () {},
                    child: Column(
                      children: [
                        // ignore: prefer_interpolation_to_compose_strings
                        Text("Food: " + details[0]),
                        // ignore: prefer_interpolation_to_compose_strings
                        Text("Calories: " + details[1]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 245, 228, 248),
                        elevation: 0, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        //content padding inside button
                      ),
                      onPressed: () {},
                      child: Row(children: [
                        ElevatedButton(
                          onPressed: () {
                            updateDatabase(
                                widget.userId,
                                widget.date,
                                widget.type,
                                int.parse(details[1]),
                                breakfastCalorie,
                                lunchCalorie,
                                snacksCalorie,
                                dinnerCalorie);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF581845),
                          ),
                          child: const Text('Save',
                              style: TextStyle(color: Color(0xFFFFC300))),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF581845),
                          ),
                          child: const Text('Retake',
                              style: TextStyle(color: Color(0xFFFFC300))),
                        ),
                      ]))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC300)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            const Text(
              "Data Page",
              style: TextStyle(color: Color(0xFFFFC300)),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(widget.type,
                style:
                    const TextStyle(fontSize: 15.0, color: Color(0xFFFFC300))),
          ],
        ),
        backgroundColor: const Color(0xFF581845),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text("This is the Main data Page "),
          image != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      //to show image, you type like this.
                      File(image!.path),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/icons/dummy.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                  ),
                ),
          ElevatedButton(
            onPressed: () async {
              var recognitions = await Tflite.runModelOnImage(
                  path: image!.path, // required
                  imageMean: 40.0, // defaults to 117.0
                  imageStd: 1.0, // defaults to 1.0
                  numResults: 10, // defaults to 5
                  threshold: 0.8, // defaults to 0.1
                  asynch: true // defaults to true
                  );
              myResult(recognitions![0]['label'].toString());
            },
            child: const Text(
              'Predict',
              style: TextStyle(color: Color(0xFF581845)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              myAlert();
            },
            child: const Text(
              'Upload Photo',
              style: TextStyle(color: Color(0xFF581845)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

void updateDatabase(
    String userId,
    String date,
    String type,
    int calories,
    int breakfastCalories,
    int lunchCalories,
    int snacksCalories,
    int dinnerCalories) {
  DailyCalories dailyCalories = DailyCalories();
  dailyCalories.breakfast = breakfastCalories;
  dailyCalories.dinner = dinnerCalories;
  dailyCalories.snacks = snacksCalories;
  dailyCalories.lunch = lunchCalories;
  switch (type) {
    case "breakfast":
      dailyCalories.breakfast = breakfastCalories + calories;
      break;
    case "lunch":
      dailyCalories.lunch = lunchCalories + calories;
      break;
    case "snacks":
      dailyCalories.snacks = snacksCalories + calories;
      break;
    case "dinner":
      dailyCalories.dinner = dinnerCalories + calories;
      break;
  }
  _firebase
      .collection("users")
      .doc(userId)
      .collection("trackInfo")
      .doc(date)
      .update(dailyCalories.toMap())
      .then((value) {
    Fluttertoast.showToast(msg: "Calorie details updated successfully");
  }).catchError((error) {
    Fluttertoast.showToast(msg: "Error while updating calories $error");
  });
}

Future<int> calculateCalories(String item) async {
  var url = Uri.parse('https://trackapi.nutritionix.com/v2/search/instant/');
  var headers = {
    'x-app-id': dotenv.env['x-app-id'],
    'x-app-key': dotenv.env['x-app-key'],
  };
  List<String> res = item.split("_");
  var queryParameters = {'query': res[0]};

  Map<String, String>? headerNullable = headers.cast<String, String>();

  var response = await http.get(url.replace(queryParameters: queryParameters),
      headers: headerNullable);

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body);
    return result['branded'][0]['nf_calories'];
  } else {
    print('Request failed with status: ${response.statusCode}');
    return response.statusCode.toInt();
  }
}
