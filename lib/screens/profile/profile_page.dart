import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitahari/screens/profile/edit_profile.dart';
import 'package:mitahari/screens/profile/personal_details.dart';
import 'package:mitahari/screens/starters/signin.dart';

import '../../models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String userId;
  print(userId) {
    // TODO: implement print
    print(userId);
  }

  ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    _firebase.collection("users").doc(widget.userId).get().then((value) {
      setState(() {
        loggedInUser = UserModel.fromMap(value.data());
        print("loggedInUser");
        print(loggedInUser);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF581845),
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Color(0xFFFFC300)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => const Signin()),
                  (route) => false);
              // Perform logout logic here
            },
          ),
        ],
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfilePage(userId: widget.userId)),
                  );
                },
                child: const CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/b4/d4/45/b4d445dc10ee1804a8221139b4ede86f.jpg'),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfilePage(userId: widget.userId)),
                  );
                },
                child: Text(
                  loggedInUser.Name.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "+91 ${loggedInUser.phoneNumber}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(userId: widget.userId)),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF581845),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 50),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Color(0xFFFFC300)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonalDetailsPage(
                                  userId: widget.userId,
                                )),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF581845),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 50),
                      ),
                    ),
                    child: const Text(
                      'Personal details',
                      style: TextStyle(color: Color(0xFFFFC300)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
