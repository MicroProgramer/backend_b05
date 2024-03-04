import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;

import '../controllers/http_data_controller.dart';

class HttpScreen extends StatelessWidget {
  const HttpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HttpDataController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Http test"),
      ),
      body: Obx(
        () => Text("Country: ${controller.currentCountry.value}"),
      ),
    );
  }

  // Future<List<Map<String, dynamic>>> fetchJSONData() async {
  //   final response = await http.get(Uri.parse('https://www.scholaro.com/gpa-calculator/Home/GradingScale?id=285'));
  //   if (response.statusCode == 200) {
  //     final htmlBody = response.body;
  //     final document = htmlParser.parse(htmlBody);
  //     final scriptElement = document.querySelector('script');
  //     final scriptText = scriptElement?.text ?? '';
  //
  //     RegExp regExp = RegExp(r'"Data"\s*:\s*(\[.*?\])');
  //
  //     // Extract the JSON object substring
  //     String jsonSubstring = regExp.firstMatch(scriptText)?.group(1) ?? '';
  //     log(jsonSubstring);
  //     final jsonData = jsonDecode(jsonSubstring) as List<dynamic>;
  //     return jsonData.map((e) => Map<String, dynamic>.from(e)).toList();
  //   } else {
  //     throw Exception('Failed to load HTML');
  //   }
  // }
}
