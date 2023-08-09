class PersonalModel {
  String? gender;
  int? age;
  int? weight;
  int? height;
  int? totalCalories;
  PersonalModel(
      {this.gender, this.age, this.weight, this.height, this.totalCalories});

  // receiving data from server
  factory PersonalModel.fromMap(map) {
    return PersonalModel(
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      totalCalories: map['totalCalories'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'totalCalories': totalCalories,
    };
  }
}
