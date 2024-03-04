import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/students.dart';

class HistoryController extends GetxController {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var rollNumController = TextEditingController();
  var selectedGender = Gender.male.obs;

  RxList<Student> students = <Student>[].obs;

  void saveValue() async {
    var name = nameController.text;
    var age = int.tryParse(ageController.text) ?? 0;
    var rollNum = int.tryParse(rollNumController.text) ?? 0;
    var timestamp = DateTime.now().millisecondsSinceEpoch;


    if (name.isEmpty || age == 0 || rollNum == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('All values are required')));
      return;
    }


    var student = Student(
      name: name,
      age: age,
      rollNum: rollNum,
      timestamp: timestamp,
      gender: selectedGender.value.name
    );

    var map = student.toMap();
    var stringValue = jsonEncode(map);
    var oldData = await getOldData();
    oldData.add(stringValue);
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('historyList', oldData);
    nameController.clear();
    ageController.clear();
    rollNumController.clear();
  }

  void deleteObj(Student student) {
    var local = (GetStorage().read('historyList') as List? ?? []).toStudentsObjects();
    local.removeWhere((element) => element.rollNum == student.rollNum);
    print(local.length);
    GetStorage().write('historyList', local.map((e) => jsonEncode(e.toMap())).toList());
  }
  void saveObj(Student student)  {
    var map = student.toMap();
    var stringValue = jsonEncode(map);
    var oldData = getOldDataSync();
    oldData.add(stringValue);
    GetStorage().write('historyList', oldData);
    // var prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList('historyList', oldData);
    // students.value = (getOldDataSync()).map((e) => Student.fromMap(jsonDecode(e) as Map<String, dynamic>)).toList();
  }


  Future<List<String>> getOldData() async {
    // await Future.delayed(Duration(seconds: 3));
    // throw 'Bazigar';
    var prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('historyList') ?? [];
  }

   List<String> getOldDataSync() {
    return (GetStorage().read('historyList') as List? ?? []).map((e) => e.toString()).toList();
  }
  Future<void> clearHistory() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('historyList');
  }

  List<Student> toStudentsObjects(List<String> data) {
    return data.map((element) {
      var map = jsonDecode(element) as Map<String, dynamic>;
      return Student.fromMap(map);
    }).toList();
  }

  Student getFakeObj() {
    var faker = Faker();
    return Student(
      name: faker.person.name(),
      age: Random().nextInt(100),
      rollNum: Random().nextInt(1000),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      gender: Gender.values[Random().nextInt(2)].name
    );
  }

  void addRandomStudent() {
    saveObj(getFakeObj());
  }

  @override
  void onInit() {
    super.onInit();

    students.value = (GetStorage().read('historyList') as List<dynamic>? ?? []).toStudentsObjects();

    GetStorage().listenKey('historyList', (value) {
      students.value = (value as List<dynamic>? ?? []).toStudentsObjects();
    });
  }
}

extension on Iterable {
  List<Student> toStudentsObjects() {
    return this.map((element) {
      var map = jsonDecode(element.toString()) as Map<String, dynamic>;
      return Student.fromMap(map);
    }).toList();
  }
}


enum Gender {
  male, female, other
}