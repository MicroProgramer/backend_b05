import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class ScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasbeeh Calculator'),
      ),
      body: Center(
        child: Obx(() {
          return Text(
            '${controller.counter.value}',
            style: Theme
                .of(context)
                .textTheme
                .headline4,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
