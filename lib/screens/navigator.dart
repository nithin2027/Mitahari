import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mitahari/models/user_model.dart';
import 'package:mitahari/screens/profile/profile_page.dart';
import 'package:mitahari/screens/cardspage.dart';
import 'home.dart';

// ignore: camel_case_types, must_be_immutable
class navigator extends StatefulWidget {
  const navigator({
    super.key,
  });

  @override
  State<navigator> createState() => _navigatorState();
}

// ignore: camel_case_types
class _navigatorState extends State<navigator> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModel userModel = UserModel();
  @override
  void initState() {
    if (user == null) {
      user?.reload();
    }
    super.initState();
    firebaseFirestore.collection("users").doc(user!.uid).get().then(
          (value) => userModel = UserModel.fromMap(user?.uid),
        );
    setState(() {
      if (kDebugMode) {
        print("UserID${user!.uid}");
      }
    });
  }

  int currentPage = 0;

  late List<Widget> screens = [
    Home(userId: user!.uid),
    const CardsPage(),
    ProfilePage(userId: user!.uid),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            // ignore: unnecessary_null_comparison
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_rounded),
            label: 'Recipes',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
            backgroundColor: Colors.purple,
          ),
        ],
        selectedItemColor: const Color(0xFFFFC300),
        elevation: 5.0,
        unselectedItemColor: Colors.green[900],
        backgroundColor: const Color(0xFF581845),
      ),
    );
  }
}
