import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitahari/models/user_model.dart';
import 'package:mitahari/screens/starters/signin.dart';
import 'package:mitahari/screens/starters/slider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();
  final phonenumberEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://w0.peakpx.com/wallpaper/565/109/HD-wallpaper-vintage-ink-food-background-material-food-background-food-background-hand-drawn-lettering.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Positioned(
                //     top: 0,
                //     child: SvgPicture.asset(
                //       'images/top.svg',
                //       width: 400,
                //       height: 50,
                //     )),
                Container(
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                "Signup",
                                style: GoogleFonts.pacifico(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                    color: const Color(0xFF581845)),
                              ),
                              // Rest of the code
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: nameEditingController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter something';
                                } else if (value.length >= 6) {
                                  return null;
                                } else {
                                  return 'Enter valid details';
                                }
                              },
                              decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.account_circle_outlined,
                                    color: Color(0xFF581845),
                                  ),
                                  hintText: 'Enter Name',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: emailEditingController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter something';
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Enter valid details';
                                }
                              },
                              decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.email,
                                    color: Color(0xFF581845),
                                  ),
                                  hintText: 'Enter Email',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: phonenumberEditingController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter something';
                                } else if (value.length >= 10) {
                                  return null;
                                } else {
                                  return 'Enter valid details';
                                }
                              },
                              decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.local_phone,
                                    color: Color(0xFF581845),
                                  ),
                                  hintText: 'Enter phonenumber',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: passwordEditingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter something';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.vpn_key,
                                    color: Color(0xFF581845),
                                  ),
                                  hintText: 'Enter Password',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF581845))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade900))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                            child: SizedBox(
                              height: 50,
                              width: 300,
                              child: FloatingActionButton(
                                  backgroundColor: const Color(0xFF581845),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  onPressed: () {
                                    signUp(emailEditingController.text,
                                        passwordEditingController.text);
                                  },
                                  child: const Text(
                                    "Signup",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    "  Already have Account ? ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Signin(),
                                          ));
                                    },
                                    child: const Text(
                                      "Signin",
                                      style: TextStyle(
                                          color: Color(0xFFFFC300),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            // ignore: body_might_complete_normally_catch_error
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.Name = nameEditingController.text;
    userModel.phoneNumber = phonenumberEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => IntroScreenDemo()),
        (route) => false);
  }
}
