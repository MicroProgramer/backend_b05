import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeController extends GetxController {

  RxInt counter = 0.obs;

  void increment() async {
    counter++;
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter.value); //write
  }

  void getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    var savedValue = prefs.getInt('counter') ?? 0; //read
    counter.value = savedValue;
  }

  @override
  void onInit() {
    super.onInit();
    getCounter();
  }

}