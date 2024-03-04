
Future<void> main () async {

  var x = 'male';
  var y = 'female';

  var x1 = Gender.male;

}

Future<int> sum(int a, int b) async {
  await Future.delayed(Duration(seconds: 2));
  if ((a + b) % 2 == 0){
    return a+b;
  } else {
    throw ErrorState.oddNum;
  }
}

enum ErrorState {
  oddNum,
  divideByZero
}

enum OrderStatus {
  ordered,
  shipped,
  delivered,
  canceled
}
enum Gender {
  male,
  female,
  other
}

class MyClass {
  int x;
  static int y = 9;

  MyClass(this.x);
}