class Student {
  String name, gender;
  int age, rollNum;
//milliseconds
  int timestamp;

  Student({
    required this.name,
    required this.gender,
    required this.age,
    required this.rollNum,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'rollNum': rollNum,
      'timestamp': timestamp,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],
      gender: map['gender'],
      age: map['age'],
      rollNum: map['rollNum'],
      timestamp: map['timestamp'],
    );
  }
}