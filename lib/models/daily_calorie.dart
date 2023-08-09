class DailyCalories {
  int? breakfast;
  int? lunch;
  int? snacks;
  int? dinner;
  DailyCalories({this.breakfast, this.lunch, this.snacks, this.dinner});

  // receiving data from server
  factory DailyCalories.fromMap(map) {
    return DailyCalories(
      breakfast: map['breakfast'],
      lunch: map['lunch'],
      snacks: map['snacks'],
      dinner: map['dinner'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'breakfast': breakfast,
      'lunch': lunch,
      'snacks': snacks,
      'dinner': dinner,
    };
  }
}
