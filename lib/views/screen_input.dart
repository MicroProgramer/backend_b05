import 'package:b05/controllers/history_controller.dart';
import 'package:b05/views/screen_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen_history_stream.dart';

class ScreenInput extends StatelessWidget {
  const ScreenInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Student Data"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ScreenHistoryStream());
              },
              icon: Icon(Icons.history))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Name'),
                controller: controller.nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Age'),
                controller: controller.ageController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Roll Num'),
                controller: controller.rollNumController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Obx(() {
                return DropdownButton(
                  items: Gender.values
                      .map((gender) =>
                      DropdownMenuItem(
                        value: gender,
                        child: Text(gender.name.capitalizeFirst.toString()),
                      ))
                      .toList(),
                  value: controller.selectedGender.value,
                  onChanged: (value) {
                    controller.selectedGender.value = value!;
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                controller.saveValue();
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
