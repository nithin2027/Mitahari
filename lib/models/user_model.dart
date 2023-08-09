class UserModel {
  String? uid;
  String? email;
  // ignore: non_constant_identifier_names
  String? Name;
  String? phoneNumber;

  // ignore: non_constant_identifier_names
  UserModel({this.uid, this.email, this.Name, this.phoneNumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      Name: map['Name'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Name': Name,
      'phoneNumber': phoneNumber,
    };
  }
}
