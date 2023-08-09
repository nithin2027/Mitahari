import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitahari/models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  String userId;
  EditProfilePage({required this.userId, super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String _name, _phoneNumber, _email;
  final _formKey = GlobalKey<FormState>();
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    _firebase.collection("users").doc(widget.userId).get().then((value) {
      setState(() {
        loggedInUser = UserModel.fromMap(value.data());
        _name = loggedInUser.Name!;
        _phoneNumber = loggedInUser.phoneNumber!;
        _email = loggedInUser.email!;
        // String _address = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF581845),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Color(0xFFFFC300)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save profile information and navigate back to the ProfilePage
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF581845),
                ),
                child: const Text('Save',
                    style: TextStyle(color: Color(0xFFFFC300))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
