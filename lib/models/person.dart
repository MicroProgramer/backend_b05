class Person {
  String name;
  int age;
  String gender;

  Person(this.name, this.age, this.gender);


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person (
      map['name'],
      map['age'],
      map['gender'],
    );
  }
}