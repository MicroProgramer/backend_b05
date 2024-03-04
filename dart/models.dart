void main() {
  var person = Person("Arslan", 23, 'Male');
  var person1 = Person("Ali", 20, 'Male');
  var person2 = Person("Afia", 20, 'Female');

  person2.printAll();

}

class Person {
  String name;
  int age;
  String gender;

  Person(this.name, this.age, this.gender);

  void printAll(){
    print("Name: $name, Age: $age, Gender: $gender");
  }
}